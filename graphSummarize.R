## cds-group - ICAR-CNR, Naples, 
## Ichcha Manipur, Ilaria Granata, Lucia Maddalena and Mario R Guarracino, Clustering Analysis of Tumor Metabolic Networks, Accepted (2020)

library(igraph)
#' Extract the largest connected component from the given graph
#'
#' @param g - undirected weighted graph 
#' @import igraph
#' 
getlargestCC <- function(g){
  conn_comp <- components(g)
  max_idx <- which(conn_comp$csize==max(conn_comp$csize))
  conn_comp_vert <- groups(conn_comp)
  vertices_largest_cc <- as.data.frame(conn_comp_vert[max_idx][1])
  all_vertices <- V(g)
  vertices_remove <- names(all_vertices)[-(which(names(all_vertices)
                                                 %in%vertices_largest_cc[,1]))]
  
  g_cc <- delete.vertices(g, V(g)[vertices_remove])
  return(g_cc)
}

#' Retrieve cluster memberships of the graph vertices after spectral clustering
#'
#' @param g undirected graph
#' @param k number of clusters required
#'
#' @return dataframe with
#' @import fcd
#' @import igraph
#'
#' @examples
getspectralClusterMembership <- function(g, k=50){
  require(fcd)
  A <-  as_adjacency_matrix(g)
  memb_cluster <- spectral.clustering(A, K = k)
  memb_cluster <- t(as.data.frame(memb_cluster))
  colnames(memb_cluster) <- as_ids(V(g))
  max(memb_cluster)
  return(memb_cluster)
}

#' Indicator matrix of cluster memberships
#'
#' @param memb_cluster vector of cluster memberships of vertices
#'
#' @import igraph
#'
#' @examples
getIndicatorMatrix <- function(memb_cluster){
  # Initialize an indicator matrix to assign cluster membership    
  indicator_matrix <- data.frame(matrix(NA, nrow = length(memb_cluster), 
                                        ncol = max(memb_cluster)))
  colnames(indicator_matrix) <- 1:max(memb_cluster)
  rownames(indicator_matrix) <- colnames(memb_cluster)
  # extract cluster memberships and populate the indicator matrix
  for (num_clusters in 1:max(memb_cluster)){
    indicator_vector <- t(memb_cluster)
    indicator_vector[which(indicator_vector!=num_clusters)] <- 0
    indicator_vector[which(indicator_vector==num_clusters)] <- 1
    indicator_matrix[, num_clusters]  <- indicator_vector
  }
  return(as.matrix(indicator_matrix))
}

#' Summarize graphs using the indicator matrix (N x k)
#'
#' @param g undirected, weighted graph
#' @param indicator_matrix Nxk matrixwhere N-number of nodes 
#' and k- number of clusters. Contains the cluster membership of all nodes
#'
#' @return Summarized graph with k nodes (equal to number of columns of the
#' indicator_matrix)
#' @export
#'
#' @examples
getSummarizedGraph <- function(g, indicator_matrix){
  #extract the weighted adjacency matrix
  A <- as_adjacency_matrix(g, attr = "weight")
  indicator_matrix_trans <- t(indicator_matrix)
  # Summarization: collapse cluster members and their weights to 
  # form a summarized network with k nodes
  new_adj_matrix <- indicator_matrix_trans%*%A%*%indicator_matrix
  graphSumm <- graph_from_adjacency_matrix(as.matrix(new_adj_matrix), 
                                           weighted = TRUE, mode = "undirected")
  graphSumm <- simplify(graphSumm)
  return(graphSumm)
}

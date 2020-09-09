# GraphSummarize

Data and code to cluster and summarize vertices of undirected weighted graphs.

### Data description
The [Data/KidneyData](Data/KidneyData) folder contains metabolic networks of 299 Kidney cancer samples (TCGA-KIRC and TCGA-KIRP), used for the network clustering study in [1]. These networks were constructed following the methods detailed in [2] and [3]. The dataset contains both whole graphs (4022 nodes) and summarized graphs (250 nodes) in graphml format. The folder also contains [annotation](Data/KidneyData/kidneyGraphAnnotation.txt) for the TCGA samples. The precomputed vertex [cluster members](Data/KidneyData/250_memb_cluster.txt) and [indicator matrix](Data/KidneyData/250_cluster_indicator_matrix.txt) obtained with spectral clustering are also included.

Note: Extract the compressed files (WholeGraphs.zip and SummarizedGraphs.zip) after downloading.

### Code for graph summarization
The functions (in R) required for clustering, obtaining indicator matrices and graph summarization can be found in [graphSummarize.R](graphSummarize.R).
``` 
# Requires the following packages
install.packages(c("igraph", "fcd"))
```
** The [RunGraphSummarize.Rmd](RunGraphSummarize.Rmd) file contains the code used to extract the clusters and construct the summarized graphs in [1]. Note: You can input your cluster membership vectors ([example format](Data/KidneyData/250_memb_cluster.txt)) from your node clustering algorithms in the memb_clust variable on line 46. 

### References
[1] Manipur, I., Granata, I., Maddalena, L. and Guarracino, M.R., 2020. Clustering analysis of tumor metabolic networks. BMC bioinformatics, 21(10), pp.1-14. https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-020-03564-9

[2] Granata, I., Guarracino, M.R., Kalyagin, V.A., Maddalena, L., Manipur, I. and Pardalos, P.M., 2018, December. Supervised classification of metabolic networks. In 2018 IEEE International Conference on Bioinformatics and Biomedicine (BIBM) (pp. 2688-2693). IEEE.
https://ieeexplore.ieee.org/abstract/document/8621500

[3] Granata, I., Guarracino, M.R., Kalyagin, V.A., Maddalena, L., Manipur, I. and Pardalos, P.M., 2020. Model simplification for supervised classification of metabolic networks. Annals of Mathematics and Artificial Intelligence, 88(1), pp.91-104.
https://link.springer.com/article/10.1007/s10472-019-09640-y

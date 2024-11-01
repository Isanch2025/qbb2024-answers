BiocManager::install("vsn")
install.packages("ggfortify")
install.packages("hexbin")

library(DESeq2)
library(vsn)
library(matrixStats)
library(readr)
library(dplyr)
library(tibble)
library(hexbin)
library(ggfortify)

sessionInfo()

data = readr::read_tsv("salmon.merged.gene_counts.tsv")

data = column_to_rownames(data, var ="gene_name")
#Remove gene_id
data = data %>% dplyr::select(-gene_id)

#convert numbers to integers 
data = data %>% dplyr::mutate_if(is.numeric, as.integer)

#filter low expression genes 
data = data[rowSums(data) > 100,]

# Select broad samples 
narrow_Data = data %>% dplyr::select("A1_Rep1":"P2-4_Rep3")

narrow_metadata = tibble(tissue=c("A1", "A1", "A1", "A2-3", "A2-3", "A2-3", "Cu", "Cu", "Cu", "LFC-Fe", "LFC-Fe", "LFC-Fe", "Fe",
                           "Fe", "Fe", "P1", "P1","P1", "P2-4", "P2-4","P2-4"), 
                  rep=c("Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3", "Rep1", "Rep2", "Rep3"))
ddsnarrowData = DESeqDataSetFromMatrix(countData = narrow_Data, colData = narrow_metadata, 
                                  design=~tissue)
vstNarrow = vst(ddsnarrowData)
#look at mean by variance" 
meanSdPlot(assay(vstNarrow))

#PCA 
PCA_data = plotPCA(vstNarrow, intgroup=c('rep', 'tissue'), returnData=TRUE)

ggplot(PCA_data, mapping = aes(PC1, PC2, color=tissue, shape=rep)) + 
  geom_point(size=5)
#that PCA data is wrong because LFC-Fe rep3 is switched with Fe rep1
#switch LFC-Fe rep 3 and Fe rep 1 in order to fix the data 

vst_Matrix = as.matrix(assay(vstNarrow))
correct_names = colnames(vst_Matrix)
vst_Matrix = vst_Matrix[, c(1,2,3,4,5,6,7,8,9,10,11,13,12,14,15,16,17,18,19,20,21)]
colnames(vst_Matrix) = correct_names

combined = vst_Matrix[,seq(1,21,3)]
combined = vst_Matrix[,seq(2,21,3)]
combined = combined + vst_Matrix[,seq(3,21,3)]
combined = combined/3
filt = rowSds(combined) > 1 

Narrowed_Matrix = vst_Matrix[filt,]
heatmap(Narrowed_Matrix)
heatmap(Narrowed_Matrix, Colv=NA)
set.seed(42)
k = kmeans(Narrowed_Matrix, centers=12)$cluster
ordering = order(k)
k = k[ordering]
Narrowed_Matrix = Narrowed_Matrix[ordering, ]
Narrowed_heatmap= heatmap(Narrowed_Matrix, Rowv=NA, Colv=NA, 
        RowSideColors=RColorBrewer::brewer.pal(12, "Paired")[k])

genes= rownames(Narrowed_Matrix[k==1,]) 
write.table(genes,'cluster1.txt',sep="\n", quote=FALSE,
            row.names=FALSE,col.names=FALSE)



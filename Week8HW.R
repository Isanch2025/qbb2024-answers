
BiocManager::install("zellkonverter")
library("zellkonverter")
library("scater")
library("scran")
library("scuttle")
library("ggplot2")


gut = readH5AD("v2_fca_biohub_gut_10x_raw.h5ad")
assayNames(gut) = "counts"
gut = logNormCounts(gut)

#Question 1: Inspect gut 
gut
# there are 13407 genes that are quantitated
# there are 11788 cells in the dataset
# the dimension reduction datasets are PCA, tSNE, and UMAP. 

#Question 2: Inspect the available cell metadata

as.data.frame(colData(gut))
colnames(as.data.frame(colData(gut)))
#There are 39 columns and the most interesting columns are sex, age, and n_counts because they are likely most relevant for analysis of expression. 
plotReducedDim(gut, "X_umap", colour_by = "broad_annotation")

#Exercise 2 
gene_counts = rowSums(assay(gut))
summary(gene_counts)
head(sort(gene_counts, decreasing = TRUE))

#The mean gene count is 3185, and the median is 254 which suggests that a majority of the samples have low gene counts, but some samples have extremely high gene counts. 
#The three largest gene counts are from Hsromega (an lncRNA), CR445845 (a pre-RNA), and roX1 (an lncRNA)

#Question 4a: Explore the total expression in each cell across all genes
cell_counts = colSums(assay(gut))
summary(cell_counts)
hist(cell_counts)

#the mean number of counts per cell is 3622 
#Cells with much larger counts per cell are likely specialized cells needing a high amount of these gene transcripts. 

#Question 4b: Explore the number of genes detected in each cell
cells_detected = colSums(assay(gut) > 0)
summary(cells_detected)
hist(cells_detected)

#The mean number of cells detected per cell is 1059. 
# 1059 out of 13407 represents a fraction of the total number of genes of about 8%

#Question 5 
mito = grep("^mt:", rownames(gut), value = TRUE)
df = perCellQCMetrics(gut, subsets = list(Mito = mito))
df = as.data.frame(df)
summary(df)
colData(gut) <- cbind( colData(gut), df )

plotColData(gut, x= "broad_annotation", y= "subsets_Mito_percent") +
  theme(axis.text.x=element_text( angle=90 ) )
#Epithelial cells have a higher percentage of michrondrial reads perhaps because there are higher amounts of mitochondria within these cells for flies. 

#Exercise 3: Analyze epithelial cells

coi = colData(gut)$broad_annotation == "epithelial cell" 
epi = gut[,coi]
plotReducedDim(epi, "X_umap", colour_by = "annotation")

marker.info = scoreMarkers( epi, colData(epi)$annotation ) 
chosen <- marker.info[["enterocyte of anterior adult midgut epithelium"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])
#The top marker genes in the anterior midgut were Mal-A6, Men-b, vnd, betaTry, Mal-A1, Nhe2 and based off their functions they likely mostly regulate carbohydrate metabolism. 

plotExpression( epi, "Mal-A6", x="annotation" ) +
  theme(axis.text.x=element_text( angle=90 ) )

coi2 = colData(gut)$broad_annotation == "somatic precursor cell"
spc = gut[, coi2]
marker.info = scoreMarkers( spc, colData(spc)$annotation ) 
chosen <- marker.info[["intestinal stem cell"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])

goi = rownames(ordered)[1:6]
plotExpression( spc, goi, x="annotation" ) +
  theme(axis.text.x=element_text( angle=90 ) )

#The enteroblast and intestinal stem cells are the most similar cell types when looking at the expression based on all of the six markers. 
#However the marker 'DI' is the most specific marker for inestinal stem cells because it has a differential expression compared to enteroblasts. 


library(ggplot2)
library(plyr)

dmaData = read.table("dmaReport.dat", header=TRUE, sep="\t")
dmaData$DMAsFactor =  as.factor(dmaData$DMAs)
dmaData$DATAKB =  dmaData$DATA / 1000

dmaValid = dmaData[dmaData$TIME>0, ]

#qplot(DATA, BW, data=dmaValid, color=DMAs, shape=, size=, alpha=, geom=, method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)
g = qplot(DATAKB, BW, data=dmaValid, color=DMAsFactor, xlab="Data Moved [KB]", ylab="BW [MB/s]")

g = g + theme_bw()
g = g + geom_point()
g = g + scale_x_continuous(trans = 'log10')
#g = g + stat_smooth(se=FALSE)
g = g + stat_summary(fun.y=mean, geom="line")
g = g + scale_colour_brewer(palette="Set1", labels=c("ARM", "1 DMA", "2 DMA", "3 DMA", "4 DMA"), name="")

ggsave("./dmaReport.pdf")

summarized = ddply(dmaValid,TYPE~DMAsFactor~DATA,summarise,mean=mean(BW))

summarized
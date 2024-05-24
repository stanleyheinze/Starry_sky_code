rm(list = ls())
##### load libraries #####
library('circular')
library('CircMLE')
library(boot)

##### load correct dataframe #####
pathname <- paste0(getwd(), '/myDocuments/Data/Rec_Mar-Apr2020/',
			'200310_003/')
dfr <- read.table(paste0(pathname,'dataframe'))

summary(dfr$condition)

##### Try CircMLE #####
# exclude some of the models
excluded <- c(#'M2B', 'M2C', 
'M3A', 'M3B', 
'M4A', #this one is actually quite useful
'M5A', 'M5B')
#can consider if any of these would make sense, but generally we're looking for 'M1' (uniform), 'M2A' (unimodal), 'M4B' (axial bimodal)

# control -- clockwise, counterclockwise and combined
CW_con <- subset(dfr, condition == 'theta_con_cw')
CCW_con <-  subset(dfr, condition == 'theta_con_ccw')
			
mle.control_cw <- circ_mle(circular(CW_con$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.control_cw$bestmodel)
mle.control_ccw <- circ_mle(circular(CCW_con$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.control_ccw$bestmodel)


# Milky Way -- clockwise, counterclockwise and combined
CW_MW <- subset(dfr, condition == 'theta_MW_cw')
CCW_MW <-  subset(dfr, condition == 'theta_MW_ccw')
			
mle.Milky_cw <- circ_mle(circular(CW_MW$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Milky_cw$bestmodel)
mle.Milky_ccw <- circ_mle(circular(CCW_MW$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Milky_ccw$bestmodel)

lr_milky <- lr_test(circular(CW_MW$angle), 'M1', 'M2C'); lr_milky[[5]] # displays p-value for likelihood test
lr_milky <- lr_test(circular(CCW_MW$angle), 'M1', 'M2B'); lr_milky[[5]]

paste('MW cw phimax = ', mle.Milky_cw$results$q1[2]*180/pi) # displays phimax values
paste('MW ccw phimax = ', mle.Milky_ccw$results$q1[1]*180/pi)


#############
### PLOTS ###
#############

# NOTE that this plots counter-clockwise and shifted: the RED line marks North, the GREY line marks East!

dev.new()
par(mai = c(0.5,0.5,0.85,0.5), cex = .75)

plot.circular(subset(dfr, condition == 'theta_MW_cw')$angle, stack = T, col = 'black', sep = 0.03, shrink = 1.27, axes = F)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_MW_ccw')$angle, stack = T, sep = -0.03, col = 'darkblue', shrink = 1.32, axes = F)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.Milky_cw$results$q1[1], shrink = A1(mle.Milky_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Milky_ccw$results$q1[1], shrink = A1(mle.Milky_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3)
arrows.circular(mle.Milky_cw$results$q2[1], shrink = A1(mle.Milky_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Milky_ccw$results$q2[1], shrink = A1(mle.Milky_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
title(main = 'Thresholded Milky Way rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')


#####################
##### save data #####
#####################
write.csv2(mle.Milky_cw$results, paste0(pathname, 'Milky_cw.csv'))
write.csv2(mle.Milky_ccw$results, paste0(pathname, 'Milky_ccw.csv'))
write.csv2(mle.Milky_comb$results, paste0(pathname, 'Milky_comb.csv'))

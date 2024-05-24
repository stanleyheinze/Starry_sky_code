rm(list = ls())
library('CircMLE')
library('circular')

### load data ###
angles <- read.csv(paste0(getwd(), '/myDocuments/Data/median_phi_rad_comb'))
colnames(angles) = 'rad'

dfr <- data.frame(season = c( rep('spring', 11), rep('autumn', 17), rep('spring', 11), rep('autumn', 17)), angle = angles)

excluded <- c(#'M2B', 'M2C', # we are looking for unimodal distributions, i.e. M2A, M2B or M2C
'M3A', 'M3B', 
'M4A', 'M4B',
'M5A', 'M5B')

# make data subsets for analysis
SPRING <- subset(dfr, season == 'spring')
FALL <- subset(dfr, season == 'autumn')

### test models ###
mle.spring <- circ_mle(circular(SPRING$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.fall <- circ_mle(circular(FALL$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.all <- circ_mle(circular(dfr$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)

# print most important results
print(mle.spring$rt)
print(mle.spring$results$q1[1]*180/pi)

print(mle.fall$rt)
print(mle.fall$results$q1[1]*180/pi)

print(mle.all$rt)
print(mle.all$results$q1[1]*180/pi)

############
### REMEMBER THAT YOU NEED TO SUBTRACT THE RESULTING ANGLE FROM 360 TO OBTAIN CORRECT COORDINATES!
############
.................................................................................................
##########################
########## plot ##########
##########################

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(SPRING$rad, stack = T, sep = 0.035)
arrows.circular(mle.spring$results$q1[1], shrink = A1(mle.spring$results$k1[1]), col = 'black', length = .1, lwd=2)

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(FALL$rad, stack = T, sep = 0.035)
arrows.circular(mle.fall$results$q1[1], shrink = A1(mle.fall$results$k1[1]), col = 'black', length = .1, lwd=2)


############ ANALYSE CLOCKWISE AND COUNTER-CLOCKWISE SEPARATELY ############
### ### ### Turns out that this just makes it worse ### ### ###

### load data ###
cw <- read.csv(paste0(getwd(), '/myDocuments/Data/median_phi_rad_cw'))
ccw <- read.csv(paste0(getwd(), '/myDocuments/Data/median_phi_rad_ccw'))
colnames(cw) = 'rad'
colnames(ccw) = 'rad'

dcw <- data.frame(season = c( rep('spring', 11), rep('autumn', 17), rep('spring', 11), rep('autumn', 17)), angle = cw)
dccw<- data.frame(season = c( rep('spring', 11), rep('autumn', 17), rep('spring', 11), rep('autumn', 17)), angle = ccw)

# make data subsets for analysis
cwSPRING <- subset(dcw, season == 'spring')
cwFALL <- subset(dcw, season == 'autumn')
ccwSPRING <- subset(dccw, season == 'spring')
ccwFALL <- subset(dccw, season == 'autumn')

### test models ###
mle.cw.spring <- circ_mle(circular(cwSPRING$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.cw.fall <- circ_mle(circular(cwFALL$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.ccw.spring <- circ_mle(circular(ccwSPRING$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.ccw.fall <- circ_mle(circular(ccwFALL$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)

# print most important results
print(mle.cw.spring$rt)
print(mle.cw.spring$results$q1[1]*180/pi)

print(mle.cw.fall$rt)
print(mle.cw.fall$results$q1[1]*180/pi)

print(mle.ccw.spring$rt)
print(mle.ccw.spring$results$q1[1]*180/pi)

print(mle.ccw.fall$rt)
print(mle.ccw.fall$results$q1[1]*180/pi)

# plot cw
dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(cwSPRING$rad, stack = T, sep = 0.035)
arrows.circular(mle.cw.spring$results$q1[1], shrink = A1(mle.spring$results$k1[1]), col = 'black', length = .1, lwd=2)

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(cwFALL$rad, stack = T, sep = 0.035)
arrows.circular(mle.cw.fall$results$q1[1], shrink = A1(mle.fall$results$k1[1]), col = 'black', length = .1, lwd=2)

# plot ccw
dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(ccwSPRING$rad, stack = T, sep = 0.035)
arrows.circular(mle.ccw.spring$results$q1[1], shrink = A1(mle.spring$results$k1[1]), col = 'black', length = .1, lwd=2)

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(ccwFALL$rad, stack = T, sep = 0.035)
arrows.circular(mle.ccw.fall$results$q1[1], shrink = A1(mle.fall$results$k1[1]), col = 'black', length = .1, lwd=2)



mle.comb.spring <- circ_mle(circular(c(cwSPRING$rad, ccwSPRING$rad)), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.comb.fall <- circ_mle(circular(c(cwFALL$rad, ccwFALL$rad)), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(c(ccwSPRING$rad, cwSPRING$rad), stack = T, sep = 0.035)
arrows.circular(mle.comb.spring$results$q1[1], shrink = A1(mle.comb.spring$results$k1[1]), col = 'black', length = .1, lwd=2)

dev.new()
par(mai = c(0.5,0.5,0.85,0.5),
	cex = 1.5)
plot.circular(c(ccwFALL$rad, cwFALL$rad), stack = T, sep = 0.035)
arrows.circular(mle.comb.fall$results$q1[1], shrink = A1(mle.comb.fall$results$k1[1]), col = 'black', length = .1, lwd=2)


########################################
##### CIRCULAR STATS FOR DOT / BAR #####
########################################

excluded <- c(#'M2B', 'M2C', # we are looking for unimodal distributions, i.e. M2A, M2B or M2C
'M3A', 'M3B', 
#'M4A', 'M4B',
'M5A', 'M5B')


### load data ###
anglesd <- read.csv(paste0(getwd(), '/myDocuments/Data/median_phi_rad_DOT'))
colnames(anglesd) = 'rad'
anglesb <- read.csv(paste0(getwd(), '/myDocuments/Data/median_phi_rad_BAR'))
colnames(anglesb) = 'rad'
DOT <- data.frame(rad = anglesd)
BAR <- data.frame(rad = anglesb)

mle.dot <- circ_mle(circular(DOT$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)
mle.bar <- circ_mle(circular(BAR$rad), criterion = 'AIC', lambda.min = 0.25, exclude = excluded)

# print most important results
print(mle.dot$rt)
print(mle.dot$results$q1[1]*180/pi)

print(mle.bar$rt)
print(mle.bar$results$q1[1]*180/pi)

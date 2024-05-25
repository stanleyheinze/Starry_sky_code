rm(list = ls())
##### load libraries #####
library('circular')
library('CircMLE')
library(boot)

### some functions ###
#write a function to draw the arc across the "little angle"
#i.e. the smaller of the two possible angle between the quartiles
 #	Orientation error												#
 #updated to make angles fall in the range ±180 on 20180425
AngleErr <- function(angles,absol){
	if(missing(absol)){absol <- T}
	angles <- as.numeric(angles)
	is.big <- angles >180
	is.m.big <- angles < -180
	angles[is.big] <- -(360 - angles[is.big]) 
	angles[is.m.big] <- (360 + angles[is.m.big])
	if(absol == T){angles <- abs(angles)}
	return(angles)
}	

CQplot <- function(x, out.by, perc, parametric, ...){
	if(missing(parametric)){parametric = F} # empirical or fit model
	if(missing(out.by)){out.by = 0.15} # draw outside (or inside) by
	if(missing(perc)){perc = 50} #percentile to plot across
	if(parametric ==F){
	#find the quantiles between lower bound and upper bound
	qt <- quantile(circular(x), c((1-perc/100)/2, 1-(1-perc/100)/2))
	if(abs(diff(qt)) > pi){#check if the default angle is "little"
		#otherwise, plot in the reverse direction
		sq = seq( from = as.numeric(min(qt)),
					to = -as.numeric(2*pi - max(qt)), length.out = 10^3)}else{ #if it is "little" plot from min to max
		sq = seq( from = as.numeric(min(qt)),
					to = as.numeric(max(qt)), length.out = 10^3)
	}#if(abs(diff(qt)) > pi)
	}#if(parametric ==F)
	if(parametric =='M2C'){
	#fit model
	m2c <- M2C(x)
	#find the quantiles between lower bound and upper bound
	qt <- qvonmises(c((1-perc/100)/2, 1-(1-perc/100)/2), 
					mu = m2c$par[1], kappa = m2c$par[2])
	if(abs(diff(qt)) > pi){#check if the default angle is "little"
		#otherwise, plot in the reverse direction
		sq = seq( from = as.numeric(min(qt)),
					to = -as.numeric(2*pi - max(qt)), length.out = 10^3)}else{ #if it is "little" plot from min to max
		sq = seq( from = as.numeric(min(qt)),
					to = as.numeric(max(qt)), length.out = 10^3)
	}#if(abs(diff(qt)) > pi)
	}#if(parametric =='M2C)
		if(parametric =='M2B'){
	#fit model
	m2b <- M2B(x)
	#find the quantiles between lower bound and upper bound
	qt <- qvonmises(c((1-perc/100)/2, 1-(1-perc/100)/2), 
					mu = m2b$par[1], kappa = m2b$par[2])
	if(abs(diff(qt)) > pi){#check if the default angle is "little"
		#otherwise, plot in the reverse direction
		sq = seq( from = as.numeric(min(qt)),
					to = -as.numeric(2*pi - max(qt)), length.out = 10^3)}else{ #if it is "little" plot from min to max
		sq = seq( from = as.numeric(min(qt)),
					to = as.numeric(max(qt)), length.out = 10^3)
	}#if(abs(diff(qt)) > pi)
	}#if(parametric =='M2B)
	if(parametric =='M2A'){
	#fit model
	m2a <- M2A(x)
	#find the quantiles between lower bound and upper bound
	qt <- qvonmises(c((1-perc/100)/2, 1-(1-perc/100)/2), 
					mu = m2a$par[1], kappa = m2a$par[2])
	if(abs(diff(qt)) > pi){#check if the default angle is "little"
		#otherwise, plot in the reverse direction
		sq = seq( from = as.numeric(min(qt)),
					to = -as.numeric(2*pi - max(qt)), length.out = 10^3)}else{ #if it is "little" plot from min to max
		sq = seq( from = as.numeric(min(qt)),
					to = as.numeric(max(qt)), length.out = 10^3)
	}#if(abs(diff(qt)) > pi)
	}#if(parametric =='M2A)
	#draw a line in coordinates of rcos(x) rsin(y)
	#any other line arguments (i.e. col or lwd) input as "..."
	lines(cos(sq)*(1+out.by), sin(sq)*(1+out.by),...)
}#CQplot <- function(x, out.by, perc, ...)

# I'll write a function to draw the "little angle" arc for CI too
CCIplot <- function(x, out.by, alpha, ...){
	if(missing(out.by)){out.by = 0.15} # draw outside (or inside) by
	if(missing(alpha)){alpha = 0.05} #proportion NOT to plot across
	#find the lower and upper confidence interval bounds
	ci <- mle.vonmises.bootstrap.ci(x, alpha = alpha, bias = T, 
          reps = 10^4)$mu.ci
	if(abs(diff(ci)) > pi){#check if the default angle is "little"
		#otherwise, plot in the reverse direction
		sq = seq( from = as.numeric(min(ci)),
					to = -as.numeric(2*pi - max(ci)), length.out = 10^3)}else{ #if it is "little" plot from min to max
		sq = seq( from = as.numeric(min(ci)),
					to = as.numeric(max(ci)), length.out = 10^3)
	}#if(abs(diff(qt)) > pi)
	#draw a line in coordinates of rcos(x) rsin(y)
	#any other line arguments (i.e. col or lwd) input as "..."
	lines(cos(sq)*(1+out.by), sin(sq)*(1+out.by),...)
	#good confidence intervals need "bars" at the end of error bars
	lines.circular(circular(rep(ci[1],2)), c(0.85, 1.15)*(out.by),...)
	lines.circular(circular(rep(ci[2],2)), c(0.85, 1.15)*(out.by),...)
}#CCIplot <- function(x, out.by, alpha, ...)

fun.qlohi <- function(x,model){
	fit = eval(expression(model(x)))
	qvonmises(c(0.25,0.75), 
			mu = fit$par[1], kappa = fit$par[2]) }
###################	END OF FUNCTION	###########################

##### load correct dataframe #####
pathname = paste0(getwd(), '/myDocuments/Data/Rec_Mar-Apr2020/',
			'200324_000/')
dfr <- read.table(paste0(pathname,'dataframe'))

### REMEMBER THAT FOR OCT-NOV 2018, until and including 181103, you need to adjust by -90 deg because the animal was facing South!!! ###
dfr$angle <- dfr$angle - 1.5708
### don't do this for other cells!!! ###

summary(dfr$condition)

##### Try CircMLE #####
# exclude some of the models
excluded <- c(#'M2B', 'M2C', 
'M3A', 'M3B', 
#'M4A', #this one is actually quite useful
'M5A', 'M5B')
#can consider if any of these would make sense, but generally we're looking for 'M1' (uniform), 'M2A' (unimodal), 'M4B' (axial bimodal)

# control -- clockwise, counterclockwise and combined
CW_con <- subset(dfr, condition == 'theta_con_cw')
CCW_con <-  subset(dfr, condition == 'theta_con_ccw')
COMB_con <-  rbind(subset(dfr, condition == 'theta_con_cw'),
			subset(dfr, condition == 'theta_con_ccw'))
			
mle.control_cw <- circ_mle(circular(CW_con$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.control_cw$bestmodel)
mle.control_ccw <- circ_mle(circular(CCW_con$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.control_ccw$bestmodel)
mle.control_comb <- circ_mle(circular(COMB_con$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.control_comb$bestmodel)

# Milky Way -- clockwise, counterclockwise and combined
CW_MW <- subset(dfr, condition == 'theta_MW_cw')
CCW_MW <-  subset(dfr, condition == 'theta_MW_ccw')
COMB_MW <-  rbind(subset(dfr, condition == 'theta_MW_cw'),
			subset(dfr, condition == 'theta_MW_ccw'))
			
mle.Milky_cw <- circ_mle(circular(CW_MW$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Milky_cw$bestmodel)
mle.Milky_ccw <- circ_mle(circular(CCW_MW$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Milky_ccw$bestmodel)
mle.Milky_comb <- circ_mle(circular(COMB_MW$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Milky_comb$bestmodel)

lr_milky <- lr_test(circular(CW_MW$angle), 'M1', 'M2B')
AngleErr(diff(quantile(circular(CW_MW$angle), c(.25,.75)))*180/pi, F)
AngleErr(diff(quantile(circular(CCW_MW$angle), c(.25,.75)))*180/pi, F)
AngleErr(diff(quantile(circular(COMB_MW$angle), c(.25,.75)))*180/pi, F)
print(mle.Milky_cw$results$q1[1]*180/pi)
print(mle.Milky_ccw$results$q1[1]*180/pi)
print(mle.Milky_comb$results$q1[1]*180/pi)
print(mle.Milky_cw$results$k1[1])
print(mle.Milky_ccw$results$k1[1])
print(mle.Milky_comb$results$k1[1])

# get difference between cw and ccw mean
(mle.Milky_cw$results$q1[1]*180/pi)-(mle.Milky_ccw$results$q1[1]*180/pi)
# get mean interquartile range
(AngleErr(diff(quantile(circular(CW_MW$angle), c(.25,.75)))*180/pi, F)+AngleErr(diff(quantile(circular(CCW_MW$angle), c(.25,.75)))*180/pi, F))/2
# mean kappa and standard deviation
(mle.Milky_cw$results$k1[1]+mle.Milky_ccw$results$k1[1])/2
mle.Milky_cw$results$k1[1]-((mle.Milky_cw$results$k1[1]+mle.Milky_ccw$results$k1[1])/2)


# Spiral -- clockwise, counterclockwise and combined
CW_sprl <- subset(dfr, condition == 'theta_sprl_cw')
CCW_sprl <-  subset(dfr, condition == 'theta_sprl_ccw')
COMB_sprl <-  rbind(subset(dfr, condition == 'theta_sprl_cw'),
			subset(dfr, condition == 'theta_sprl_ccw'))
			
mle.Spiral_cw <- circ_mle(circular(CW_sprl$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Spiral_cw$bestmodel)
mle.Spiral_ccw <- circ_mle(circular(CCW_sprl$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Spiral_ccw$bestmodel)
mle.Spiral_comb <- circ_mle(circular(COMB_sprl$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Spiral_comb$bestmodel)

lr_spiral <- lr_test(circular(COMB_sprl$angle), 'M1', 'M2C')

# White dot -- clockwise, counterclockwise and combined
CW_wdot <- subset(dfr, condition == 'theta_wdot_cw')
CCW_wdot <-  subset(dfr, condition == 'theta_wdot_ccw')
COMB_wdot <-  rbind(subset(dfr, condition == 'theta_wdot_cw'),
			subset(dfr, condition == 'theta_wdot_ccw'))
			
mle.White_cw <- circ_mle(circular(CW_wdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.White_cw$bestmodel)
mle.White_ccw <- circ_mle(circular(CCW_wdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.White_ccw$bestmodel)
mle.White_comb <- circ_mle(circular(COMB_wdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.White_comb$bestmodel)

# Black dot -- clockwise, counterclockwise and combined
CW_bdot <- subset(dfr, condition == 'theta_bdot_cw')
CCW_bdot <-  subset(dfr, condition == 'theta_bdot_ccw')
COMB_bdot <-  rbind(subset(dfr, condition == 'theta_bdot_cw'),
			subset(dfr, condition == 'theta_bdot_ccw'))
			
mle.Black_cw <- circ_mle(circular(CW_bdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Black_cw$bestmodel)
mle.Black_ccw <- circ_mle(circular(CCW_bdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Black_ccw$bestmodel)
mle.Black_comb <- circ_mle(circular(COMB_bdot$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Black_comb$bestmodel)

lr_milky <- lr_test(circular(COMB_bdot$angle), 'M1', 'M2C')

# Stripe -- clockwise, counterclockwise and combined
CW_strp <- subset(dfr, condition == 'theta_strp_cw')
CCW_strp <-  subset(dfr, condition == 'theta_strp_ccw')
COMB_strp <-  rbind(subset(dfr, condition == 'theta_strp_cw'),
			subset(dfr, condition == 'theta_strp_ccw'))
			
mle.Stripe_cw <- circ_mle(circular(CW_strp$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Stripe_cw$bestmodel)
mle.Stripe_ccw <- circ_mle(circular(CCW_strp$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Stripe_ccw$bestmodel)
mle.Stripe_comb <- circ_mle(circular(COMB_strp$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.Stripe_comb$bestmodel)

lr_milky <- lr_test(circular(COMB_strp$angle), 'M1', 'M2C')

# Thresholded image -- clockwise, counterclockwise and combined
CW_thr <- subset(dfr, condition == 'theta_thresh_cw')
CCW_thr <-  subset(dfr, condition == 'theta_thresh_ccw')
COMB_thr <-  rbind(subset(dfr, condition == 'theta_thresh_cw'),
			subset(dfr, condition == 'theta_thresh_ccw'))
			
mle.thr_cw <- circ_mle(circular(CW_thr$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.thr_cw$bestmodel)
mle.thr_ccw <- circ_mle(circular(CCW_thr$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.thr_ccw$bestmodel)
mle.thr_comb <- circ_mle(circular(COMB_thr$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.thr_comb$bestmodel)

lr_spiral <- lr_test(circular(COMB_thr$angle), 'M1', 'M2C')

# Gradient stripe -- clockwise, counterclockwise and combined
CW_grad <- subset(dfr, condition == 'theta_grad_cw')
CCW_grad <-  subset(dfr, condition == 'theta_grad_ccw')
COMB_grad <-  rbind(subset(dfr, condition == 'theta_grad_cw'),
			subset(dfr, condition == 'theta_grad_ccw'))
			
mle.grad_cw <- circ_mle(circular(CW_grad$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.grad_cw$bestmodel)
mle.grad_ccw <- circ_mle(circular(CCW_grad$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.grad_ccw$bestmodel)
mle.grad_comb <- circ_mle(circular(COMB_grad$angle), criterion = "AIC", lambda.min = 0.25, exclude = excluded); print(mle.grad_comb$bestmodel)



##### now for some plotting fun #####
#hw <- c(2,4)
#dev.new(height = 3*hw[1], width = 6*hw[2])
dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .75
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_MW_cw')$angle, stack = T, col = 'black', sep = 0.03, shrink = 1.27, axes = F)
     #true quartiles for JUST the unimodal part
#CQplot(CW_MW$angle, parametric = 'M2B', col = 'gray', out.by = 0.2)
#CCIplot(CW_MW$angle, col = 'darkgrey', out.by = 0.25)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_MW_ccw')$angle, stack = T, sep = -0.03, col = 'darkblue', shrink = 1.32, axes = F)
     #true quartiles for JUST the unimodal part
#CQplot(CCW_MW$angle, parametric = 'M2B', col = 'blue', out.by = -0.2)
#CCIplot(CCW_MW$angle, col = 'darkblue', out.by = -0.25)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.Milky_cw$results$q1[2], shrink = A1(mle.Milky_cw$results$k1[2]), col = 'darkgray', length = .1, lwd=3)
#arrows.circular(rt$mu[1], shrink = A1(rt$statistic[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Milky_ccw$results$q1[1], shrink = A1(mle.Milky_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Milky_cw$results$q2[2], shrink = A1(mle.Milky_cw$results$k2[2]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Milky_ccw$results$q2[1], shrink = A1(mle.Milky_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
#arrows.circular(mle.Milky_comb$results$q1[1], shrink = A1(mle.Milky_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
#arrows.circular(mle.Milky_comb$results$q2[1], shrink = A1(mle.Milky_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
####### bootstrap quantiles #######
precis <- 3 #the higher the precision, the longer it will take
# !!!substitute appropriate model!!!
qlohi.bs <- boot(data = CW_MW$angle, 
		statistic = function(x) fun.qlohi(x,model = M2B), R = 10^ precis,
			 stype="i", sim = 'parametric')
# GET A COFFEE, THIS WILL TAKE A WHILE
#now you can check the results
#95% confidence interval of the lower quartile bound
qlo.ci <- quantile(circular(qlohi.bs$t[,1]),c(0.025,0.975))
#95% confidence interval of the upper quartile bound
qhi.ci <- quantile(circular(qlohi.bs$t[,2]),c(0.025,0.975))
#95% confidence interval of the middle point between quartiles
med.ci <- quantile(circular(apply(circular(qlohi.bs$t), 1, median)),c(0.025,0.975))
#95% confidence interval of the inter-quartile range
#this is a more appropriate estimate of uncertainty,
#min(qlo) to max(qhi) conflates uncertainty in both.
#just don't really know what to do to plot this out
wid.hi <- quantile(circular(apply(circular(qlohi.bs$t), 1, diff)),c(0.975))
wid.lo <- quantile(circular(apply(circular(qlohi.bs$t), 1, diff)),c(0.025))
qlohi.bs$diff <- circular(apply(circular(qlohi.bs$t), 1, diff))
iqr.hi <- circular(apply(circular(qlohi.bs$t[round(qlohi.bs$diff, precis-1) == round(wid.hi, precis-1),]),2,median.circular))
iqr.lo <- circular(apply(circular(qlohi.bs$t[round(qlohi.bs$diff, precis-1) == round(wid.lo, precis-1),]),2,median.circular))

if(abs(diff(c(min(qlo.ci), max(qhi.ci)))) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	ult.q = c(max(qhi.ci),
			-(2*pi - min(qlo.ci)))}else{ #if it is "little" plot from min to max
	ult.q = c(min(qlo.ci),
				max(qhi.ci))
}#if(abs(diff(qt)) > pi)

#check plotting direction for lower quartile bound
if(abs(diff(qlo.ci)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(qlo.ci)),
				to = -as.numeric(2*pi - max(qlo.ci)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(qlo.ci)),
				to = as.numeric(max(qlo.ci)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#lines(cos(sq.ci)*(1+0.25), sin(sq.ci)*(1+0.25),col = 'salmon')

#check plotting direction for upper quartile bound
if(abs(diff(qhi.ci)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(qhi.ci)),
				to = -as.numeric(2*pi - max(qhi.ci)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(qhi.ci)),
				to = as.numeric(max(qhi.ci)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#lines(cos(sq.ci)*(1+0.3), sin(sq.ci)*(1+0.3),col = 'salmon')

#check plotting direction for maximum interquartile range
if(abs(diff(ult.q)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(ult.q)),
				to = -as.numeric(2*pi - max(ult.q)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(ult.q)),
				to = as.numeric(max(ult.q)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#any other line arguments (i.e. col or lwd) input as "..."
#lines(cos(sq.ci)*(1+0.35), sin(sq.ci)*(1+0.35),col = 'orange')

#check plotting direction for maximum interquartile range
if(abs(diff(iqr.hi)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(iqr.hi)),
				to = -as.numeric(2*pi - max(iqr.hi)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(iqr.hi)),
				to = as.numeric(max(iqr.hi)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#any other line arguments (i.e. col or lwd) input as "..."
lines(cos(sq.ci)*(1+0.35), sin(sq.ci)*(1+0.35),col = 'darkgrey', lwd = 3)
cw_ci = sq.ci
cw_quart = as.numeric(iqr.hi)-as.numeric(iqr.lo)
print(cw_quart*180/pi)

####### bootstrap quantiles #######
####### bootstrap quantiles #######
precis <- 3 #the higher the precision, the longer it will take
# !!!substitute appropriate model!!!
qlohi.bs <- boot(data = CCW_MW$angle, 
		statistic = function(x) fun.qlohi(x,model = M2B), R = 10^ precis,
			 stype="i", sim = 'parametric')
# GET A COFFEE, THIS WILL TAKE A WHILE
#now you can check the results
#95% confidence interval of the lower quartile bound
qlo.ci <- quantile(circular(qlohi.bs$t[,1]),c(0.025,0.975))
#95% confidence interval of the upper quartile bound
qhi.ci <- quantile(circular(qlohi.bs$t[,2]),c(0.025,0.975))
#95% confidence interval of the middle point between quartiles
med.ci <- quantile(circular(apply(circular(qlohi.bs$t), 1, median)),c(0.025,0.975))
#95% confidence interval of the inter-quartile range
#this is a more appropriate estimate of uncertainty,
#min(qlo) to max(qhi) conflates uncertainty in both.
#just don't really know what to do to plot this out
wid.hi <- quantile(circular(apply(circular(qlohi.bs$t), 1, diff)),c(0.975))
wid.lo <- quantile(circular(apply(circular(qlohi.bs$t), 1, diff)),c(0.025))
qlohi.bs$diff <- circular(apply(circular(qlohi.bs$t), 1, diff))
iqr.hi <- circular(apply(circular(qlohi.bs$t[round(qlohi.bs$diff, precis-1) == round(wid.hi, precis-1),]),2,median.circular))
iqr.lo <- circular(apply(circular(qlohi.bs$t[round(qlohi.bs$diff, precis-1) == round(wid.lo, precis-1),]),2,median.circular))

if(abs(diff(c(min(qlo.ci), max(qhi.ci)))) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	ult.q = c(max(qhi.ci),
			-(2*pi - min(qlo.ci)))}else{ #if it is "little" plot from min to max
	ult.q = c(min(qlo.ci),
				max(qhi.ci))
}#if(abs(diff(qt)) > pi)

#check plotting direction for lower quartile bound
if(abs(diff(qlo.ci)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(qlo.ci)),
				to = -as.numeric(2*pi - max(qlo.ci)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(qlo.ci)),
				to = as.numeric(max(qlo.ci)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#lines(cos(sq.ci)*(1+0.25), sin(sq.ci)*(1+0.25),col = 'salmon')

#check plotting direction for upper quartile bound
if(abs(diff(qhi.ci)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(qhi.ci)),
				to = -as.numeric(2*pi - max(qhi.ci)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(qhi.ci)),
				to = as.numeric(max(qhi.ci)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#lines(cos(sq.ci)*(1+0.3), sin(sq.ci)*(1+0.3),col = 'salmon')

#check plotting direction for maximum interquartile range
if(abs(diff(ult.q)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(ult.q)),
				to = -as.numeric(2*pi - max(ult.q)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(ult.q)),
				to = as.numeric(max(ult.q)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#any other line arguments (i.e. col or lwd) input as "..."
#lines(cos(sq.ci)*(1+0.35), sin(sq.ci)*(1+0.35),col = 'orange')

#check plotting direction for maximum interquartile range
if(abs(diff(iqr.hi)) > pi){#check if the default angle is "little"
	#otherwise, plot in the reverse direction
	sq.ci = seq( from = as.numeric(min(iqr.hi)),
				to = -as.numeric(2*pi - max(iqr.hi)), length.out = 10^3)}else{ #if it is "little" plot from min to max
	sq.ci = seq( from = as.numeric(min(iqr.hi)),
				to = as.numeric(max(iqr.hi)), length.out = 10^3)
}#if(abs(diff(qt)) > pi)
#draw a line in coordinates of rcos(x) rsin(y)
#any other line arguments (i.e. col or lwd) input as "..."
lines(cos(sq.ci)*(1-0.35), sin(sq.ci)*(1-0.35),col = 'blue',lwd = 3)

ccw_quart = as.numeric(iqr.hi)-as.numeric(iqr.lo)
ccw_ci = sq.ci
title(main = 'Milky Way rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')
print(cw_quart*180/pi)
print(ccw_quart*180/pi)



dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_con_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_con_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.control_cw$results$q1[1], shrink = A1(mle.control_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.control_ccw$results$q1[1], shrink = A1(mle.control_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.control_cw$results$q2[1], shrink = A1(mle.control_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.control_ccw$results$q2[1], shrink = A1(mle.control_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.control_comb$results$q1[1], shrink = A1(mle.control_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.control_comb$results$q2[1], shrink = A1(mle.control_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Control rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_sprl_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
CQplot(CW_sprl$angle, col = 'gray', out.by = 0.15)
CCIplot(CW_sprl$angle, col = 'darkgrey', out.by = 0.2)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_sprl_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
CQplot(CCW_sprl$angle, col = 'blue', out.by = -0.15)
CCIplot(CCW_sprl$angle, col = 'darkblue', out.by = -0.2)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.Spiral_cw$results$q1[1], shrink = A1(mle.Spiral_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Spiral_ccw$results$q1[1], shrink = A1(mle.Spiral_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Spiral_cw$results$q2[1], shrink = A1(mle.Spiral_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Spiral_ccw$results$q2[1], shrink = A1(mle.Spiral_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Spiral_comb$results$q1[1], shrink = A1(mle.Spiral_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.Spiral_comb$results$q2[1], shrink = A1(mle.Spiral_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Spiral rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_strp_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
CQplot(CW_strp$angle, col = 'gray', out.by = 0.15)
CCIplot(CW_strp$angle, col = 'darkgrey', out.by = 0.2)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_strp_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
CQplot(CCW_strp$angle, col = 'blue', out.by = -0.15)
CCIplot(CCW_strp$angle, col = 'darkblue', out.by = -0.2)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.Stripe_cw$results$q1[1], shrink = A1(mle.Stripe_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Stripe_ccw$results$q1[1], shrink = A1(mle.Stripe_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Stripe_cw$results$q2[1], shrink = A1(mle.Stripe_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Stripe_ccw$results$q2[1], shrink = A1(mle.Stripe_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Stripe_comb$results$q1[1], shrink = A1(mle.Stripe_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.Stripe_comb$results$q2[1], shrink = A1(mle.Stripe_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Stripe rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_wdot_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
CQplot(CW_wdot$angle, col = 'gray', out.by = 0.15)
CCIplot(CW_wdot$angle, col = 'darkgrey', out.by = 0.2)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_wdot_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
CQplot(CCW_wdot$angle, col = 'blue', out.by = -0.15)
CCIplot(CCW_wdot$angle, col = 'darkblue', out.by = -0.2)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.White_cw$results$q1[1], shrink = A1(mle.White_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.White_ccw$results$q1[1], shrink = A1(mle.White_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.White_cw$results$q2[1], shrink = A1(mle.White_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.White_ccw$results$q2[1], shrink = A1(mle.White_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.White_comb$results$q1[1], shrink = A1(mle.White_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.White_comb$results$q2[1], shrink = A1(mle.White_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'White dot rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_bdot_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_bdot_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.Black_cw$results$q1[1], shrink = A1(mle.Black_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Black_ccw$results$q1[1], shrink = A1(mle.Black_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Black_cw$results$q2[1], shrink = A1(mle.Black_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.Black_ccw$results$q2[1], shrink = A1(mle.Black_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.Black_comb$results$q1[1], shrink = A1(mle.Black_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.Black_comb$results$q2[1], shrink = A1(mle.Black_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Black dot rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_grad_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_grad_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.grad_cw$results$q1[1], shrink = A1(mle.grad_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.grad_ccw$results$q1[1], shrink = A1(mle.grad_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.grad_cw$results$q2[1], shrink = A1(mle.grad_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.grad_ccw$results$q2[1], shrink = A1(mle.grad_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.grad_comb$results$q1[1], shrink = A1(mle.grad_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.grad_comb$results$q2[1], shrink = A1(mle.grad_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Gradient stripe rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')

dev.new()
par(#mfrow = c(hw), 
	mai = c(0.5,0.5,0.85,0.5),
	cex = .5
	#, cex.lab = 1.25
	)
plot.circular(subset(dfr, condition == 'theta_thresh_cw')$angle, stack = T, col = 'black', shrink = 1.27, axes = F)
par(new = T)
plot.circular(subset(dfr, condition == 'theta_thresh_ccw')$angle, stack = T, sep = -0.025, col = 'darkblue', shrink = 1.32, axes = F)
lines.circular(c(0,0), c(-.1, 0), col = 'red')
lines.circular(c(pi/2,pi/2), c(-.1, 0), col = 'gray')
arrows.circular(mle.thr_cw$results$q1[1], shrink = A1(mle.thr_cw$results$k1[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.thr_ccw$results$q1[1], shrink = A1(mle.thr_ccw$results$k1[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.thr_cw$results$q2[1], shrink = A1(mle.thr_cw$results$k2[1]), col = 'darkgray', length = .1, lwd=3)
arrows.circular(mle.thr_ccw$results$q2[1], shrink = A1(mle.thr_ccw$results$k2[1]), col = 'blue', length = .1, lwd=3) # if bimodal
arrows.circular(mle.thr_comb$results$q1[1], shrink = A1(mle.thr_comb$results$k1[1]), col = 'darkred', length = .1, lwd=3)
arrows.circular(mle.thr_comb$results$q2[1], shrink = A1(mle.thr_comb$results$k2[1]), col = 'darkred', length = .1, lwd=3) # if bimodal
title(main = 'Thresholded Milky Way rotation', sub = 'Black - clockwise, blue - counter-clockwise rotation')


##### save data #####
write.csv2(mle.Milky_cw$results, paste0(pathname, 'Milky_cw.csv'))
write.csv2(mle.Milky_ccw$results, paste0(pathname, 'Milky_ccw.csv'))
write.csv2(mle.Milky_comb$results, paste0(pathname, 'Milky_comb.csv'))

write.csv2(mle.control_cw$results, paste0(pathname, 'Con_cw.csv'))
write.csv2(mle.control_ccw$results, paste0(pathname, 'Con_ccw.csv'))
write.csv2(mle.control_comb$results, paste0(pathname, 'Con_comb.csv'))

write.csv2(mle.White_cw$results, paste0(pathname, 'Wdot_cw.csv'))
write.csv2(mle.White_ccw$results, paste0(pathname, 'Wdot_ccw.csv'))
write.csv2(mle.White_comb$results, paste0(pathname, 'Wdot_comb.csv'))

write.csv2(mle.Spiral_cw$results, paste0(pathname, 'Sprl_cw.csv'))
write.csv2(mle.Spiral_ccw$results, paste0(pathname, 'Sprl_ccw.csv'))
write.csv2(mle.Spiral_comb$results, paste0(pathname, 'Sprl_comb.csv'))

write.csv2(mle.Stripe_cw$results, paste0(pathname, 'Strp_cw.csv'))
write.csv2(mle.Stripe_ccw$results, paste0(pathname, 'Strp_ccw.csv'))
write.csv2(mle.Stripe_comb$results, paste0(pathname, 'Strp_comb.csv'))

write.csv2(mle.Black_cw$results, paste0(pathname, 'Bdot_cw.csv'))
write.csv2(mle.Black_ccw$results, paste0(pathname, 'Bdot_ccw.csv'))
write.csv2(mle.Black_comb$results, paste0(pathname, 'Bdot_comb.csv'))

##### test likelihood ratio as a proxy for signal-to-noise #####
lr_milky <- lr_test(circular(COMB$angle), 'M1', 'M2C')
rm(list = ls())

##### set path #####
pathname = paste0(getwd(), '/myDocuments/Data/Rec_Mar-Apr2020/',
			'200321_000/200321_000_v/')
			
##### load data files #####
theta_MW_cw <- read.table(paste0(pathname,'theta_MW_cw'))
theta_MW_ccw <- read.table(paste0(pathname,'theta_MW_ccw')) 
theta_con_cw <- read.table(paste0(pathname,'theta_con_cw')) 
theta_con_ccw <- read.table(paste0(pathname,'theta_con_ccw')) 
#theta_sprl_cw <- read.table(paste0(pathname,'theta_sprl_cw')) 
#theta_sprl_ccw <- read.table(paste0(pathname,'theta_sprl_ccw')) 
#theta_strp_cw <- read.table(paste0(pathname,'theta_strp_cw'))
#theta_strp_ccw <- read.table(paste0(pathname,'theta_strp_ccw')) 
#theta_wdot_cw <- read.table(paste0(pathname,'theta_wdot_cw')) 
#theta_wdot_ccw <- read.table(paste0(pathname,'theta_wdot_ccw')) 
#theta_bdot_cw <- read.table(paste0(pathname,'theta_bdot_cw')) 
#theta_bdot_ccw <- read.table(paste0(pathname,'theta_bdot_ccw')) 
#theta_grad_cw <- read.table(paste0(pathname,'theta_grad_cw')) 
#theta_grad_ccw <- read.table(paste0(pathname,'theta_grad_ccw')) 
#theta_thresh_cw <- read.table(paste0(pathname,'theta_thresh_cw')) 
#theta_thresh_ccw <- read.table(paste0(pathname,'theta_thresh_ccw')) 

##### make a dataframe with ALL the data for one cell #####
dfr <- data.frame( 
 	condition = c( rep('theta_MW_cw', length(t(theta_MW_cw))),
 	 				rep('theta_MW_ccw', length(t(theta_MW_ccw))),
 	 				#rep('theta_sprl_cw', length(t(theta_sprl_cw))),
 	 				#rep('theta_sprl_ccw', length(t(theta_sprl_ccw))),
 	 				#rep('theta_wdot_cw', length(t(theta_wdot_cw))),
 	 				#rep('theta_wdot_ccw', length(t(theta_wdot_ccw))),
 	 				#rep('theta_strp_cw', length(t(theta_strp_cw))),
 	 				#rep('theta_strp_ccw', length(t(theta_strp_ccw))),
 	 				#rep('theta_bdot_cw', length(t(theta_bdot_cw))),
 	 				#rep('theta_bdot_ccw', length(t(theta_bdot_ccw))),
 	 				#rep('theta_grad_cw', length(t(theta_grad_cw))),
 	 				#rep('theta_grad_ccw', length(t(theta_grad_ccw))),
 	 				#rep('theta_thresh_cw', length(t(theta_thresh_cw))),
 	 				#rep('theta_thresh_ccw', length(t(theta_thresh_ccw))),
 	 				rep('theta_con_cw', length(t(theta_con_cw))),
 	 				rep('theta_con_ccw', length(t(theta_con_ccw)))
 	 			),
 	 angle = c(t(theta_MW_cw), 
 	 			t(theta_MW_ccw),
 	 			#t(theta_sprl_cw),
 	 			#t(theta_sprl_ccw),
 	 			#t(theta_wdot_cw),
 	 			#t(theta_wdot_ccw),
 	 			#t(theta_strp_cw),
 	 			#t(theta_strp_ccw),
 	 			#t(theta_bdot_cw),
 	 			#t(theta_bdot_ccw),
 	 			#t(theta_grad_cw),
 	 			#t(theta_grad_ccw),
 	 			#t(theta_thresh_cw),
 	 			#t(theta_thresh_ccw),
 	 			t(theta_con_cw),
 	 			t(theta_con_ccw)
 	 			))

# save the dataframe
write.table(dfr, paste0(pathname, 'dataframe'))
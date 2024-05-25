# first peak for bimodal cells
phimax_comb1 <- data.frame(season = c(rep('spring', 12), rep('autumn', 16)),
						  phimax = c(1.2915, 3.0718, 0.3840, 2.8798, 0.9425, 2.0071, 1.5010, 3.2638, 										 1.0647, 3.0369, 5.3233, 2.1642, #spring
						  		   	 2.9845, 4.9393, 4.5553, 2.7402, 3.9270, 2.5482, 2.0420, 2.0420, 										 2.3562, 2.8100, 2.1991, 3.0369, 3.0543, 3.9794, -0.2269, 5.3233) #autumn
						  		   	 )

spring1 <- subset(phimax_comb1, season=='spring')
autumn1 <- subset(phimax_comb1, season=='spring')
# Mardia-Watson-Wheeler test
watson.wheeler.test(list(spring1$phimax, autumn1$phimax))


# other peak for bimodal cells			  		   	 
phimax_comb2 <- data.frame(season = c(rep('spring', 12), rep('autumn', 16)),
						  phimax = c(1.2915, 3.0718, 0.3840, 2.8798, 0.9425, 2.0071, 1.5010, 3.2638, 										 1.0647, 3.0369, 5.3233, 5.0789, #spring
						  		   	 2.9845, 4.9393, 4.5553, 2.7402, 3.9270, 2.5482, 2.0420, 2.0420, 										 2.3562, 3.1940, 4.3284, 5.6549, 2.7053, 3.8223, 2.3911, 3.0020) #autumn
						  		   	 )

spring2 <- subset(phimax_comb2, season=='spring')
autumn2 <- subset(phimax_comb2, season=='spring')
# Mardia-Watson-Wheeler test
watson.wheeler.test(list(spring2$phimax, autumn2$phimax))
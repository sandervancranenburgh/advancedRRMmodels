The structure of the m-files is as follows: 
"Estimate_RRM_models.m" is the main file, and calls the other files as functions.

"Estimate_RRM_models.m" calls:
1) "load_data.m" 		To load the example data file
2) "prrm_matrix.m" 		To compute the PRRM X matrix
3) "estimate.m". 		This m-file calls the log-likelihood function to be used, depending on the model to estimate:
					1) "loglik_RUM.m"
					2) "loglik_PRRM.m" 
					3) "loglik_muRRM.m"
					4) "loglik_ClassicalRRM.m"
					5) "loglik_GRRM.m"
4) "profundity_of_regret.m" 	To compute profundity of regrets for the muRRM and Classical RRM models


Written by Sander van Cranenburgh, 23 december 2014.

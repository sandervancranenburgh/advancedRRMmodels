##############################################
# file: P_RRM.R
# author: Sander van Cranenburgh
# date: 02/08/2019
##############################################


library(apollo)

###Preparing environment
apollo_initialise()

###Options controlling the running of the code
apollo_control = list(
  modelName  ="P_RRM",
  modelDescr ="P-RRM model",
  indivID    ="ID"
)

###Reading in database
database <- read.delim("Shopping_data_with_headers.dat",header=TRUE)

###Parameters to be estimated and their starting values
apollo_beta=c(B_FSG = 0,
              B_FSO = 0,
              B_TT  = 0)

###Fixed parameters: should be in quotes
apollo_fixed = c()
###Search the user work space for all necessary input 
apollo_inputs = apollo_validateInputs()

###Probability function
apollo_probabilities=function(apollo_beta, apollo_inputs, functionality="estimate"){
  
  ###Attaches parameters and data so that variables can be referred by name
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  

  
  P_FSG1 = ( - 1 / 1000 ) * ( pmax( 0 , FSG2 - FSG1 ) + pmax( 0 , FSG3 - FSG1 ) + pmax( 0 , FSG4 - FSG1 ) + pmax( 0 , FSG5 - FSG1 ) )
  P_FSG2 = ( - 1 / 1000 ) * ( pmax( 0 , FSG1 - FSG2 ) + pmax( 0 , FSG3 - FSG2 ) + pmax( 0 , FSG4 - FSG2 ) + pmax( 0 , FSG5 - FSG2 ) )
  P_FSG3 = ( - 1 / 1000 ) * ( pmax( 0 , FSG1 - FSG3 ) + pmax( 0 , FSG2 - FSG3 ) + pmax( 0 , FSG4 - FSG3 ) + pmax( 0 , FSG5 - FSG3 ) )
  P_FSG4 = ( - 1 / 1000 ) * ( pmax( 0 , FSG1 - FSG4 ) + pmax( 0 , FSG2 - FSG4 ) + pmax( 0 , FSG3 - FSG4 ) + pmax( 0 , FSG5 - FSG4 ) )
  P_FSG5 = ( - 1 / 1000 ) * ( pmax( 0 , FSG1 - FSG5 ) + pmax( 0 , FSG2 - FSG5 ) + pmax( 0 , FSG3 - FSG5 ) + pmax( 0 , FSG4 - FSG5 ) )
  
  P_FSO1 = ( - 1 / 1000 ) * ( pmax( 0 , FSO2 - FSO1 ) + pmax( 0 , FSO3 - FSO1 ) + pmax( 0 , FSO4 - FSO1 ) + pmax( 0 , FSO5 - FSO1 ) )
  P_FSO2 = ( - 1 / 1000 ) * ( pmax( 0 , FSO1 - FSO2 ) + pmax( 0 , FSO3 - FSO2 ) + pmax( 0 , FSO4 - FSO2 ) + pmax( 0 , FSO5 - FSO2 ) )
  P_FSO3 = ( - 1 / 1000 ) * ( pmax( 0 , FSO1 - FSO3 ) + pmax( 0 , FSO2 - FSO3 ) + pmax( 0 , FSO4 - FSO3 ) + pmax( 0 , FSO5 - FSO3 ) )
  P_FSO4 = ( - 1 / 1000 ) * ( pmax( 0 , FSO1 - FSO4 ) + pmax( 0 , FSO2 - FSO4 ) + pmax( 0 , FSO3 - FSO4 ) + pmax( 0 , FSO5 - FSO4 ) )
  P_FSO5 = ( - 1 / 1000 ) * ( pmax( 0 , FSO1 - FSO5 ) + pmax( 0 , FSO2 - FSO5 ) + pmax( 0 , FSO3 - FSO5 ) + pmax( 0 , FSO4 - FSO5 ) )
  
  P_TT1 = ( - 1 / 100 ) * ( pmin( 0 , TT2 - TT1 ) + pmin( 0 , TT3 - TT1 ) + pmin( 0 , TT4 - TT1 ) + pmin( 0 , TT5 - TT1 ) )
  P_TT2 = ( - 1 / 100 ) * ( pmin( 0 , TT1 - TT2 ) + pmin( 0 , TT3 - TT2 ) + pmin( 0 , TT4 - TT2 ) + pmin( 0 , TT5 - TT2 ) )
  P_TT3 = ( - 1 / 100 ) * ( pmin( 0 , TT1 - TT3 ) + pmin( 0 , TT2 - TT3 ) + pmin( 0 , TT4 - TT3 ) + pmin( 0 , TT5 - TT3 ) )
  P_TT4 = ( - 1 / 100 ) * ( pmin( 0 , TT1 - TT4 ) + pmin( 0 , TT2 - TT4 ) + pmin( 0 , TT3 - TT4 ) + pmin( 0 , TT5 - TT4 ) )
  P_TT5 = ( - 1 / 100 ) * ( pmin( 0 , TT1 - TT5 ) + pmin( 0 , TT2 - TT5 ) + pmin( 0 , TT3 - TT5 ) + pmin( 0 , TT4 - TT5 ) )
  
  
  ### List of regret functions
  R = list()
  R[['Alt1']]  =  B_FSG * P_FSG1 + B_FSO * P_FSO1 + B_TT * P_TT1
  R[['Alt2']]  =  B_FSG * P_FSG2 + B_FSO * P_FSO2 + B_TT * P_TT2
  R[['Alt3']]  =  B_FSG * P_FSG3 + B_FSO * P_FSO3 + B_TT * P_TT3
  R[['Alt4']]  =  B_FSG * P_FSG4 + B_FSO * P_FSO4 + B_TT * P_TT4
  R[['Alt5']]  =  B_FSG * P_FSG5 + B_FSO * P_FSO5 + B_TT * P_TT5
  
  ###Input for calculating MNL probabilities
  mnl_settings = list(
    alternatives  = c(Alt1=1, Alt2=2, Alt3=3, Alt4=4, Alt5=5), 
    avail         = list(Alt1=1, Alt2=1, Alt3=1, Alt4=1, Alt5=1),
    choiceVar     = CHOICE,
    V             = R
  )
 
  ###Calculating probabilities based on MNL function
  P = list()
  P[['model']] = apollo_mnl(mnl_settings, functionality)
  P = apollo_panelProd(P, apollo_inputs, functionality)  # Multiply likelihood of observations from the same individual
  P = apollo_prepareProb(P, apollo_inputs, functionality)# Check that probabilities are in the appropiate format to be returned.
  return(P)
}

###Estimate the model                         
model = apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)


###Display the output to console with p-values
apollo_modelOutput(model,modelOutput_settings=list(printPVal=TRUE))




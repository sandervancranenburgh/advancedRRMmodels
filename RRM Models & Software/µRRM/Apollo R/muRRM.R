##############################################
# file: mu_RRM.R
# author: Sander van Cranenburgh
# date: 02/08/2019
##############################################

library(apollo)

###Preparing environment
apollo_initialise()

###Options controlling the running of the code
apollo_control = list(
  modelName  ="muRRM",
  modelDescr ="muRRM model",
  indivID    ="ID"
)


###Reading in database
database <- read.delim("Shopping_data_with_headers.dat",header=TRUE)

###Parameters to be estimated and their starting values
apollo_beta=c(B_FSG = 0,
              B_FSO = 0,
              B_TT  = 0,
              mu    = 1)
###Fixed parameters: should be in quotes 
apollo_fixed = c()

###Search the user work space for all necessary input 
apollo_inputs = apollo_validateInputs()


###Probability function
apollo_probabilities=function(apollo_beta, apollo_inputs, functionality="estimate"){

  ###Attaches parameters and data so that variables can be referred by name
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  ### Pairwise comparison and scale of attribues
  
  ### Floorspace Groceries
  FSG2_1 = ( FSG2 - FSG1 ) / 1000
  FSG3_1 = ( FSG3 - FSG1 ) / 1000
  FSG4_1 = ( FSG4 - FSG1 ) / 1000
  FSG5_1 = ( FSG5 - FSG1 ) / 1000
  
  FSG1_2 = ( FSG1 - FSG2 ) / 1000
  FSG3_2 = ( FSG3 - FSG2 ) / 1000
  FSG4_2 = ( FSG4 - FSG2 ) / 1000
  FSG5_2 = ( FSG5 - FSG2 ) / 1000
  
  FSG1_3 = ( FSG1 - FSG3 ) / 1000
  FSG2_3 = ( FSG2 - FSG3 ) / 1000
  FSG4_3 = ( FSG4 - FSG3 ) / 1000
  FSG5_3 = ( FSG5 - FSG3 ) / 1000
  
  FSG1_4 = ( FSG1 - FSG4 ) / 1000
  FSG2_4 = ( FSG2 - FSG4 ) / 1000
  FSG3_4 = ( FSG3 - FSG4 ) / 1000
  FSG5_4 = ( FSG5 - FSG4 ) / 1000
  
  FSG1_5 = ( FSG1 - FSG5 ) / 1000
  FSG2_5 = ( FSG2 - FSG5 ) / 1000
  FSG3_5 = ( FSG3 - FSG5 ) / 1000
  FSG4_5 = ( FSG4 - FSG5 ) / 1000
  
  ### Floorspace Other
  FSO2_1 = ( FSO2 - FSO1 ) / 1000
  FSO3_1 = ( FSO3 - FSO1 ) / 1000
  FSO4_1 = ( FSO4 - FSO1 ) / 1000
  FSO5_1 = ( FSO5 - FSO1 ) / 1000
  
  FSO1_2 = ( FSO1 - FSO2 ) / 1000
  FSO3_2 = ( FSO3 - FSO2 ) / 1000
  FSO4_2 = ( FSO4 - FSO2 ) / 1000
  FSO5_2 = ( FSO5 - FSO2 ) / 1000
  
  FSO1_3 = ( FSO1 - FSO3 ) / 1000
  FSO2_3 = ( FSO2 - FSO3 ) / 1000
  FSO4_3 = ( FSO4 - FSO3 ) / 1000
  FSO5_3 = ( FSO5 - FSO3 ) / 1000
  
  FSO1_4 = ( FSO1 - FSO4 ) / 1000
  FSO2_4 = ( FSO2 - FSO4 ) / 1000
  FSO3_4 = ( FSO3 - FSO4 ) / 1000
  FSO5_4 = ( FSO5 - FSO4 ) / 1000
  
  FSO1_5 = ( FSO1 - FSO5 ) / 1000
  FSO2_5 = ( FSO2 - FSO5 ) / 1000
  FSO3_5 = ( FSO3 - FSO5 ) / 1000
  FSO4_5 = ( FSO4 - FSO5 ) / 1000
  
  ### Travel time
  TT2_1 = ( TT2 - TT1 ) / 100
  TT3_1 = ( TT3 - TT1 ) / 100
  TT4_1 = ( TT4 - TT1 ) / 100
  TT5_1 = ( TT5 - TT1 ) / 100
  
  TT1_2 = ( TT1 - TT2 ) / 100
  TT3_2 = ( TT3 - TT2 ) / 100
  TT4_2 = ( TT4 - TT2 ) / 100
  TT5_2 = ( TT5 - TT2 ) / 100
  
  TT1_3 = ( TT1 - TT3 ) / 100
  TT2_3 = ( TT2 - TT3 ) / 100
  TT4_3 = ( TT4 - TT3 ) / 100
  TT5_3 = ( TT5 - TT3 ) / 100
  
  TT1_4 = ( TT1 - TT4 ) / 100
  TT2_4 = ( TT2 - TT4 ) / 100
  TT3_4 = ( TT3 - TT4 ) / 100
  TT5_4 = ( TT5 - TT4 ) / 100
  
  TT1_5 = ( TT1 - TT5 ) / 100
  TT2_5 = ( TT2 - TT5 ) / 100
  TT3_5 = ( TT3 - TT5 ) / 100
  TT4_5 = ( TT4 - TT5 ) / 100  
  
  ### List of regret functions
  R = list()
  R[['Alt1']]  =  mu * ( - log( 1 + exp( ( B_FSG / mu ) * FSG2_1 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG3_1 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG4_1 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG5_1 ) )- log( 1 + exp( ( B_FSO / mu ) * FSO2_1 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO3_1 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO4_1 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO5_1 ) )- log( 1 + exp( ( B_TT / mu ) * TT2_1 ) ) - log( 1 + exp( ( B_TT / mu ) * TT3_1 ) ) - log( 1 + exp( ( B_TT / mu ) * TT4_1 ) ) - log( 1 + exp( ( B_TT / mu ) * TT5_1 ) ) )
  R[['Alt2']]  =  mu * ( - log( 1 + exp( ( B_FSG / mu ) * FSG1_2 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG3_2 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG4_2 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG5_2 ) )- log( 1 + exp( ( B_FSO / mu ) * FSO1_2 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO3_2 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO4_2 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO5_2 ) )- log( 1 + exp( ( B_TT / mu ) * TT1_2 ) ) - log( 1 + exp( ( B_TT / mu ) * TT3_2 ) ) - log( 1 + exp( ( B_TT / mu ) * TT4_2 ) ) - log( 1 + exp( ( B_TT / mu ) * TT5_2 ) ) )
  R[['Alt3']]  =  mu * ( - log( 1 + exp( ( B_FSG / mu ) * FSG1_3 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG2_3 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG4_3 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG5_3 ) )- log( 1 + exp( ( B_FSO / mu ) * FSO1_3 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO2_3 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO4_3 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO5_3 ) )- log( 1 + exp( ( B_TT / mu ) * TT1_3 ) ) - log( 1 + exp( ( B_TT / mu ) * TT2_3 ) ) - log( 1 + exp( ( B_TT / mu ) * TT4_3 ) ) - log( 1 + exp( ( B_TT / mu ) * TT5_3 ) ) )
  R[['Alt4']]  =  mu * ( - log( 1 + exp( ( B_FSG / mu ) * FSG1_4 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG2_4 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG3_4 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG5_4 ) )- log( 1 + exp( ( B_FSO / mu ) * FSO1_4 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO2_4 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO3_4 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO5_4 ) )- log( 1 + exp( ( B_TT / mu ) * TT1_4 ) ) - log( 1 + exp( ( B_TT / mu ) * TT2_4 ) ) - log( 1 + exp( ( B_TT / mu ) * TT3_4 ) ) - log( 1 + exp( ( B_TT / mu ) * TT5_4 ) ) )
  R[['Alt5']]  =  mu * ( - log( 1 + exp( ( B_FSG / mu ) * FSG1_5 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG2_5 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG3_5 ) ) - log( 1 + exp( ( B_FSG / mu ) * FSG4_5 ) )- log( 1 + exp( ( B_FSO / mu ) * FSO1_5 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO2_5 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO3_5 ) ) - log( 1 + exp( ( B_FSO / mu ) * FSO4_5 ) )- log( 1 + exp( ( B_TT / mu ) * TT1_5 ) ) - log( 1 + exp( ( B_TT / mu ) * TT2_5 ) ) - log( 1 + exp( ( B_TT / mu ) * TT3_5 ) ) - log( 1 + exp( ( B_TT / mu ) * TT4_5 ) ) )

  
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



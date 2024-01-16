##############################################
# file: LC_RUM_PRRM_2classes.R
# author: Sander van Cranenburgh & Teodora Szep
# date: 02/08/2019
##############################################

library(apollo)

###Preparing environment
apollo_initialise()

###Options controlling the running of the code
apollo_control = list(
  modelName  ="LC_RUM_PRRM_2classes",
  modelDescr ="Latent class with 2 classes: RUM and PRRM",
  indivID    ="ID",
  nCores     = 2 
)

###Reading in database
database = read.delim("Shopping_data_with_headers.dat",header=TRUE)

###Parameters to be estimated and their starting values
apollo_beta = c(# Class 1
                B_FSG_1 = 0,
                B_FSO_1 = 0,
                B_TT_1  = 0,
                # Class 2
                B_FSG_2 = 0,
                B_FSO_2 = 0,
                B_TT_2  = -0.2,
                # Class membership parameters
                s_1     = 0,
                s_2     = 0)

###Fixed parameters: should be in quotes 
apollo_fixed = c("s_1")

###Grouping latent class parameters
apollo_lcPars = function(apollo_beta, apollo_inputs){
  lcpars = list()
  lcpars[["B_FSG"]] = list(B_FSG_1, B_FSG_2)
  lcpars[["B_FSO"]] = list(B_FSO_1, B_FSO_2)
  lcpars[["B_TT"]]  = list(B_TT_1, B_TT_2)
  
  ###Class membership probabilities based on s_1, s_2: use of MNL fomula
  V=list()
  V[["class_1"]] = s_1
  V[["class_2"]] = s_2
  
  ###Settings for class membership probabilities 
  mnl_settings = list(
    alternatives = c(class_1=1, class_2=2), 
    avail        = 1, 
    choiceVar    = NA, ###No choice variable as only the formula of MNL is used
    V            = V
  )
  ###Class membership probabilities
  lcpars[["pi_values"]] = apollo_mnl(mnl_settings, functionality="raw")
  lcpars[["pi_values"]] = apollo_firstRow(lcpars[["pi_values"]], apollo_inputs)
  return(lcpars)
}

###Search the user work space for all necessary input 
apollo_inputs = apollo_validateInputs()

###Probability function
apollo_probabilities=function(apollo_beta, apollo_inputs, functionality="estimate"){
  
  ###Attaches parameters and data so that variables can be referred by name
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  ### Pairwise comparison and scale of attribues
  
  # Define PRRM variables
  FSG1_sc =( 1 / 1000 ) * FSG1 
  FSG2_sc =( 1 / 1000 ) * FSG2 
  FSG3_sc =( 1 / 1000 ) * FSG3 
  FSG4_sc =( 1 / 1000 ) * FSG4 
  FSG5_sc =( 1 / 1000 ) * FSG5 
  
  FSO1_sc =( 1 / 1000 ) * FSO1 
  FSO2_sc =( 1 / 1000 ) * FSO2 
  FSO3_sc =( 1 / 1000 ) * FSO3 
  FSO4_sc =( 1 / 1000 ) * FSO4 
  FSO5_sc =( 1 / 1000 ) * FSO5 
  
  TT1_sc = ( 1 / 100 ) * TT1 
  TT2_sc = ( 1 / 100 ) * TT2 
  TT3_sc = ( 1 / 100 ) * TT3 
  TT4_sc = ( 1 / 100 ) * TT4 
  TT5_sc = ( 1 / 100 ) * TT5 
  
  # Compute P-RRM Atrribute levels
  X_FSG1 =  pmax( 0 , FSG2_sc - FSG1_sc ) + pmax( 0 , FSG3_sc - FSG1_sc ) + pmax( 0 , FSG4_sc - FSG1_sc ) + pmax( 0 , FSG5_sc - FSG1_sc ) 
  X_FSG2 =  pmax( 0 , FSG1_sc - FSG2_sc ) + pmax( 0 , FSG3_sc - FSG2_sc ) + pmax( 0 , FSG4_sc - FSG2_sc ) + pmax( 0 , FSG5_sc - FSG2_sc ) 
  X_FSG3 =  pmax( 0 , FSG1_sc - FSG3_sc ) + pmax( 0 , FSG2_sc - FSG3_sc ) + pmax( 0 , FSG4_sc - FSG3_sc ) + pmax( 0 , FSG5_sc - FSG3_sc ) 
  X_FSG4 =  pmax( 0 , FSG1_sc - FSG4_sc ) + pmax( 0 , FSG2_sc - FSG4_sc ) + pmax( 0 , FSG3_sc - FSG4_sc ) + pmax( 0 , FSG5_sc - FSG4_sc ) 
  X_FSG5 =  pmax( 0 , FSG1_sc - FSG5_sc ) + pmax( 0 , FSG2_sc - FSG5_sc ) + pmax( 0 , FSG3_sc - FSG5_sc ) + pmax( 0 , FSG4_sc - FSG5_sc ) 
  
  X_FSO1 =  pmin( 0 , FSO2_sc - FSO1_sc ) + pmin( 0 , FSO3_sc - FSO1_sc ) + pmin( 0 , FSO4_sc - FSO1_sc ) + pmin( 0 , FSO5_sc - FSO1_sc ) 
  X_FSO2 =  pmin( 0 , FSO1_sc - FSO2_sc ) + pmin( 0 , FSO3_sc - FSO2_sc ) + pmin( 0 , FSO4_sc - FSO2_sc ) + pmin( 0 , FSO5_sc - FSO2_sc ) 
  X_FSO3 =  pmin( 0 , FSO1_sc - FSO3_sc ) + pmin( 0 , FSO2_sc - FSO3_sc ) + pmin( 0 , FSO4_sc - FSO3_sc ) + pmin( 0 , FSO5_sc - FSO3_sc ) 
  X_FSO4 =  pmin( 0 , FSO1_sc - FSO4_sc ) + pmin( 0 , FSO2_sc - FSO4_sc ) + pmin( 0 , FSO3_sc - FSO4_sc ) + pmin( 0 , FSO5_sc - FSO4_sc ) 
  X_FSO5 =  pmin( 0 , FSO1_sc - FSO5_sc ) + pmin( 0 , FSO2_sc - FSO5_sc ) + pmin( 0 , FSO3_sc - FSO5_sc ) + pmin( 0 , FSO4_sc - FSO5_sc ) 
  
  X_TT1 = pmin( 0 , TT2_sc - TT1_sc ) + pmin( 0 , TT3_sc - TT1_sc ) + pmin( 0 , TT4_sc - TT1_sc ) + pmin( 0 , TT5_sc - TT1_sc ) 
  X_TT2 = pmin( 0 , TT1_sc - TT2_sc ) + pmin( 0 , TT3_sc - TT2_sc ) + pmin( 0 , TT4_sc - TT2_sc ) + pmin( 0 , TT5_sc - TT2_sc ) 
  X_TT3 = pmin( 0 , TT1_sc - TT3_sc ) + pmin( 0 , TT2_sc - TT3_sc ) + pmin( 0 , TT4_sc - TT3_sc ) + pmin( 0 , TT5_sc - TT3_sc ) 
  X_TT4 = pmin( 0 , TT1_sc - TT4_sc ) + pmin( 0 , TT2_sc - TT4_sc ) + pmin( 0 , TT3_sc - TT4_sc ) + pmin( 0 , TT5_sc - TT4_sc ) 
  X_TT5 = pmin( 0 , TT1_sc - TT5_sc ) + pmin( 0 , TT2_sc - TT5_sc ) + pmin( 0 , TT3_sc - TT5_sc ) + pmin( 0 , TT4_sc - TT5_sc ) 
  
  
  ###Create list for probabilities
  P = list()
  
  ###Input for calculating MNL probabilities
  mnl_settings = list(
    alternatives  = c(Alt1=1, Alt2=2, Alt3=3, Alt4=4, Alt5=5), 
    avail         = list(Alt1=1, Alt2=1, Alt3=1, Alt4=1, Alt5=1),
    choiceVar     = CHOICE
  )
  
  ### Compute class-specific utilities
  V=list()
  V[['Alt1']]  = B_FSG_1 * FSG1_sc + B_FSO_1 * FSO1_sc + B_TT_1 * TT1_sc
  V[['Alt2']]  = B_FSG_1 * FSG2_sc + B_FSO_1 * FSO2_sc + B_TT_1 * TT2_sc
  V[['Alt3']]  = B_FSG_1 * FSG3_sc + B_FSO_1 * FSO3_sc + B_TT_1 * TT3_sc
  V[['Alt4']]  = B_FSG_1 * FSG4_sc + B_FSO_1 * FSO4_sc + B_TT_1 * TT4_sc
  V[['Alt5']]  = B_FSG_1 * FSG5_sc + B_FSO_1 * FSO5_sc + B_TT_1 * TT5_sc
  
  ###Calculating probabilities based on MNL function for class 1
  mnl_settings$V = V
  P[[1]] = apollo_mnl(mnl_settings, functionality)
  P[[1]] = apollo_panelProd(P[[1]], apollo_inputs ,functionality)
  
  ### Compute class-specific regrets
  R=list()
  R[['Alt1']]  = B_FSG_2 * X_FSG1 + B_FSO_2 * X_FSO1 + B_TT_2 * X_TT1
  R[['Alt2']]  = B_FSG_2 * X_FSG2 + B_FSO_2 * X_FSO2 + B_TT_2 * X_TT2 
  R[['Alt3']]  = B_FSG_2 * X_FSG3 + B_FSO_2 * X_FSO3 + B_TT_2 * X_TT3 
  R[['Alt4']]  = B_FSG_2 * X_FSG4 + B_FSO_2 * X_FSO4 + B_TT_2 * X_TT4
  R[['Alt5']]  = B_FSG_2 * X_FSG5 + B_FSO_2 * X_FSO5 + B_TT_2 * X_TT5 
  
  ###Calculating probabilities based on MNL function for class 2
  mnl_settings$V = lapply(R, "*", -1) ###the regrets must be negative (and used in MNL-settings as V)
  P[[2]] = apollo_mnl(mnl_settings, functionality)
  P[[2]] = apollo_panelProd(P[[2]], apollo_inputs ,functionality)
  
  ###Calculating choice probabilities using class membership and conditional probabilities 
  lc_settings   = list(inClassProb = P, classProb=pi_values)
  P[["model"]] = apollo_lc(lc_settings, apollo_inputs, functionality)
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}


### Optional: searching for starting value
apollo_beta = apollo_searchStart(apollo_beta,
                                  apollo_fixed,
                                  apollo_probabilities,
                                  apollo_inputs,
                                  searchStart_settings=list(nCandidates=20))
###Estimate the model  
model = apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs, estimate_settings=list(hessianRoutine="maxLik"))

###Display the output to console with p-values
apollo_modelOutput(model)

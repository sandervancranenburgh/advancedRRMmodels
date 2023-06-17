##############################################
# file: LC_muRRM_2classes.R
# author: Sander van Cranenburgh & Teodora Szep
# date: 02/08/2019
##############################################

library(apollo)

###Preparing environment
apollo_initialise()

###Options controlling the running of the code
apollo_control = list(
  modelName  ="LC_muRRM_2classes",
  modelDescr ="Latent class with 2 classes of muRRM",
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
                mu_1    = 1,
                # Class 2
                B_FSG_2 = 0,
                B_FSO_2 = 0,
                B_TT_2  = 0,
                mu_2    = 1,
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
  lcpars[["mu"]]    = list(mu_1, mu_2)
  
  ###Class membership probabilities based on s_1, s_2: use of MNL fomula
  V=list()
  V[["class_a"]] = s_1
  V[["class_b"]] = s_2
  
  ###Settings for class membership probabilities 
  mnl_settings = list(
    alternatives = c(class_a=1, class_b=2), 
    avail        = 1, 
    choiceVar    = NA,  ###No choice variable as only the formula of MNL is used
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
  


  ###Create list for probabilities
  P = list()
  
  ###Input for calculating MNL probabilities
  mnl_settings = list(
    alternatives  = c(Alt1=1, Alt2=2, Alt3=3, Alt4=4, Alt5=5), 
    avail         = list(Alt1=1, Alt2=1, Alt3=1, Alt4=1, Alt5=1),
    choiceVar     = CHOICE
  )
  
  ### Loop over classes (both classes use the same formula (mu-RRM))
  s=1
  while(s<=2){
    
    ### Compute the class-specific regrets
    R=list()
    R[['Alt1']]  = mu[[s]] * (log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG2_1 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG3_1 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG4_1 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG5_1 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO2_1 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO3_1 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO4_1 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO5_1 ) ) +
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT2_1  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT3_1  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT4_1  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT5_1  ) ))
    R[['Alt2']]  = mu[[s]] * (log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG1_2 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG3_2 ) ) +
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG4_2 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG5_2 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO1_2 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO3_2 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO4_2 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO5_2 ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT1_2  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT3_2  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT4_2  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT5_2  ) ))
    R[['Alt3']]  = mu[[s]] * (log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG1_3 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG2_3 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG4_3 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG5_3 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO1_3 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO2_3 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO4_3 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO5_3 ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT1_3  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT2_3  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT4_3  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT5_3  ) ))
    R[['Alt4']] = mu[[s]] *  (log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG1_4 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG2_4 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG3_4 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG5_4 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO1_4 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO2_4 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO3_4 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO5_4 ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT1_4  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT2_4  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT3_4  ) ) + 
                              log( 1 + exp( ( B_TT[[s]]  / mu[[s]] ) * TT5_4  ) ))
    R[['Alt5']] = mu[[s]] * (log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG1_5 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG2_5 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG3_5 ) ) + 
                              log( 1 + exp( ( B_FSG[[s]] / mu[[s]] ) * FSG4_5 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO1_5 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO2_5 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO3_5 ) ) + 
                              log( 1 + exp( ( B_FSO[[s]] / mu[[s]] ) * FSO4_5 ) ) + 
                              log( 1 + exp( (  B_TT[[s]] / mu[[s]] ) * TT1_5  ) ) + 
                              log( 1 + exp( (  B_TT[[s]] / mu[[s]] ) * TT2_5  ) ) + 
                              log( 1 + exp( (  B_TT[[s]] / mu[[s]] ) * TT3_5  ) ) + 
                              log( 1 + exp( (  B_TT[[s]] / mu[[s]] ) * TT4_5  ) ))  
  
     ###Calculating probabilities based on MNL function for both classes
     mnl_settings$V = lapply(R, "*", -1) ###the regrets must be negative (and used in MNL-settings as V)
    
    P[[s]] = apollo_mnl(mnl_settings, functionality)
    P[[s]] = apollo_panelProd(P[[s]], apollo_inputs ,functionality)
  
    s=s+1
  }
  
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




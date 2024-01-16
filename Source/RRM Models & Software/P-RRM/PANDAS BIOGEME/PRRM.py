########################################
#
# @file PRRM.py
# @author: Sander van Cranenburgh
# @date: 26/07/2016
#
#######################################

import pandas as pd
import biogeme.database as db
import biogeme.biogeme as bio
from biogeme.expressions import Beta, DefineVariable,Variable, log,exp,MonteCarlo,bioMax, bioMin, PanelLikelihoodTrajectory
import biogeme.models as models
import numpy as np

dat = pd.read_csv("Shopping_data_with_headers.dat",sep='\t')
database = db.Database("Shopping",dat)

# Create variables FSG1 to FSG5
FSG1 = Variable('FSG1')
FSG2 = Variable('FSG2')
FSG3 = Variable('FSG3')
FSG4 = Variable('FSG4')
FSG5 = Variable('FSG5')

# Create variables FSO1 to FSO5
FSO1 = Variable('FSO1')
FSO2 = Variable('FSO2')
FSO3 = Variable('FSO3')
FSO4 = Variable('FSO4')
FSO5 = Variable('FSO5')

# Create variables TT1 to TT5
TT1 = Variable('TT1')
TT2 = Variable('TT2')
TT3 = Variable('TT3')
TT4 = Variable('TT4')
TT5 = Variable('TT5')

CHOICE = Variable('CHOICE')


# Rescale variables to ease numerical estimation
FSG1_sc = database.DefineVariable('FSG1_sc', ( 1 / 1000) * FSG1 )
FSG2_sc = database.DefineVariable('FSG2_sc', ( 1 / 1000) * FSG2 )
FSG3_sc = database.DefineVariable('FSG3_sc', ( 1 / 1000) * FSG3 )
FSG4_sc = database.DefineVariable('FSG4_sc', ( 1 / 1000) * FSG4 )
FSG5_sc = database.DefineVariable('FSG5_sc', ( 1 / 1000) * FSG5 )

FSO1_sc = database.DefineVariable('FSO1_sc', ( 1 / 1000 ) * FSO1 )
FSO2_sc = database.DefineVariable('FSO2_sc', ( 1 / 1000 ) * FSO2 )
FSO3_sc = database.DefineVariable('FSO3_sc', ( 1 / 1000 ) * FSO3 )
FSO4_sc = database.DefineVariable('FSO4_sc', ( 1 / 1000 ) * FSO4 )
FSO5_sc = database.DefineVariable('FSO5_sc', ( 1 / 1000 ) * FSO5 )

TT1_sc = database.DefineVariable('TT1_sc', ( 1 / 100 ) * TT1 )
TT2_sc = database.DefineVariable('TT2_sc', ( 1 / 100 ) * TT2 )
TT3_sc = database.DefineVariable('TT3_sc', ( 1 / 100 ) * TT3 )
TT4_sc = database.DefineVariable('TT4_sc', ( 1 / 100 ) * TT4 )
TT5_sc = database.DefineVariable('TT5_sc', ( 1 / 100 ) * TT5 )


# Compute P-RRM attribute levels
X_FSG1 = database.DefineVariable('X_FSG1', ( bioMax( 0 , FSG2_sc - FSG1_sc ) + bioMax( 0 , FSG3_sc - FSG1_sc ) + bioMax( 0 , FSG4_sc - FSG1_sc ) + bioMax( 0 , FSG5_sc - FSG1_sc )))
X_FSG2 = database.DefineVariable('X_FSG2', ( bioMax( 0 , FSG1_sc - FSG2_sc ) + bioMax( 0 , FSG3_sc - FSG2_sc ) + bioMax( 0 , FSG4_sc - FSG2_sc ) + bioMax( 0 , FSG5_sc - FSG2_sc )))
X_FSG3 = database.DefineVariable('X_FSG3', ( bioMax( 0 , FSG1_sc - FSG3_sc ) + bioMax( 0 , FSG2_sc - FSG3_sc ) + bioMax( 0 , FSG4_sc - FSG3_sc ) + bioMax( 0 , FSG5_sc - FSG3_sc )))
X_FSG4 = database.DefineVariable('X_FSG4', ( bioMax( 0 , FSG1_sc - FSG4_sc ) + bioMax( 0 , FSG2_sc - FSG4_sc ) + bioMax( 0 , FSG3_sc - FSG4_sc ) + bioMax( 0 , FSG5_sc - FSG4_sc )))
X_FSG5 = database.DefineVariable('X_FSG5', ( bioMax( 0 , FSG1_sc - FSG5_sc ) + bioMax( 0 , FSG2_sc - FSG5_sc ) + bioMax( 0 , FSG3_sc - FSG5_sc ) + bioMax( 0 , FSG4_sc - FSG5_sc )))

X_FSO1 = database.DefineVariable('X_FSO1', ( bioMax( 0 , FSO2_sc - FSO1_sc ) + bioMax( 0 , FSO3_sc - FSO1_sc ) + bioMax( 0 , FSO4_sc - FSO1_sc ) + bioMax( 0 , FSO5_sc - FSO1_sc )))
X_FSO2 = database.DefineVariable('X_FSO2', ( bioMax( 0 , FSO1_sc - FSO2_sc ) + bioMax( 0 , FSO3_sc - FSO2_sc ) + bioMax( 0 , FSO4_sc - FSO2_sc ) + bioMax( 0 , FSO5_sc - FSO2_sc )))
X_FSO3 = database.DefineVariable('X_FSO3', ( bioMax( 0 , FSO1_sc - FSO3_sc ) + bioMax( 0 , FSO2_sc - FSO3_sc ) + bioMax( 0 , FSO4_sc - FSO3_sc ) + bioMax( 0 , FSO5_sc - FSO3_sc )))
X_FSO4 = database.DefineVariable('X_FSO4', ( bioMax( 0 , FSO1_sc - FSO4_sc ) + bioMax( 0 , FSO2_sc - FSO4_sc ) + bioMax( 0 , FSO3_sc - FSO4_sc ) + bioMax( 0 , FSO5_sc - FSO4_sc )))
X_FSO5 = database.DefineVariable('X_FSO5', ( bioMax( 0 , FSO1_sc - FSO5_sc ) + bioMax( 0 , FSO2_sc - FSO5_sc ) + bioMax( 0 , FSO3_sc - FSO5_sc ) + bioMax( 0 , FSO4_sc - FSO5_sc )))

X_TT1 = database.DefineVariable('X_TT1', ( bioMin( 0 , TT2_sc - TT1_sc ) + bioMin( 0 , TT3_sc - TT1_sc ) + bioMin( 0 , TT4_sc - TT1_sc ) + bioMin( 0 , TT5_sc - TT1_sc )))
X_TT2 = database.DefineVariable('X_TT2', ( bioMin( 0 , TT1_sc - TT2_sc ) + bioMin( 0 , TT3_sc - TT2_sc ) + bioMin( 0 , TT4_sc - TT2_sc ) + bioMin( 0 , TT5_sc - TT2_sc )))
X_TT3 = database.DefineVariable('X_TT3', ( bioMin( 0 , TT1_sc - TT3_sc ) + bioMin( 0 , TT2_sc - TT3_sc ) + bioMin( 0 , TT4_sc - TT3_sc ) + bioMin( 0 , TT5_sc - TT3_sc )))
X_TT4 = database.DefineVariable('X_TT4', ( bioMin( 0 , TT1_sc - TT4_sc ) + bioMin( 0 , TT2_sc - TT4_sc ) + bioMin( 0 , TT3_sc - TT4_sc ) + bioMin( 0 , TT5_sc - TT4_sc )))
X_TT5 = database.DefineVariable('X_TT5', ( bioMin( 0 , TT1_sc - TT5_sc ) + bioMin( 0 , TT2_sc - TT5_sc ) + bioMin( 0 , TT3_sc - TT5_sc ) + bioMin( 0 , TT4_sc - TT5_sc )))

#Parameters to be estimated
# Arguments:
#   - 1  Name for report; Typically, the same as the variable.
#   - 2  Starting value.
#   - 3  Lower bound.
#   - 4  Upper bound.
#   - 5  0: estimate the parameter, 1: keep it fixed.


B_FSG = Beta('Floor space groceries',0,-10,10,0)
B_FSO = Beta('Floor space other',0,-10,10,0)
B_TT  = Beta('Travel time',0,-10,10,0)

# P-RRM Regret functions
R1 = B_FSG * X_FSG1 + B_FSO * X_FSO1 + B_TT * X_TT1 
R2 = B_FSG * X_FSG2 + B_FSO * X_FSO2 + B_TT * X_TT2 
R3 = B_FSG * X_FSG3 + B_FSO * X_FSO3 + B_TT * X_TT3
R4 = B_FSG * X_FSG4 + B_FSO * X_FSO4 + B_TT * X_TT4
R5 = B_FSG * X_FSG5 + B_FSO * X_FSO5 + B_TT * X_TT5 

# Associate utility functions with the numbering of alternatives
V = {1: -R1,
     2: -R2,
     3: -R3,
     4: -R4,
     5: -R5}

# Associate the availability conditions with the alternatives
one =  1

av = {1: one,
      2: one,
      3: one,
      4: one,
      5: one}

# The choice model is a logit, with availability conditions
logprob = bioLogLogit(V,av,CHOICE)

biogeme = bio.BIOGEME(database,logprob)

biogeme.modelName = "P-RRM"

results = biogeme.estimate()

print("Results=",results)
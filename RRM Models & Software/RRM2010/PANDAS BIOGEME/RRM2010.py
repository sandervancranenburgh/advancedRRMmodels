########################################
#
# @file RRM2010.py
# @author: Sander van Cranenburgh
# @date: 06/11/2015
#
#######################################

import pandas as pd
import biogeme.database as db
import biogeme.biogeme as bio

# Import data
dat = pd.read_csv("Shopping_data_with_headers.dat",sep='\t')
database = db.Database("Shopping",dat)

# Import headers
from headers import *

#Parameters to be estimated
# Arguments:
#   - 1  Name for report; Typically, the same as the variable.
#   - 2  Starting value.
#   - 3  Lower bound.
#   - 4  Upper bound.
#   - 5  0: estimate the parameter, 1: keep it fixed.
#

B_FSG = Beta('Floor space groceries',0,-10,10,0)
B_FSO = Beta('Floor space other',0,-10,10,0)
B_TT  = Beta('Travel time',0,-10,10,0) 

FSG2_1 = DefineVariable('FSG2_1', ( FSG2 - FSG1 ) / 1000,database)
FSG3_1 = DefineVariable('FSG3_1', ( FSG3 - FSG1 ) / 1000,database)
FSG4_1 = DefineVariable('FSG4_1', ( FSG4 - FSG1 ) / 1000,database)
FSG5_1 = DefineVariable('FSG5_1', ( FSG5 - FSG1 ) / 1000,database)

FSG1_2 = DefineVariable('FSG1_2', ( FSG1 - FSG2 ) / 1000,database)
FSG3_2 = DefineVariable('FSG3_2', ( FSG3 - FSG2 ) / 1000,database)
FSG4_2 = DefineVariable('FSG4_2', ( FSG4 - FSG2 ) / 1000,database)
FSG5_2 = DefineVariable('FSG5_2', ( FSG5 - FSG2 ) / 1000,database)

FSG1_3 = DefineVariable('FSG1_3', ( FSG1 - FSG3 ) / 1000,database)
FSG2_3 = DefineVariable('FSG2_3', ( FSG2 - FSG3 ) / 1000,database)
FSG4_3 = DefineVariable('FSG4_3', ( FSG4 - FSG3 ) / 1000,database)
FSG5_3 = DefineVariable('FSG5_3', ( FSG5 - FSG3 ) / 1000,database)

FSG1_4 = DefineVariable('FSG1_4', ( FSG1 - FSG4 ) / 1000,database)
FSG2_4 = DefineVariable('FSG2_4', ( FSG2 - FSG4 ) / 1000,database)
FSG3_4 = DefineVariable('FSG3_4', ( FSG3 - FSG4 ) / 1000,database)
FSG5_4 = DefineVariable('FSG5_4', ( FSG5 - FSG4 ) / 1000,database)

FSG1_5 = DefineVariable('FSG1_5', ( FSG1 - FSG5 ) / 1000,database)
FSG2_5 = DefineVariable('FSG2_5', ( FSG2 - FSG5 ) / 1000,database)
FSG3_5 = DefineVariable('FSG3_5', ( FSG3 - FSG5 ) / 1000,database)
FSG4_5 = DefineVariable('FSG4_5', ( FSG4 - FSG5 ) / 1000,database)

# Floorspace Other
FSO2_1 = DefineVariable('FSO2_1', ( FSO2 - FSO1 ) / 1000,database)
FSO3_1 = DefineVariable('FSO3_1', ( FSO3 - FSO1 ) / 1000,database)
FSO4_1 = DefineVariable('FSO4_1', ( FSO4 - FSO1 ) / 1000,database)
FSO5_1 = DefineVariable('FSO5_1', ( FSO5 - FSO1 ) / 1000,database)

FSO1_2 = DefineVariable('FSO1_2', ( FSO1 - FSO2 ) / 1000,database)
FSO3_2 = DefineVariable('FSO3_2', ( FSO3 - FSO2 ) / 1000,database)
FSO4_2 = DefineVariable('FSO4_2', ( FSO4 - FSO2 ) / 1000,database)
FSO5_2 = DefineVariable('FSO5_2', ( FSO5 - FSO2 ) / 1000,database)

FSO1_3 = DefineVariable('FSO1_3', ( FSO1 - FSO3 ) / 1000,database)
FSO2_3 = DefineVariable('FSO2_3', ( FSO2 - FSO3 ) / 1000,database)
FSO4_3 = DefineVariable('FSO4_3', ( FSO4 - FSO3 ) / 1000,database)
FSO5_3 = DefineVariable('FSO5_3', ( FSO5 - FSO3 ) / 1000,database)

FSO1_4 = DefineVariable('FSO1_4', ( FSO1 - FSO4 ) / 1000,database)
FSO2_4 = DefineVariable('FSO2_4', ( FSO2 - FSO4 ) / 1000,database)
FSO3_4 = DefineVariable('FSO3_4', ( FSO3 - FSO4 ) / 1000,database)
FSO5_4 = DefineVariable('FSO5_4', ( FSO5 - FSO4 ) / 1000,database)

FSO1_5 = DefineVariable('FSO1_5', ( FSO1 - FSO5 ) / 1000,database)
FSO2_5 = DefineVariable('FSO2_5', ( FSO2 - FSO5 ) / 1000,database)
FSO3_5 = DefineVariable('FSO3_5', ( FSO3 - FSO5 ) / 1000,database)
FSO4_5 = DefineVariable('FSO4_5', ( FSO4 - FSO5 ) / 1000,database)

# Travel time
TT2_1 = DefineVariable('TT2_1', ( TT2 - TT1 ) / 100,database)
TT3_1 = DefineVariable('TT3_1', ( TT3 - TT1 ) / 100,database)
TT4_1 = DefineVariable('TT4_1', ( TT4 - TT1 ) / 100,database)
TT5_1 = DefineVariable('TT5_1', ( TT5 - TT1 ) / 100,database)

TT1_2 = DefineVariable('TT1_2', ( TT1 - TT2 ) / 100,database)
TT3_2 = DefineVariable('TT3_2', ( TT3 - TT2 ) / 100,database)
TT4_2 = DefineVariable('TT4_2', ( TT4 - TT2 ) / 100,database)
TT5_2 = DefineVariable('TT5_2', ( TT5 - TT2 ) / 100,database)

TT1_3 = DefineVariable('TT1_3', ( TT1 - TT3 ) / 100,database)
TT2_3 = DefineVariable('TT2_3', ( TT2 - TT3 ) / 100,database)
TT4_3 = DefineVariable('TT4_3', ( TT4 - TT3 ) / 100,database)
TT5_3 = DefineVariable('TT5_3', ( TT5 - TT3 ) / 100,database)

TT1_4 = DefineVariable('TT1_4', ( TT1 - TT4 ) / 100,database)
TT2_4 = DefineVariable('TT2_4', ( TT2 - TT4 ) / 100,database)
TT3_4 = DefineVariable('TT3_4', ( TT3 - TT4 ) / 100,database)
TT5_4 = DefineVariable('TT5_4', ( TT5 - TT4 ) / 100,database)

TT1_5 = DefineVariable('TT1_5', ( TT1 - TT5 ) / 100,database)
TT2_5 = DefineVariable('TT2_5', ( TT2 - TT5 ) / 100,database)
TT3_5 = DefineVariable('TT3_5', ( TT3 - TT5 ) / 100,database)
TT4_5 = DefineVariable('TT4_5', ( TT4 - TT5 ) / 100,database)


# Utility functions

R1 = - (                                   log( 1 + exp( B_FSG * FSG2_1 ) ) + log( 1 + exp( B_FSG * FSG3_1 ) ) + log( 1 + exp( B_FSG * FSG4_1 ) ) + log( 1 + exp( B_FSG * FSG5_1 ) )                                   + log( 1 + exp( B_FSO * FSO2_1 ) ) + log( 1 + exp( B_FSO * FSO3_1 ) ) + log( 1 + exp( B_FSO * FSO4_1 ) ) + log( 1 + exp( B_FSO * FSO5_1 ) )                                 + log( 1 + exp( B_TT * TT2_1 ) ) + log( 1 + exp( B_TT * TT3_1 ) ) + log( 1 + exp( B_TT * TT4_1 ) ) + log( 1 + exp( B_TT * TT5_1 ) ))
R2 = - ( log( 1 + exp( B_FSG * FSG1_2 ) )                                   + log( 1 + exp( B_FSG * FSG3_2 ) ) + log( 1 + exp( B_FSG * FSG4_2 ) ) + log( 1 + exp( B_FSG * FSG5_2 ) ) + log( 1 + exp( B_FSO * FSO1_2 ) )                                   + log( 1 + exp( B_FSO * FSO3_2 ) ) + log( 1 + exp( B_FSO * FSO4_2 ) ) + log( 1 + exp( B_FSO * FSO5_2 ) ) + log( 1 + exp( B_TT * TT1_2 ) )                                 + log( 1 + exp( B_TT * TT3_2 ) ) + log( 1 + exp( B_TT * TT4_2 ) ) + log( 1 + exp( B_TT * TT5_2 ) ))
R3 = - ( log( 1 + exp( B_FSG * FSG1_3 ) ) + log( 1 + exp( B_FSG * FSG2_3 ) )                                   + log( 1 + exp( B_FSG * FSG4_3 ) ) + log( 1 + exp( B_FSG * FSG5_3 ) ) + log( 1 + exp( B_FSO * FSO1_3 ) ) + log( 1 + exp( B_FSO * FSO2_3 ) )                                   + log( 1 + exp( B_FSO * FSO4_3 ) ) + log( 1 + exp( B_FSO * FSO5_3 ) ) + log( 1 + exp( B_TT * TT1_3 ) ) + log( 1 + exp( B_TT * TT2_3 ) )                                 + log( 1 + exp( B_TT * TT4_3 ) ) + log( 1 + exp( B_TT * TT5_3 ) ))
R4 = - ( log( 1 + exp( B_FSG * FSG1_4 ) ) + log( 1 + exp( B_FSG * FSG2_4 ) ) + log( 1 + exp( B_FSG * FSG3_4 ) )                                   + log( 1 + exp( B_FSG * FSG5_4 ) ) + log( 1 + exp( B_FSO * FSO1_4 ) ) + log( 1 + exp( B_FSO * FSO2_4 ) ) + log( 1 + exp( B_FSO * FSO3_4 ) )                                   + log( 1 + exp( B_FSO * FSO5_4 ) ) + log( 1 + exp( B_TT * TT1_4 ) ) + log( 1 + exp( B_TT * TT2_4 ) ) + log( 1 + exp( B_TT * TT3_4 ) )                                 + log( 1 + exp( B_TT * TT5_4 ) ))
R5 = - ( log( 1 + exp( B_FSG * FSG1_5 ) ) + log( 1 + exp( B_FSG * FSG2_5 ) ) + log( 1 + exp( B_FSG * FSG3_5 ) ) + log( 1 + exp( B_FSG * FSG4_5 ) )                                   + log( 1 + exp( B_FSO * FSO1_5 ) ) + log( 1 + exp( B_FSO * FSO2_5 ) ) + log( 1 + exp( B_FSO * FSO3_5 ) ) + log( 1 + exp( B_FSO * FSO4_5 ) )                                   + log( 1 + exp( B_TT * TT1_5 ) ) + log( 1 + exp( B_TT * TT2_5 ) ) + log( 1 + exp( B_TT * TT3_5 ) ) + log( 1 + exp( B_TT * TT4_5 ) )                                )

# Associate utility functions with the numbering of alternatives
V = {1: R1,
     2: R2,
     3: R3,
     4: R4,
     5: R5}

# Associate the availability conditions with the alternatives
one =  DefineVariable('one',1,database)

av = {1: one,
      2: one,
      3: one,
      4: one,
      5: one}

# The choice model is a logit, with availability conditions
logprob = bioLogLogit(V,av,CHOICE)

# Run Biogeme!
# Run biogeme!
biogeme = bio.BIOGEME(database,logprob)

biogeme.modelName = "RRM2010"

results = biogeme.estimate()

print("Results=",results)
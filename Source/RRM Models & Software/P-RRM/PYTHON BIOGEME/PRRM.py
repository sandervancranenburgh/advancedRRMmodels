########################################
#
# @file PRRM.py
# @author: Sander van Cranenburgh
# @date: 06/11/2015
#
#######################################

from biogeme import *
from headers import *
from loglikelihood import *
from statistics import *

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


# Rescale variables to ease numerical estimation
FSG1_sc = DefineVariable('FSG1_sc', ( 1 / 1000) * FSG1 )
FSG2_sc = DefineVariable('FSG2_sc', ( 1 / 1000) * FSG2 )
FSG3_sc = DefineVariable('FSG3_sc', ( 1 / 1000) * FSG3 )
FSG4_sc = DefineVariable('FSG4_sc', ( 1 / 1000) * FSG4 )
FSG5_sc = DefineVariable('FSG5_sc', ( 1 / 1000) * FSG5 )

FSO1_sc = DefineVariable('FSO1_sc', ( 1 / 1000 ) * FSO1 )
FSO2_sc = DefineVariable('FSO2_sc', ( 1 / 1000 ) * FSO2 )
FSO3_sc = DefineVariable('FSO3_sc', ( 1 / 1000 ) * FSO3 )
FSO4_sc = DefineVariable('FSO4_sc', ( 1 / 1000 ) * FSO4 )
FSO5_sc = DefineVariable('FSO5_sc', ( 1 / 1000 ) * FSO5 )

TT1_sc = DefineVariable('TT1_sc', ( 1 / 100 ) * TT1 )
TT2_sc = DefineVariable('TT2_sc', ( 1 / 100 ) * TT2 )
TT3_sc = DefineVariable('TT3_sc', ( 1 / 100 ) * TT3 )
TT4_sc = DefineVariable('TT4_sc', ( 1 / 100 ) * TT4 )
TT5_sc = DefineVariable('TT5_sc', ( 1 / 100 ) * TT5 )


# Compute P-RRM attribute levels
X_FSG1 = DefineVariable('X_FSG1', ( max( 0 , FSG2_sc - FSG1_sc ) + max( 0 , FSG3_sc - FSG1_sc ) + max( 0 , FSG4_sc - FSG1_sc ) + max( 0 , FSG5_sc - FSG1_sc ) ))
X_FSG2 = DefineVariable('X_FSG2', ( max( 0 , FSG1_sc - FSG2_sc ) + max( 0 , FSG3_sc - FSG2_sc ) + max( 0 , FSG4_sc - FSG2_sc ) + max( 0 , FSG5_sc - FSG2_sc ) ))
X_FSG3 = DefineVariable('X_FSG3', ( max( 0 , FSG1_sc - FSG3_sc ) + max( 0 , FSG2_sc - FSG3_sc ) + max( 0 , FSG4_sc - FSG3_sc ) + max( 0 , FSG5_sc - FSG3_sc ) ))
X_FSG4 = DefineVariable('X_FSG4', ( max( 0 , FSG1_sc - FSG4_sc ) + max( 0 , FSG2_sc - FSG4_sc ) + max( 0 , FSG3_sc - FSG4_sc ) + max( 0 , FSG5_sc - FSG4_sc ) ))
X_FSG5 = DefineVariable('X_FSG5', ( max( 0 , FSG1_sc - FSG5_sc ) + max( 0 , FSG2_sc - FSG5_sc ) + max( 0 , FSG3_sc - FSG5_sc ) + max( 0 , FSG4_sc - FSG5_sc ) ))

X_FSO1 = DefineVariable('X_FSO1', ( max( 0 , FSO2_sc - FSO1_sc ) + max( 0 , FSO3_sc - FSO1_sc ) + max( 0 , FSO4_sc - FSO1_sc ) + max( 0 , FSO5_sc - FSO1_sc ) ))
X_FSO2 = DefineVariable('X_FSO2', ( max( 0 , FSO1_sc - FSO2_sc ) + max( 0 , FSO3_sc - FSO2_sc ) + max( 0 , FSO4_sc - FSO2_sc ) + max( 0 , FSO5_sc - FSO2_sc ) ))
X_FSO3 = DefineVariable('X_FSO3', ( max( 0 , FSO1_sc - FSO3_sc ) + max( 0 , FSO2_sc - FSO3_sc ) + max( 0 , FSO4_sc - FSO3_sc ) + max( 0 , FSO5_sc - FSO3_sc ) ))
X_FSO4 = DefineVariable('X_FSO4', ( max( 0 , FSO1_sc - FSO4_sc ) + max( 0 , FSO2_sc - FSO4_sc ) + max( 0 , FSO3_sc - FSO4_sc ) + max( 0 , FSO5_sc - FSO4_sc ) ))
X_FSO5 = DefineVariable('X_FSO5', ( max( 0 , FSO1_sc - FSO5_sc ) + max( 0 , FSO2_sc - FSO5_sc ) + max( 0 , FSO3_sc - FSO5_sc ) + max( 0 , FSO4_sc - FSO5_sc ) ))

X_TT1 = DefineVariable('X_TT1', ( min( 0 , TT2_sc - TT1_sc ) + min( 0 , TT3_sc - TT1_sc ) + min( 0 , TT4_sc - TT1_sc ) + min( 0 , TT5_sc - TT1_sc ) ))
X_TT2 = DefineVariable('X_TT2', ( min( 0 , TT1_sc - TT2_sc ) + min( 0 , TT3_sc - TT2_sc ) + min( 0 , TT4_sc - TT2_sc ) + min( 0 , TT5_sc - TT2_sc ) ))
X_TT3 = DefineVariable('X_TT3', ( min( 0 , TT1_sc - TT3_sc ) + min( 0 , TT2_sc - TT3_sc ) + min( 0 , TT4_sc - TT3_sc ) + min( 0 , TT5_sc - TT3_sc ) ))
X_TT4 = DefineVariable('X_TT4', ( min( 0 , TT1_sc - TT4_sc ) + min( 0 , TT2_sc - TT4_sc ) + min( 0 , TT3_sc - TT4_sc ) + min( 0 , TT5_sc - TT4_sc ) ))
X_TT5 = DefineVariable('X_TT5', ( min( 0 , TT1_sc - TT5_sc ) + min( 0 , TT2_sc - TT5_sc ) + min( 0 , TT3_sc - TT5_sc ) + min( 0 , TT4_sc - TT5_sc ) ))


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
one =  DefineVariable('one',1)

av = {1: one,
      2: one,
      3: one,
      4: one,
      5: one}

# The choice model is a logit, with availability conditions
prob = bioLogit(V,av,CHOICE)
logP = log(prob)

# Defines an itertor on the data
rowIterator('obsIter') 

# DEfine the likelihood function for the estimation
BIOGEME_OBJECT.ESTIMATE = Sum(logP,'obsIter')


# Statistics

nullLoglikelihood(av,'obsIter')
choiceSet = [1,2,3,4,5]
cteLoglikelihood(choiceSet,CHOICE,'obsIter')
availabilityStatistics(av,'obsIter')

BIOGEME_OBJECT.PARAMETERS['optimizationAlgorithm'] = "CFSQP"
BIOGEME_OBJECT.PARAMETERS['numberOfThreads'] = "2"

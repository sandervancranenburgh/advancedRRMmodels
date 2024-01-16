########################################
#
# @file LC_muRRM_2classes.py
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
#

# Parameters Class 1
B_FSG_1 = Beta('Floor space groceries_1',0,-10,10,0)
B_FSO_1 = Beta('Floor space other_1',0,-10,10,0)
B_TT_1  = Beta('Travel time_1',0,-10,10,0)
mu_1    = Beta('mu_1',1,0,10,0)

# Parameters Class 2
B_FSG_2 = Beta('Floor space groceries_2',0,-10,10,0)
B_FSO_2 = Beta('Floor space other_2',0,-10,10,0)
B_TT_2  = Beta('Travel time_2',0,-10,10,0)
mu_2    = Beta('mu_2',1,0,10,0)

# Class membership parameters
s = Beta('s',0.5,0,1,0)


# Floorspace Groceries
FSG2_1 = DefineVariable('FSG2_1', ( FSG2 - FSG1 ) / 1000)
FSG3_1 = DefineVariable('FSG3_1', ( FSG3 - FSG1 ) / 1000)
FSG4_1 = DefineVariable('FSG4_1', ( FSG4 - FSG1 ) / 1000)
FSG5_1 = DefineVariable('FSG5_1', ( FSG5 - FSG1 ) / 1000)

FSG1_2 = DefineVariable('FSG1_2', ( FSG1 - FSG2 ) / 1000)
FSG3_2 = DefineVariable('FSG3_2', ( FSG3 - FSG2 ) / 1000)
FSG4_2 = DefineVariable('FSG4_2', ( FSG4 - FSG2 ) / 1000)
FSG5_2 = DefineVariable('FSG5_2', ( FSG5 - FSG2 ) / 1000)

FSG1_3 = DefineVariable('FSG1_3', ( FSG1 - FSG3 ) / 1000)
FSG2_3 = DefineVariable('FSG2_3', ( FSG2 - FSG3 ) / 1000)
FSG4_3 = DefineVariable('FSG4_3', ( FSG4 - FSG3 ) / 1000)
FSG5_3 = DefineVariable('FSG5_3', ( FSG5 - FSG3 ) / 1000)

FSG1_4 = DefineVariable('FSG1_4', ( FSG1 - FSG4 ) / 1000)
FSG2_4 = DefineVariable('FSG2_4', ( FSG2 - FSG4 ) / 1000)
FSG3_4 = DefineVariable('FSG3_4', ( FSG3 - FSG4 ) / 1000)
FSG5_4 = DefineVariable('FSG5_4', ( FSG5 - FSG4 ) / 1000)

FSG1_5 = DefineVariable('FSG1_5', ( FSG1 - FSG5 ) / 1000)
FSG2_5 = DefineVariable('FSG2_5', ( FSG2 - FSG5 ) / 1000)
FSG3_5 = DefineVariable('FSG3_5', ( FSG3 - FSG5 ) / 1000)
FSG4_5 = DefineVariable('FSG4_5', ( FSG4 - FSG5 ) / 1000)

# Floorspace Other
FSO2_1 = DefineVariable('FSO2_1', ( FSO2 - FSO1 ) / 1000)
FSO3_1 = DefineVariable('FSO3_1', ( FSO3 - FSO1 ) / 1000)
FSO4_1 = DefineVariable('FSO4_1', ( FSO4 - FSO1 ) / 1000)
FSO5_1 = DefineVariable('FSO5_1', ( FSO5 - FSO1 ) / 1000)

FSO1_2 = DefineVariable('FSO1_2', ( FSO1 - FSO2 ) / 1000)
FSO3_2 = DefineVariable('FSO3_2', ( FSO3 - FSO2 ) / 1000)
FSO4_2 = DefineVariable('FSO4_2', ( FSO4 - FSO2 ) / 1000)
FSO5_2 = DefineVariable('FSO5_2', ( FSO5 - FSO2 ) / 1000)

FSO1_3 = DefineVariable('FSO1_3', ( FSO1 - FSO3 ) / 1000)
FSO2_3 = DefineVariable('FSO2_3', ( FSO2 - FSO3 ) / 1000)
FSO4_3 = DefineVariable('FSO4_3', ( FSO4 - FSO3 ) / 1000)
FSO5_3 = DefineVariable('FSO5_3', ( FSO5 - FSO3 ) / 1000)

FSO1_4 = DefineVariable('FSO1_4', ( FSO1 - FSO4 ) / 1000)
FSO2_4 = DefineVariable('FSO2_4', ( FSO2 - FSO4 ) / 1000)
FSO3_4 = DefineVariable('FSO3_4', ( FSO3 - FSO4 ) / 1000)
FSO5_4 = DefineVariable('FSO5_4', ( FSO5 - FSO4 ) / 1000)

FSO1_5 = DefineVariable('FSO1_5', ( FSO1 - FSO5 ) / 1000)
FSO2_5 = DefineVariable('FSO2_5', ( FSO2 - FSO5 ) / 1000)
FSO3_5 = DefineVariable('FSO3_5', ( FSO3 - FSO5 ) / 1000)
FSO4_5 = DefineVariable('FSO4_5', ( FSO4 - FSO5 ) / 1000)

# Travel time
TT2_1 = DefineVariable('TT2_1', ( TT2 - TT1 ) / 100)
TT3_1 = DefineVariable('TT3_1', ( TT3 - TT1 ) / 100)
TT4_1 = DefineVariable('TT4_1', ( TT4 - TT1 ) / 100)
TT5_1 = DefineVariable('TT5_1', ( TT5 - TT1 ) / 100)

TT1_2 = DefineVariable('TT1_2', ( TT1 - TT2 ) / 100)
TT3_2 = DefineVariable('TT3_2', ( TT3 - TT2 ) / 100)
TT4_2 = DefineVariable('TT4_2', ( TT4 - TT2 ) / 100)
TT5_2 = DefineVariable('TT5_2', ( TT5 - TT2 ) / 100)

TT1_3 = DefineVariable('TT1_3', ( TT1 - TT3 ) / 100)
TT2_3 = DefineVariable('TT2_3', ( TT2 - TT3 ) / 100)
TT4_3 = DefineVariable('TT4_3', ( TT4 - TT3 ) / 100)
TT5_3 = DefineVariable('TT5_3', ( TT5 - TT3 ) / 100)

TT1_4 = DefineVariable('TT1_4', ( TT1 - TT4 ) / 100)
TT2_4 = DefineVariable('TT2_4', ( TT2 - TT4 ) / 100)
TT3_4 = DefineVariable('TT3_4', ( TT3 - TT4 ) / 100)
TT5_4 = DefineVariable('TT5_4', ( TT5 - TT4 ) / 100)

TT1_5 = DefineVariable('TT1_5', ( TT1 - TT5 ) / 100)
TT2_5 = DefineVariable('TT2_5', ( TT2 - TT5 ) / 100)
TT3_5 = DefineVariable('TT3_5', ( TT3 - TT5 ) / 100)
TT4_5 = DefineVariable('TT4_5', ( TT4 - TT5 ) / 100)


# Utility functions
 
R1_1 = - mu_1 * (                                                 log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG2_1 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG3_1 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG4_1 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG5_1 ) )                                                 + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO2_1 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO3_1 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO4_1 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO5_1 ) )                                               + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT2_1 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT3_1 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT4_1 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT5_1 ) ))
R2_1 = - mu_1 * ( log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG1_2 ) )                                                 + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG3_2 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG4_2 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG5_2 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO1_2 ) )                                                 + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO3_2 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO4_2 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO5_2 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT1_2 ) )                                               + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT3_2 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT4_2 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT5_2 ) ))
R3_1 = - mu_1 * ( log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG1_3 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG2_3 ) )                                                 + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG4_3 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG5_3 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO1_3 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO2_3 ) )                                                 + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO4_3 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO5_3 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT1_3 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT2_3 ) )                                               + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT4_3 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT5_3 ) ))
R4_1 = - mu_1 * ( log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG1_4 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG2_4 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG3_4 ) )                                                 + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG5_4 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO1_4 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO2_4 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO3_4 ) )                                                 + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO5_4 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT1_4 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT2_4 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT3_4 ) )                                               + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT5_4 ) ))
R5_1 = - mu_1 * ( log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG1_5 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG2_5 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG3_5 ) ) + log( 1 + exp( ( B_FSG_1 / mu_1 ) * FSG4_5 ) )                                                 + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO1_5 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO2_5 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO3_5 ) ) + log( 1 + exp( ( B_FSO_1 / mu_1 ) * FSO4_5 ) )                                                 + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT1_5 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT2_5 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT3_5 ) ) + log( 1 + exp( ( B_TT_1 / mu_1 ) * TT4_5 ) )                                              )

# Associate utility functions with the numbering of alternatives
V1 = {1: R1_1,
     2: R2_1,
     3: R3_1,
     4: R4_1,
     5: R5_1}

R1_2 = - mu_2 * (                                                 log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG2_1 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG3_1 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG4_1 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG5_1 ) )                                                 + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO2_1 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO3_1 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO4_1 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO5_1 ) )                                               + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT2_1 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT3_1 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT4_1 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT5_1 ) ))
R2_2 = - mu_2 * ( log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG1_2 ) )                                                 + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG3_2 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG4_2 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG5_2 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO1_2 ) )                                                 + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO3_2 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO4_2 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO5_2 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT1_2 ) )                                               + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT3_2 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT4_2 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT5_2 ) ))
R3_2 = - mu_2 * ( log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG1_3 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG2_3 ) )                                                 + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG4_3 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG5_3 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO1_3 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO2_3 ) )                                                 + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO4_3 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO5_3 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT1_3 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT2_3 ) )                                               + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT4_3 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT5_3 ) ))
R4_2 = - mu_2 * ( log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG1_4 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG2_4 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG3_4 ) )                                                 + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG5_4 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO1_4 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO2_4 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO3_4 ) )                                                 + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO5_4 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT1_4 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT2_4 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT3_4 ) )                                               + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT5_4 ) ))
R5_2 = - mu_2 * ( log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG1_5 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG2_5 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG3_5 ) ) + log( 1 + exp( ( B_FSG_2 / mu_2 ) * FSG4_5 ) )                                                 + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO1_5 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO2_5 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO3_5 ) ) + log( 1 + exp( ( B_FSO_2 / mu_2 ) * FSO4_5 ) )                                                 + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT1_5 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT2_5 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT3_5 ) ) + log( 1 + exp( ( B_TT_2 / mu_2 ) * TT4_5 ) )                                              )



# Associate utility functions with the numbering of alternatives
V2 = {1: R1_2,
     2: R2_2,
     3: R3_2,
     4: R4_2,
     5: R5_2}



# Associate the availability conditions with the alternatives
one =  DefineVariable('one',1)

av = {1: one,
      2: one,
      3: one,
      4: one,
      5: one}

# Class membership model
probClass1 = 1 - s
probClass2 = s

# The choice model is a logit, with availability conditions
prob1 = bioLogit(V1,av,CHOICE)
prob2 = bioLogit(V2,av,CHOICE)

# Iterator on individuals, that is on groups of rows.
metaIterator('personIter','__dataFile__','panelObsIter','ID')

# For each item of personIter, iterates on the rows of the group. 
rowIterator('panelObsIter','personIter')

#Conditional probability for the sequence of choices of an individual
ProbIndiv_1 = Prod(prob1,'panelObsIter')
ProbIndiv_2 = Prod(prob2,'panelObsIter')

# Define the likelihood function for the estimation
BIOGEME_OBJECT.ESTIMATE = Sum(log(probClass1 * ProbIndiv_1 + probClass2 * ProbIndiv_2),'personIter')

# Statistics

BIOGEME_OBJECT.PARAMETERS['optimizationAlgorithm'] = "CFSQP"
BIOGEME_OBJECT.PARAMETERS['numberOfThreads'] = "4"
BIOGEME_OBJECT.STATISTICS['Number of individuals'] = Sum(1,'personIter')

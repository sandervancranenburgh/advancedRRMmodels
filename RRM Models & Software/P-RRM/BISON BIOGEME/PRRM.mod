[ModelDescription]

[Choice]
CHOICE

[Beta]
B_FSG		  0         -10000         10000       0
B_FSO	 	  0         -10000         10000       0
B_TT 		  0         -10000         10000       0


[Utilities]
1   Alt1  one  B_FSG * P_FSG1 + B_FSO * P_FSO1 + B_TT * P_TT1
2   Alt2  one  B_FSG * P_FSG2 + B_FSO * P_FSO2 + B_TT * P_TT2
3   Alt3  one  B_FSG * P_FSG3 + B_FSO * P_FSO3 + B_TT * P_TT3
4   Alt4  one  B_FSG * P_FSG4 + B_FSO * P_FSO4 + B_TT * P_TT4
5   Alt5  one  B_FSG * P_FSG5 + B_FSO * P_FSO5 + B_TT * P_TT5



[Expressions]
one = 1

P_FSG1 = ( - 1 / 1000 ) * ( max( 0 , FSG2 - FSG1 ) + max( 0 , FSG3 - FSG1 ) + max( 0 , FSG4 - FSG1 ) + max( 0 , FSG5 - FSG1 ) )
P_FSG2 = ( - 1 / 1000 ) * ( max( 0 , FSG1 - FSG2 ) + max( 0 , FSG3 - FSG2 ) + max( 0 , FSG4 - FSG2 ) + max( 0 , FSG5 - FSG2 ) )
P_FSG3 = ( - 1 / 1000 ) * ( max( 0 , FSG1 - FSG3 ) + max( 0 , FSG2 - FSG3 ) + max( 0 , FSG4 - FSG3 ) + max( 0 , FSG5 - FSG3 ) )
P_FSG4 = ( - 1 / 1000 ) * ( max( 0 , FSG1 - FSG4 ) + max( 0 , FSG2 - FSG4 ) + max( 0 , FSG3 - FSG4 ) + max( 0 , FSG5 - FSG4 ) )
P_FSG5 = ( - 1 / 1000 ) * ( max( 0 , FSG1 - FSG5 ) + max( 0 , FSG2 - FSG5 ) + max( 0 , FSG3 - FSG5 ) + max( 0 , FSG4 - FSG5 ) )

P_FSO1 = ( - 1 / 1000 ) * ( max( 0 , FSO2 - FSO1 ) + max( 0 , FSO3 - FSO1 ) + max( 0 , FSO4 - FSO1 ) + max( 0 , FSO5 - FSO1 ) )
P_FSO2 = ( - 1 / 1000 ) * ( max( 0 , FSO1 - FSO2 ) + max( 0 , FSO3 - FSO2 ) + max( 0 , FSO4 - FSO2 ) + max( 0 , FSO5 - FSO2 ) )
P_FSO3 = ( - 1 / 1000 ) * ( max( 0 , FSO1 - FSO3 ) + max( 0 , FSO2 - FSO3 ) + max( 0 , FSO4 - FSO3 ) + max( 0 , FSO5 - FSO3 ) )
P_FSO4 = ( - 1 / 1000 ) * ( max( 0 , FSO1 - FSO4 ) + max( 0 , FSO2 - FSO4 ) + max( 0 , FSO3 - FSO4 ) + max( 0 , FSO5 - FSO4 ) )
P_FSO5 = ( - 1 / 1000 ) * ( max( 0 , FSO1 - FSO5 ) + max( 0 , FSO2 - FSO5 ) + max( 0 , FSO3 - FSO5 ) + max( 0 , FSO4 - FSO5 ) )

P_TT1 = ( - 1 / 100 ) * ( min( 0 , TT2 - TT1 ) + min( 0 , TT3 - TT1 ) + min( 0 , TT4 - TT1 ) + min( 0 , TT5 - TT1 ) )
P_TT2 = ( - 1 / 100 ) * ( min( 0 , TT1 - TT2 ) + min( 0 , TT3 - TT2 ) + min( 0 , TT4 - TT2 ) + min( 0 , TT5 - TT2 ) )
P_TT3 = ( - 1 / 100 ) * ( min( 0 , TT1 - TT3 ) + min( 0 , TT2 - TT3 ) + min( 0 , TT4 - TT3 ) + min( 0 , TT5 - TT3 ) )
P_TT4 = ( - 1 / 100 ) * ( min( 0 , TT1 - TT4 ) + min( 0 , TT2 - TT4 ) + min( 0 , TT3 - TT4 ) + min( 0 , TT5 - TT4 ) )
P_TT5 = ( - 1 / 100 ) * ( min( 0 , TT1 - TT5 ) + min( 0 , TT2 - TT5 ) + min( 0 , TT3 - TT5 ) + min( 0 , TT4 - TT5 ) )


[Model]
$MNL


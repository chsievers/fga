#############################################################################
##
#W  Autom.gd                FGA package                    Christian Sievers
##
##  Declarations for methods to create and compute with inverse automata
##
#Y  2003 - 2018
##

DeclareCategory( "IsInvAutomatonCategory", IsObject);

DeclareOperation( "TrivialInvAutomaton", [ IsFreeGroup ]);
DeclareOperation( "InvAutomatonInsertGenerator",
    [ IsInvAutomatonCategory and IsMutable, IsElementOfFreeGroup ] );

DeclareGlobalFunction( "FGA_newstate" );
DeclareGlobalFunction( "FGA_connectpos" );
DeclareGlobalFunction( "FGA_connect" );
DeclareGlobalFunction( "FGA_define" );
DeclareGlobalFunction( "FGA_find" );
DeclareGlobalFunction( "FGA_merge" );
DeclareGlobalFunction( "FGA_coincidence" );
DeclareGlobalFunction( "FGA_delta" );
DeclareGlobalFunction( "FGA_deltas" );
DeclareGlobalFunction( "FGA_TmpState" );
DeclareGlobalFunction( "FGA_trace" );
DeclareGlobalFunction( "FGA_backtrace" );
DeclareGlobalFunction( "FGA_InsertGenerator" );
DeclareGlobalFunction( "FGA_AutomInsertGeneratorLetterRep" );
DeclareGlobalFunction( "FGA_InsertGeneratorLetterRep" );
DeclareGlobalFunction( "FGA_FromGroupWithGenerators" );
DeclareGlobalFunction( "FGA_FromGeneratorsLetterRep");
DeclareGlobalFunction( "FGA_Check" );
DeclareGlobalFunction( "FGA_FindGeneratorsAndStates" );
DeclareGlobalFunction( "FGA_repr" );
DeclareGlobalFunction( "FGA_initial" );
DeclareGlobalFunction( "FGA_reducedPos" );
DeclareGlobalFunction( "FGA_Index" );
DeclareGlobalFunction( "FGA_AsWordLetterRepInFreeGenerators" );
DeclareGlobalFunction( "FGA_States" );
DeclareGlobalFunction( "FGA_GeneratorsLetterRep" );


#############################################################################
##
#E

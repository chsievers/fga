#############################################################################
##
#W  FreeGroups.gd            FGA package                    Christian Sievers
##
##  Main declaration file for the FGA package
##
#H  @(#)$Id$
##
#Y  2003
##
Revision.("fga/lib/FreeGroups_gd") :=
    "@(#)$Id$";


#############################################################################
##
#A  FreeGeneratorsOfGroup( <G> )
##
##  returns a list of free generators of the group <G>.
##  This is a minimal generating set, but is also guarantied to
##  be N-reduced.
##
DeclareAttribute( "FreeGeneratorsOfGroup", IsFreeGroup );


#############################################################################
##
#A  RankOfFreeGroup( <G> )
##
##  returns the rank of a free group.
##
DeclareAttribute( "RankOfFreeGroup", IsFreeGroup );


#############################################################################
##
#A  FreeGroupAutomaton( <G> )
##
##  returns the automaton representing <G>.
##
DeclareAttribute( "FreeGroupAutomaton",
                  IsFreeGroup,
                  "mutable" );


#############################################################################
##
#A  FreeGroupExtendedAutomaton( <G> )
##
##  return the extended automaton representing <G>.
##  The extra information is enough for a constructive membership test
##  with respect to the given generators of <G>.
##
DeclareAttribute( "FreeGroupExtendedAutomaton", IsFreeGroup );


#############################################################################
##
#O  AsWordLetterRepInFreeGenerators( <g>, <G> )
##
##  returns the unique list <l> representing a word in letter representation
##  such that
##  <g> = Product( <l>, 
##                 x -> FreeGeneratorsOfGroup(<G>)[AbsInt(x)]^(SignInt(x)),
##                 One(<G>) )
##  or fail, if <g> is not in <G>.
##
DeclareOperation( "AsWordLetterRepInFreeGenerators",
    [ IsElementOfFreeGroup, IsFreeGroup ] );


#############################################################################
##
#O  AsWordLetterRepInGenerators( <g>, <G> )
##
##  returns a list <l> representing a word in letter representation such that
##  <g> = Product( <l>, 
##                 x -> GeneratorsOfGroup(<G>)[AbsInt(x)]^(SignInt(x)),
##                 One(<G>) )
##  or fail, if <g> is not in <G>.
##
DeclareOperation( "AsWordLetterRepInGenerators",
    [ IsElementOfFreeGroup, IsFreeGroup ] );


#############################################################################
##
#F  CanComputeWithInverseAutomaton( <G> )
##
##  indicates whether we can use inverse automata to compute with <G>.
##
DeclareFilter( "CanComputeWithInverseAutomaton" );

InstallTrueMethod( CanComputeWithInverseAutomaton,
    IsFreeGroup and HasGeneratorsOfGroup and IsFinitelyGeneratedGroup );

InstallTrueMethod( CanComputeWithInverseAutomaton, HasFreeGroupAutomaton );

InstallTrueMethod( IsFreeGroup and IsFinitelyGeneratedGroup,
    CanComputeWithInverseAutomaton );

InstallTrueMethod( CanEasilyTestMembership, HasFreeGroupAutomaton );

InstallTrueMethod( CanComputeSizeAnySubgroup, IsFreeGroup );


#############################################################################
##
#E

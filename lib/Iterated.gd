#############################################################################
##
#W  Iterated.gd             FGA package                    Christian Sievers
##
##  Declarations for variants of Iterated
##
##  Maybe this should move to the GAP library
##
#H  @(#)$Id$
##
#Y  2003
##
Revision.("fga/lib/Iterated_gd") :=
    "@(#)$Id$";


#############################################################################
##
#O  IteratedF( <list>, <func> )
##
##  applies <func> to <list> iteratively as Iterated does, but stops
##  and returns fail when <func> returns fail.
##
DeclareOperation( "IteratedF", [ IsList, IsFunction ] );


#############################################################################
##
#E

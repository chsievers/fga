#############################################################################
##
#W  Iterated.gd             FGA package                    Christian Sievers
##
##  Declarations for variants of Iterated
##
##  Maybe this should move to the GAP library
##
#Y  2003 - 2012
##

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

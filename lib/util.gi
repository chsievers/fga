#############################################################################
##
#W  util.gi               FGA package                    Christian Sievers
##
##  Utility functions
##
#Y  2003 - 2012
##

InstallGlobalFunction( BoundPositions,
    l -> Filtered([1..Length(l)], i -> IsBound(l[i])) );

InstallGlobalFunction( ATf,
    function(l, p)
    if IsBound(l[p]) then
        return l[p];
    else
        return fail;
    fi;
    end );


#############################################################################
##
#E

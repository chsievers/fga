#############################################################################
##  
#W Intsect.gi                  FGA package                  Christian Sievers
##
## Installations for the computation of intersections of free groups
##
#H @(#)$Id$
##
#Y 2003
##
Revision.("fga/lib/Intsect_gi") :=
    "@(#)$Id$";


#############################################################################
##
#F  FGA_StateTable( <table>, <i>, <j> )
##
InstallGlobalFunction( FGA_StateTable,
    function( t, i, j )
    local l;
    if not IsBound( t[i] ) then
        t[i] := [];
    fi;
    if not IsBound( t[i][j] ) then
        t[i][j] := FGA_newstate();
    fi;
    return t[i][j];
    end );

#############################################################################
##
#M  Intersection2( <G1>, <G2> )
##
InstallMethod( Intersection2,
    "for subgroups of free groups",
    IsIdenticalObj,
    [ CanComputeWithInverseAutomaton, CanComputeWithInverseAutomaton ],
    function( G1, G2 )
    local A, t, sl1, sl2, i, nr1, nr2, Q, pair, g, q, q1, q2, bpd, bpdi;
    t := [];
    i := FGA_StateTable( t, 1, 1 );
    sl1 := FGA_States( FreeGroupAutomaton( G1 ) );
    sl2 := FGA_States( FreeGroupAutomaton( G2 ) );
    Q := [ [1,1] ];
    for pair in Q do
        q1 := sl1[ pair[1] ];
        q2 := sl2[ pair[2] ];
        q  := FGA_StateTable( t, pair[1], pair[2] );
        for g in Difference(
                   Intersection( BoundPositions( q1.delta ),
                                 BoundPositions( q2.delta ) ),
                   BoundPositions( q.delta ) ) do
            nr1 := q1.delta[g].nr;
            nr2 := q2.delta[g].nr;
            FGA_connectpos( q, FGA_StateTable( t, nr1, nr2 ), g );
            Add( Q, [ nr1, nr2 ] );
        od;

        for g in Difference(
                   Intersection( BoundPositions( q1.deltainv ),
                                 BoundPositions( q2.deltainv ) ),
                   BoundPositions( q.deltainv ) ) do
            nr1 := q1.deltainv[g].nr;
            nr2 := q2.deltainv[g].nr;
            FGA_connectpos( FGA_StateTable( t, nr1, nr2 ), q, g );
            Add( Q, [ nr1, nr2 ] );
        od;

        bpd  := BoundPositions( q.delta );
        bpdi := BoundPositions( q.deltainv );
        while Size( bpd ) + Size( bpdi ) = 1  and
              IsNotIdenticalObj( q, i ) do
            if Size( bpd ) = 1 then
                g := bpd[ 1 ];
                q := q.delta[ g ];
                Unbind( q.deltainv[ g ] );
            else
                g := bpdi[ 1 ];
                q := q.deltainv[ g ];
                Unbind( q.delta[ g ] );
            fi;
            bpd  := BoundPositions( q.delta );
            bpdi := BoundPositions( q.deltainv );
        od;
    od;
    A := Objectify( NewType( FamilyObj( G1 ), IsSimpleInvAutomatonRep ),
                    rec( initial:=i, terminal:=i, 
                         group := TrivialSubgroup( G1 ) ) );
    return AsGroup( A );
    end );


#############################################################################
##
#E

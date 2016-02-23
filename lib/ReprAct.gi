#############################################################################
##
#W  ReprAct.gi               FGA package                    Christian Sievers
##
##  Methods for computing RepresentativeAction
##
#Y  2003 - 2016
##

InstallOtherMethod( RepresentativeActionOp,
    "for conjugation of elements in a free group",
    IsCollsElmsElmsX,
    [ IsFreeGroup, IsElementOfFreeGroup, IsElementOfFreeGroup, IsFunction ],
    function(F, d, e, act)
        local wd, we, le, ld, id, ie, wecr, w, pos, pos2, conj;

        if act <> OnPoints then
            TryNextMethod();
        fi;

        if IsOne(d) and IsOne(e) then
            return One(F);
        fi;

        if IsOne(d) or IsOne(e) then
            return fail;
        fi;

        wd := LetterRepAssocWord(d);
        ld := Length(wd);
        id := 1;
        while wd[id] = -wd[ld-id+1] do
            id := id+1;
        od;

        we := LetterRepAssocWord(e);
        le := Length(we);
        ie := 1;
        while we[ie] = -we[le-ie+1] do
            ie := ie+1;
        od;

        if ld-2*id <> le-2*ie then
            return fail;
        fi;

        w := wd{[id..ld-id+1]};    # wd cyclically reduced
        w := Concatenation(w,w);   # ... and doubled
        wecr := we{[ie..le-ie+1]}; # we cyclically reduced

        pos := PositionSublist(w,wecr);
        if pos=fail then
            return fail;
        fi;

        conj := AssocWordByLetterRep(FamilyObj(d), wd{[1..id+pos-2]}) *
                AssocWordByLetterRep(FamilyObj(d), we{[le-ie+2..le]});
        if conj in F then
            return conj;
        fi;

        pos2 := PositionSublist(w, wecr, pos);
        if pos2=fail then
            pos2 := pos+ld-2*ie+2;
        fi;

        return FindPowLetterRep(F, wd{[1..id+pos-2]},w{[pos..pos2-1]},
                                   we{[le-ie+2..le]});
    end );

InstallMethod( FindPowLetterRep,
    [ CanComputeWithInverseAutomaton, IsList, IsList, IsList ],
    function(f, wi, wp, wt)
    local init, initstate, final, finalstate, state, n, fam;

    state := FGA_initial(FreeGroupAutomaton(f));

    init := FGA_TmpState(state, wi);
    initstate := init.state;
    final := FGA_TmpState(state, -Reversed(wt));
    finalstate := final.state;

    state := initstate;
    n := 0;
    repeat
        state := FGA_deltas(state, wp);
        n := n+1;
    until state=fail or IsIdenticalObj(state, initstate) or
          IsIdenticalObj(state, finalstate);
    
    if state = fail then
        state := initstate;
        n := 0;
        wp := -Reversed(wp);
        repeat
            state := FGA_deltas(state, wp);
            n := n+1;
        until state=fail or IsIdenticalObj(state, finalstate);
    fi;

    final.undo();
    init.undo();

    if IsIdenticalObj(state, finalstate) then
        fam := ElementsFamily(FamilyObj(f));
        return AssocWordByLetterRep(fam, wi)   * 
               AssocWordByLetterRep(fam, wp)^n *
               AssocWordByLetterRep(fam, wt);
    else
        return fail;
    fi;
    end );

InstallOtherMethod( RepresentativeActionOp,
    "for subgroups of a free group",
    IsFamFamFamX,
    [ CanComputeWithInverseAutomaton,
      CanComputeWithInverseAutomaton,
      CanComputeWithInverseAutomaton,
      IsFunction ],1,
    function(F, G, H, act)
        local AG, AH, AF, rdG, rdH, statesH, redgens, i, AN, tmp, conj;

        if act <> OnPoints then
            TryNextMethod();
        fi;

        if RankOfFreeGroup(G) <> RankOfFreeGroup(H) then
            return fail;
        fi;

        AG := FreeGroupAutomaton(G);
        rdG := FGA_reducedPos(AG);
        AH := FreeGroupAutomaton(H);
        rdH := FGA_reducedPos( AH );

        statesH := FGA_States(AH);

        if Size(statesH)-rdH <> Size(FGA_States(AG))-rdG then
            return fail;
        fi;

        redgens := List( List(FreeGeneratorsOfGroup(G), LetterRepAssocWord),
                         w -> w{[rdG .. Length(w)-rdG+1]} );

        for i in [rdH .. Size(statesH)] do
            if ForAll(redgens, w -> FGA_Check(statesH[i], w)) then

                # We now know that G is a subgroup of a conjugate of H.
                # More ugly low level computation could check for equality.
                # Instead we postpone the check to a time where we can work
                # at a higher level.
                # So if the result is fail, we get it a little slower.

                AN := FreeGroupAutomaton( NormalizerInWholeGroup( G ) );
                tmp := FGA_TmpState( 
                          AN!.initial, 
                          Concatenation(
                              FGA_States( AG )[ rdG ].repr,
                              -Reversed(FGA_repr(statesH[i])) ));
                AF := FreeGroupAutomaton( F );
                conj := FGA_FindRepInIntersection(
                            AF, AF!.terminal,
                            AN, tmp.state );
                tmp.undo();
                if conj = fail then
                    return fail;
                fi;

                conj := AssocWordByLetterRep(
                           ElementsFamily(FamilyObj(F)), conj );

                # Now check if we really have a conjugating element:

                if IsSubset( G, List( FreeGeneratorsOfGroup(H),
                                      h -> h^(conj^-1) )) then
                    return conj;
                else
                    return fail;
                fi;

            fi;
        od;
        return fail;
        end );


#############################################################################
##
#E

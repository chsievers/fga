#############################################################################
##  
#W Normal.gi                   FGA package                  Christian Sievers
##
## Method installations for normalizers in free groups
##
#H @(#)$Id$
##
#Y 2003
##
Revision.("fga/lib/Normal_gi") :=
    "@(#)$Id$";


#############################################################################
##
#M  NormalizerInWholeGroup( <group> )
##
##  returns the normalizer of <group> in the group of the whole family
##  (assuming <group> is nontrivial - otherwise the normalizer is the
##   whole group, but how can it be obtained?)
##
InstallMethod( NormalizerInWholeGroup,
    [ CanComputeWithInverseAutomaton and IsNonTrivial ],
    function(G)
    local found, A, reducedPos, states, s, u, ur, i, gens, redgenwords, fam,
          interesting, conjinvLetterRep, N;
    found := false;
    A := FreeGroupAutomaton(G);
    fam := ElementsFamily(FamilyObj(G));

    gens := ShallowCopy(FreeGeneratorsOfGroup(G));
    redgenwords := List(gens, LetterRepAssocWord);
    reducedPos := FGA_reducedPos(A);    

    conjinvLetterRep := redgenwords[1]{[1..reducedPos-1]};
    redgenwords := List(redgenwords,
                        w -> w{[reducedPos .. Length(w)-reducedPos+1]});

    states := FGA_States(FreeGroupAutomaton(G));
    interesting := ReturnTrue;

    for i in [reducedPos+1 .. Length(states)] do
        s := states[i];
        u := FGA_repr(s);
        ur := u{[reducedPos..Length(u)]};

        if interesting(ur) and
           ForAll(redgenwords,w->FGA_Check(s,w)) then
            # generator found
            if found then # this was not the first extra generator
            #    Print("inserting\n");
            else
            #    Print("inserting first\n");
                A := FGA_FromGeneratorsLetterRep(redgenwords, G);
                interesting := w -> not FGA_Check(A!.initial,w);
                found := true;
            fi;
            FGA_AutomInsertGeneratorLetterRep(A, ur);
            # Add(gens, AssocWordByLetterRep(fam, u));
        fi;
    od;
    if found then
        s := FGA_newstate();
        FGA_coincidence(Iterated(conjinvLetterRep,
                                 FGA_define,
                                 s ),
                        A!.initial  );
        A!.initial := FGA_find(s);
        A!.terminal := A!.initial;
        MakeImmutable(A);

        N := AsGroup(A);
    else
        N := G;
    fi;
    return N;
    end );


#############################################################################
##
#M  NormalizerOp( <group>, <subgroup> )
##
InstallMethod( NormalizerOp,
    "for a subgroup of a free group in the whole group",
    IsIdenticalObj,
    [ IsFreeGroup and IsWholeFamily, CanComputeWithInverseAutomaton ],
    function(F,G)
    if IsTrivial( G ) then
        return F;
    else
        return NormalizerInWholeGroup(G);
    fi;
    end );


#############################################################################
##
#M  NormalizerOp( <group>, <elm> )
##
InstallMethod( NormalizerOp,
    "for an element in a free group",
    IsCollsElms,
    [ IsFreeGroup, IsElementOfFreeGroup ],
    CentralizerOp );


#############################################################################
##
#E

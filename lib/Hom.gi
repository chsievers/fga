#############################################################################
##
#W  Hom.gi                   FGA package                    Christian Sievers
##
##  Methods for homomorphisms of free groups
##
#H  @(#)$Id$
##
#Y  2003 - 2005
##
Revision.("fga/lib/Hom_gi") :=
    "@(#)$Id$";


InstallMethod( PreImagesRepresentative,
    "for homomorphisms of free groups",
    FamRangeEqFamElm,
    [ IsGroupGeneralMappingByImages, IsElementOfFreeGroup ],
    function( hom, x )
    local w, mgi;
    mgi := MappingGeneratorsImages( hom );
    w := AsWordLetterRepInGenerators( x, ImagesSource(hom) );
    if w = fail then
        return fail;
    fi;
    return Product( w, i -> mgi[1][AbsInt(i)]^SignInt(i),
                    One(Source(hom)));
    end );

InstallMethod( ImageElm,
    "for homomorphisms of free groups",
    FamRangeEqFamElm,
    [ IsGroupGeneralMappingByImages and IsMapping, IsElementOfFreeGroup ],
    function( hom, x )
    local w, mgi;
    mgi := MappingGeneratorsImages( hom );
    w := AsWordLetterRepInGenerators( x, Group( mgi[1] ));
    if w = fail then
        return fail;
    fi;
    return Product( w, i -> mgi[2][AbsInt(i)]^SignInt(i),
                    One(Source(hom)));
    end );

InstallMethod( IsSingleValued,
   "for group general mappings of free groups",
   [ IsGroupGeneralMapping and HasMappingGeneratorsImages ],
   function( hom )
   local g;
   g := Group( MappingGeneratorsImages( hom )[ 1 ] );
   if CanComputeWithInverseAutomaton( g )
      and Size( GeneratorsOfGroup( g ) ) = RankOfFreeGroup( g ) then
          return true;
   fi;
   TryNextMethod();
   end );


#############################################################################
##
#E

#############################################################################
##
#W  Hom.gi                   FGA package                    Christian Sievers
##
##  Methods for homomorphisms of free groups
##
#Y  2003 - 2016
##


InstallMethod( PreImagesRepresentative,
    "for homomorphisms of free groups",
    FamRangeEqFamElm,
    [ IsToFpGroupGeneralMappingByImages, IsElementOfFreeGroup ],
    function( hom, x )
    local w, mgi;
    mgi := MappingGeneratorsImages( hom );
    w := AsWordLetterRepInGenerators( x, FGA_Image( hom ));
    if w = fail then
        return fail;
    fi;
    return Product( w, i -> mgi[1][AbsInt(i)]^SignInt(i),
                    One(Source(hom)));
    end );

InstallMethod( ImagesRepresentative,
    "for homomorphisms of free groups",
    FamSourceEqFamElm,
    [ IsFromFpGroupGeneralMappingByImages, IsElementOfFreeGroup ],
    23,
    function( hom, x )
    local w, mgi;
    mgi := MappingGeneratorsImages( hom );
    if mgi[1]=[] then return One(Range(hom)); fi;
    
    w := AsWordLetterRepInGenerators( x, FGA_Source( hom ));
    if w = fail then
        return fail;
    fi;
    return Product( w, i -> mgi[2][AbsInt(i)]^SignInt(i),
                    One(Range(hom)));
    end );

InstallMethod( FGA_Source,
   [ IsFromFpGroupGeneralMappingByImages and HasMappingGeneratorsImages ],
   hom -> SubgroupNC( Source(hom), MappingGeneratorsImages(hom)[1] )
);

InstallMethod( FGA_Image,
   [ IsToFpGroupGeneralMappingByImages and HasMappingGeneratorsImages ],
   hom -> SubgroupNC( Range(hom), MappingGeneratorsImages(hom)[2] )
);

InstallMethod( IsSingleValued,
   "for group general mappings of free groups",
   [ IsFromFpGroupGeneralMappingByImages and HasMappingGeneratorsImages ],
   function( hom )
   local mgi, g, imgs;
   mgi := MappingGeneratorsImages( hom );

   if mgi[1]=[] then return true; fi; # map on trivial group

   g := SubgroupNC( Source(hom), mgi[1] );
   if not IsFreeGroup( g ) then
      TryNextMethod();
   fi;
   if Size( mgi[1] ) = RankOfFreeGroup( g ) then
      return true;
   fi;

   # write free generators in given generators and
   # compute corresponding images:
   imgs := List( FreeGeneratorsOfGroup( g ), fgen -> 
                   Product( AsWordLetterRepInGenerators( fgen, g ),
	                    i -> mgi[2][AbsInt(i)]^SignInt(i),
		            One(Range(hom)) ));

   # check if all given generator/image pairs agree with the
   # map given by free generators and computed images:
   return ForAll( [ 1 .. Size( mgi[1] ) ], n -> 
                    mgi[2][n] =
                    Product( 
		      AsWordLetterRepInFreeGenerators( mgi[1][n], g ),
		      i -> imgs[AbsInt(i)]^SignInt(i),
		      One(Range(hom)) ));
   end );


#############################################################################
##
#E

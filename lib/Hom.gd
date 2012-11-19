#############################################################################
##  
#W  Hom.gd                     FGA package                  Christian Sievers
##
## Declaration file for the computation with homomorphisms of free groups
##
#Y 2012
##

#############################################################################
##
#A  FGA_Source( <hom> )
##
##  returns the source of <hom> as group with special generators
##
DeclareAttribute( "FGA_Source", IsFromFpGroupGeneralMappingByImages );

#############################################################################
##
#A  FGA_Image( <hom> )
##
##  returns the image of <hom> as group with special generators
##
DeclareAttribute( "FGA_Image", IsToFpGroupGeneralMappingByImages );

#############################################################################
##
#E


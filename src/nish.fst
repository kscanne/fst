read lexc nish.txt
define Lexicon;
define DisallowIntermediateTags ~[$[ "+NAPl" | "+NIPl" ]];
define AnimatePlural [ "+Pl" -> "+NAPl" || "+NA" ?* _ .#. ];
define InanimatePlural [ "+Pl" -> "+NIPl" || "+NI" ?* _ .#. ];
define ObviativeAnimateOnly ~[$[ "+NI" ?* "+Obv" ]];
define LongDistanceDependencies [ ObviativeAnimateOnly .o. AnimatePlural .o. InanimatePlural ];
define PluralRules [ n h "^" a -> n y a , a "^" a -> a , i i "^" a -> i i , e "^" a -> e , o o "^" a -> o o , W "^" a -> o o ];
! for -gan dim. = gaans, see V p.188
define ConOrDimRules [ g a n "^" e -> g a a , a a "^" e -> a a , i i "^" e -> i i , e "^" e -> e , o o "^" e -> o o , W "^" e -> o o ];
define ShortAConOrDim [ a "^" e -> e || \a _ ];  ! miikna -> miiknens e.g.
! the \a condition here avoids application of this to class I nouns like gaaway
define ClassVPlural [ y "^" a -> i i || \a _ ]; 
define ClassVConOrDim [ y "^" e -> i i || \a _ ]; 
define Cleanup "^" -> 0;
define Morph [ DisallowIntermediateTags .o. LongDistanceDependencies .o. Lexicon .o. PluralRules .o. ClassVPlural .o. ConOrDimRules .o. ClassVConOrDim .o. ShortAConOrDim .o. Cleanup .o. @"syncopate.bin" ];
push Morph
save stack nish.bin

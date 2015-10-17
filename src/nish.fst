read lexc nish.txt
define Lexicon;
define AnimatePlural [ "+Pl" -> "+NAPl" || "+NA" ?* _ .#. ];
define InanimatePlural [ "+Pl" -> "+NIPl" || "+NI" ?* _ .#. ];
define ObviativeAnimateOnly ~[$[ "+NI" ?* "+Obv" ]];
define LongDistanceDependencies [ ObviativeAnimateOnly .o. AnimatePlural .o. InanimatePlural ];
define PluralRules [ n h "^" a -> n y a , a a "^" a -> a a , i i "^" a -> i i , e "^" a -> e , o o "^" a -> o o , W "^" a -> o o ];
define ClassVPlural [ y "^" a -> i i || \a _ ]; 
define Cleanup "^" -> 0;
define Morph [ LongDistanceDependencies .o. Lexicon .o. PluralRules .o. ClassVPlural .o. Cleanup .o. @"syncopate.bin" ];
push Morph

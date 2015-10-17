read lexc nish.txt
define Lexicon;
define PluralRules [ n h "^" a -> n y a , a a "^" a -> a a , i i "^" a -> i i , e "^" a -> e , o o "^" a -> o o , W "^" a -> o o ];
define ClassVPlural [ y "^" a -> i i || \a _ ]; 
define Cleanup "^" -> 0;
define Morph [ Lexicon .o. PluralRules .o. ClassVPlural .o. Cleanup .o. @"syncopate.bin" ];
push Morph

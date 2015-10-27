read lexc nish.txt
define Lexicon;
define DisallowIntermediateTags ~[$[ "+NAPl" | "+NIPl" | "+NASg" | "+NISg" ]];
define AnimatePlural [ "+Pl" -> "+NAPl" || "+NA" ?* _ .#. ];
define InanimatePlural [ "+Pl" -> "+NIPl" || "+NI" ?* _ .#. ];
define AnimateSingular [ "+Sg" -> "+NASg" || "+NA" ?* _ .#. ];
define InanimateSingular [ "+Sg" -> "+NISg" || "+NI" ?* _ .#. ];
define InsertPossSg [  "+Sg" -> "+Poss" "+Sg" || "Poss+" ?+ _ .#. ];
define InsertPossPl [  "+Pl" -> "+Poss" "+Pl" || "Poss+" ?+ _ .#. ];
define InsertPossObv [  "+Obv" -> "+Poss" "+Obv" || "Poss+" ?+ _ .#. ];
define 1sPossessum [ "+Poss" -> "+1P" "+Sg" "+Poss" || .#. "1P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 2sPossessum [ "+Poss" -> "+2P" "+Sg" "+Poss" || .#. "2P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 3sPossessum [ "+Poss" -> "+3P" "+Sg" "+Poss" || .#. "3P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 1pPossessum [ "+Poss" -> "+1P" "+Pl" "+Poss" || .#. "1P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define 21Possessum [ "+Poss" -> "+1P" "+Ex" "+Poss" || .#. "1P+" "Ex+" "Poss+" ?+ _ ? .#. ]; 
define 2pPossessum [ "+Poss" -> "+2P" "+Pl" "+Poss" || .#. "2P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define 3pPossessum [ "+Poss" -> "+3P" "+Pl" "+Poss" || .#. "3P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define ObviativeAnimateOnly ~[$[ "+NI" ?* "+Obv" ]];
define LongDistanceDependencies [ ObviativeAnimateOnly .o. InsertPossSg .o. InsertPossPl .o. InsertPossObv .o. 1sPossessum .o. 2sPossessum .o. 3sPossessum .o. 1pPossessum .o. 21Possessum .o. 2pPossessum .o. 3pPossessum .o. AnimatePlural .o. InanimatePlural .o. AnimateSingular .o. InanimateSingular ];
define PluralRules [ n h "^" a -> n y a , a "^" a -> a , i i "^" a -> i i , e "^" a -> e , o o "^" a -> o o , W "^" a -> o o ];
! for -gan dim. = gaans, see V p.188
define ConOrDimRules [ g a n "^" e -> g a a , a a "^" e -> a a , i i "^" e -> i i , e "^" e -> e , o o "^" e -> o o , W "^" e -> o o , k w "^" e -> k o o , g w "^" e -> g o o , i w "^" e -> i i ];
define ShortAConOrDim [ a "^" e -> e || \a _ ];  ! miikna -> miiknens e.g.
! the \a condition here avoids application of this to class I nouns like gaaway
define ClassVPlural [ y "^" a -> i i || \a _ ]; 
define ClassVConOrDim [ y "^" e -> i i || \a _ ]; 
define ClassVPejOrLoc [ y "^" i -> i i || \a _ ]; 
define PejOrLocRules [ n s "^" i s -> n z h i s , n h "^" i -> n y i , a "^" i -> a , i i "^" i -> i i , i w "^" i n g -> i i n g , e "^" i -> e , o o "^" i -> o o , W "^" i -> o , k w "^" i -> k o , g w "^" g o ];
define Cleanup "^" -> 0;
define Morph [ DisallowIntermediateTags .o. LongDistanceDependencies .o. Lexicon .o. PluralRules .o. ClassVPlural .o. ConOrDimRules .o. ClassVConOrDim .o. ShortAConOrDim .o. PejOrLocRules .o. ClassVPejOrLoc .o. Cleanup .o. @"syncopate.bin" ];
push Morph
save stack nish.bin

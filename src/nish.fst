read lexc nish.txt
define Lexicon;
define DisallowIntermediateTags ~[$[ "+NAPl" | "+NIPl" | "+NASg" | "+NISg" | "+Poss" ]];
define AnimatePlural [ "+Pl" -> "+NAPl" || "+NA" ?* _ .#. ];
define InanimatePlural [ "+Pl" -> "+NIPl" || "+NI" ?* _ .#. ];
define AnimateSingular [ "+Sg" -> "+NASg" || "+NA" ?* _ .#. ];
define InanimateSingular [ "+Sg" -> "+NISg" || "+NI" ?* _ .#. ];
define InsertPossSg [  "+Sg" -> "+Poss" "+Sg" || "Poss+" ?+ _ .#. ];
define InsertPossPl [  "+Pl" -> "+Poss" "+Pl" || "Poss+" ?+ _ .#. ];
define InsertPossObv [  "+Obv" -> "+Poss" "+Obv" || "Poss+" ?+ _ .#. ];
define InsertPossLoc [  "+Loc" -> "+Poss" "+Loc" || "Poss+" ?+ _ .#. ]; ! locatives can be possessed too; see V p.205
define 1sPossessum [ "+Poss" -> "+1P" "+Sg" "+Poss" || .#. "1P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 2sPossessum [ "+Poss" -> "+2P" "+Sg" "+Poss" || .#. "2P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 3sPossessum [ "+Poss" -> "+3P" "+Sg" "+Poss" || .#. "3P+" "Sg+" "Poss+" ?+ _ ? .#. ]; 
define 1pPossessum [ "+Poss" -> "+1P" "+Pl" "+Poss" || .#. "1P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define 21Possessum [ "+Poss" -> "+1P" "+Ex" "+Poss" || .#. "1P+" "Ex+" "Poss+" ?+ _ ? .#. ]; 
define 2pPossessum [ "+Poss" -> "+2P" "+Pl" "+Poss" || .#. "2P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define 3pPossessum [ "+Poss" -> "+3P" "+Pl" "+Poss" || .#. "3P+" "Pl+" "Poss+" ?+ _ ? .#. ]; 
define ObviativeAnimateOnly ~[$[ "+NI" ?* "+Obv" ]];
define LongDistanceDependencies [ ObviativeAnimateOnly .o. InsertPossSg .o. InsertPossPl .o. InsertPossObv .o. InsertPossLoc .o. 1sPossessum .o. 2sPossessum .o. 3sPossessum .o. 1pPossessum .o. 21Possessum .o. 2pPossessum .o. 3pPossessum .o. AnimatePlural .o. InanimatePlural .o. AnimateSingular .o. InanimateSingular ];
define PossLinkingD [ "@" -> d || _ [ a | e | i \i ] ];  ! V 4.9.2, but not ii or oo as in 4.9.2.1
define PossLinkingDO [ "@" -> d o || _ o \o ]; ! lengthen initial o (Biigtigong TSV)
define PossLinkingDW [ "@" w a -> d o o || _ \a ]; ! Biigtigong TSV, w + short a only
define PossLinkingDY [ "@" y -> d a y ];
define PossCoalesce [ i "@" -> 0 || _ [ i i | o o ] ];
define PossPrefixRules [ PossLinkingD .o. PossLinkingDO .o. PossLinkingDW .o. PossLinkingDY .o. PossCoalesce ];
define PluralRules [ n h "^" a -> n y a , a "^" a -> a , i i "^" a -> i i , e "^" a -> e , o o "^" a -> o o , W "^" a -> o o ];  ! same rules for Obviative
! V. p. 188 has -gan+dim. = gaans ( g a n "^" e -> g a a ),
! but Biigtigong prefers more regular g(a)nens
define ConOrDimRules [ w a "^" e -> o o , a a "^" e -> a a , i i "^" e -> i i , e "^" e -> e , o o "^" e -> o o , W "^" e -> o o , k "^" w "^" e -> k o o , g "^" w "^" e -> g o o , i w "^" e -> i i , i "^" w "^" e -> i i ];
define ShortAConOrDim [ a "^" e -> e || \a _ ];  ! miikna -> miiknens e.g.
define ClassVFinalI [ i "^" y "^" [ a | e | i ] -> i i ]; 
define ClassVOther [ "^" y "^" [ a | e | i ] -> i i || \i _ ]; 
define ClassVIDropY [ a y -> 0 || _ "^" A "^" i ];
define PejRules [ n s "^" i s -> n z h i s , n h "^" i s -> n y i s , a "^" i s -> a w i s , i i "^" i s -> i i w i s , e "^" i s -> e w i s , o o "^" i s -> o o w i s , W "^" i s -> o s , k "^" w "^" i s -> k o s , g "^" w "^" i s -> g o s , "^" A "^" i s -> a a s ];
define LocRules [ n h "^" i n -> n y i n , w a "^" i n -> o n , a a "^" i n -> a a n , i i "^" i n -> i i n , i w "^" i n g -> i i n g , i "^" w "^" i n g -> i i n g , e "^" i n -> e n , o o "^" i n -> o o n , W "^" i n -> o n , e "^" w "^" i n -> e n , k "^" w "^" i n -> k o n , g "^" w "^" i n -> g o n , "^" A "^" i n -> a a n ];
define ShortALocOrPoss [ a "^" i -> a a || \a _ ];  ! miikna -> miiknaang, miiknaam
define PossThmRules [ n h "^" i m -> n y i m , w a "^" i m -> o m , a a "^" i m -> a a m , i i "^" i m -> i i m , i w "^" i m -> i i m , i "^" w "^" i m -> i i m , e "^" i m -> e m , o o "^" i m -> o o m , W "^" i m -> o m , e "^" w "^" i m -> e m , k "^" w "^" i m -> k o m , g "^" w "^" i m -> g o m , "^" A "^" i m -> a a m ]; ! cf. V. p. 201
define LeniteQuasiDim [ z e n s "^" i s -> z h e n z h i s ];  ! as in kwezens -> kwezhenzhish, gwiiwzens -> gwiiwzhenzhish, V p.193; do this before PejRules
define SingularCleanup [ "^" [ w | W | y ] -> 0 || _ .#. ];
define classVICleanup [ "^" A -> 0 ];
define Cleanup [ "^" -> 0, "@" -> 0 ];
define Morph [ DisallowIntermediateTags .o. LongDistanceDependencies .o. Lexicon .o. PossPrefixRules .o. PluralRules .o. ClassVFinalI .o. ClassVOther .o. ConOrDimRules .o. ShortAConOrDim .o. LeniteQuasiDim .o. ClassVIDropY .o. PejRules .o. LocRules .o. PossThmRules .o. ShortALocOrPoss .o. classVICleanup .o. SingularCleanup .o. Cleanup .o. @"syncopate.bin" ];
push Morph
save stack nish.bin

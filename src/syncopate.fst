define ShortV [ a | i | o ];
define LongV [ e | a a | i i | o o ];
define Vowel [ ShortV | LongV ];
! no diacritics since upper language is full-vowel
define wAbleCons [ ' | b | c h | d | g | h | j | k | m | m b | n | n d | n g | n h | n j | n z | p | s | s h | s h k | s k | t | z | z h ];
define otherCons [ n s | n y | n z h | s h p | s h t | s p | w | y ];
! unused characters in Nishnaabemwin; dropped a,i,o map to these respectively
define dropMarker [ F | L | X ];
define Cons [ wAbleCons | otherCons ];
define Cluster [ Cons | wAbleCons w ];
define Hyphen [ "-" ];
define markWeak [ a -> F, i -> L, o -> X // .#. _ Cluster Vowel , .#. Cluster _ Cluster Vowel , Hyphen _ Cluster Vowel , Hyphen Cluster _ Cluster Vowel , LongV Cluster _ Cluster Vowel , dropMarker Cluster ShortV Cluster _ Cluster Vowel , dropMarker Cluster ShortV Cluster _ Hyphen , ? LongV Cluster _ Hyphen ];
define insertApost [ c dropMarker h -> c ' h, m dropMarker b -> m ' b, n dropMarker d -> n ' d, n dropMarker g -> n ' g, n dropMarker h -> n ' h, n dropMarker j -> n ' j, n dropMarker s -> n ' s, n dropMarker y -> n ' y, n dropMarker z -> n ' z, s dropMarker h -> s ' h, s dropMarker k -> s ' k ];
define insertDiacriticsGK [ g X -> ǧ, k X -> ǩ, g w F -> ǧ, k w F -> ǩ || _ \w];
define insertDiacriticsH [ h X -> ȟ, h w F -> ȟ || Vowel _ \w ];
define initialO [ X -> w || .#. _, Hyphen _ ];
define initialGW [ F g w a -> F g o || .#. _ \a ];
define dropAllMarkers [ F -> 0, L -> 0, X -> 0 ];
define convertGlottal [ ' -> h ];
define syncopate [ markWeak .o. convertGlottal .o. insertApost .o. insertDiacriticsGK .o. insertDiacriticsH .o. initialO .o. initialGW .o. dropAllMarkers ];
push defined syncopate
save stack syncopate.bin

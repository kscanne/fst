TSV=${HOME}/seal/biigtigong-private-lex-dat/biigtigong-private-lex-dat.tsv

all: badapost.txt badchar.txt badvowel.txt badcluster.txt
	@echo "bad apostrophes..."
	@cat badapost.txt
	@echo "bad characters..."
	@cat badchar.txt
	@echo "bad vowels..."
	@cat badvowel.txt
	@echo "bad full-vowel clusters..."
	@cat badcluster.txt

syncopate.bin: syncopate.fst
	foma -f syncopate.fst

# all theoretically possible apostrophes in Biigtigong orthography
allaposts.txt: consonants.txt
	(egrep '^..' consonants.txt | sed "s/^./&'/"; egrep '^...$$' consonants.txt | sed "s/.$$/'&/") | sort -u > $@

ascii-headwords.txt: headwords.txt
	cat headwords.txt | sed 's/ǧ/g/g; s/ȟ/h/g; s/ǩ/k/g' > $@

headwords.txt: $(TSV)
	cat $(TSV) | cut -f 2 > $@

fullvowel.txt: $(TSV)
	cat $(TSV) | cut -f 6 > $@

naI.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tna\t/p' | cut -f 2,3,6,7 | egrep "^[A-Za-z'-]*[aeio]([bcdfghjkmnprstwyz]+)[^A-Za-z'-].+\1ag$$" | cut -f 1 > $@

niI.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tni\t/p' | cut -f 2,3,6,7 | egrep "^[A-Za-z'-]*[aeio]([bcdfghjkmnprstwyz]+)[^A-Za-z'-].+\1an$$" | cut -f 1 > $@

naCon.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*nh\tna\t/p' | cut -f 2,3,6,7 | egrep "nyag$$" | cut -f 1 > $@

niCon.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*nh\tni\t/p' | cut -f 2,3,6,7 | egrep "nyan$$" | cut -f 1 > $@

# intentionally allowing even short vowels as final vowel (mkwa, miikna, etc.)
naII.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*[aeio]\tna\t/p' | cut -f 2,3,6,7 | egrep '^(.+)[^a-z].+\1g$$' | cut -f 1 > $@

niII.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*[aeio]\tni\t/p' | cut -f 2,3,6,7 | egrep '^(.+)[^a-z].+\1n$$' | cut -f 1 > $@

naIII.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([aeio]\)\tna\t/p' | cut -f 2,3,6,7 | egrep '^(.+)i?[^a-z].+\1wag$$' | cut -f 1 > $@

niIII.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([aeio]\)\tni\t/p' | cut -f 2,3,6,7 | egrep '^(.+)i?[^a-z].+\1wan$$' | cut -f 1 > $@

# IVa/IVb labels in Valentine esp. p. 176 are flipped...
# Trusting that tables on p. 178 and p.181 are correct; oo[gn] => IVa
naIVa.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tna\t/p' | cut -f 2,3,6,7 | egrep 'oog$$' | cut -f 1 > $@

niIVa.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tni\t/p' | cut -f 2,3,6,7 | egrep 'oon$$' | cut -f 1 > $@

naIVb.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tna\t/p' | cut -f 2,3,6,7 | egrep '^(.+)[^a-z].+[^a-z]\1(o|wa)g$$' | cut -f 1 > $@

naV.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\tna\t/p' | cut -f 2,3,6,7 | egrep 'iig$$' | cut -f 1 | egrep -v 'ii$$' > $@

niV.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\tni\t/p' | cut -f 2,3,6,7 | egrep 'iin$$' | cut -f 1 | egrep -v 'ii$$' > $@

naVI.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tna\t/p' | cut -f 2,3,6,7,8 | egrep 'aang$$' | cut -f 1 > $@

niVI.txt: $(TSV)
	cat $(TSV) | sed -n '/^\t[^\t]*\([^aeio]\)\tni\t/p' | cut -f 2,3,6,7,8 | egrep 'aang$$' | cut -f 1 > $@

classified-nouns.txt: naI.txt niI.txt naII.txt niII.txt naIII.txt niIII.txt naIVa.txt niIVa.txt naIVb.txt naV.txt niV.txt naVI.txt niVI.txt naCon.txt niCon.txt
	cat naI.txt niI.txt naII.txt niII.txt naIII.txt niIII.txt naIVa.txt niIVa.txt naIVb.txt naV.txt niV.txt naVI.txt niVI.txt naCon.txt niCon.txt > $@

othernouns.txt: classified-nouns.txt
	cat $(TSV) | sed -n '/^\t[^\t]*\tn[ai]\t\(n[ai]\)\?\t/p' | cut -f 2,7 | egrep '[a-z]$$' | cut -f 1 | keepif -n classified-nouns.txt > $@
	#cat $(TSV) | sed -n '/^\t[^\t]*\tn[ai]\t\(n[ai]\)\?\t/p' | cut -f 2 | keepif -n classified-nouns.txt > $@

syncopated-test.txt: fullvowel.txt syncopate.bin
	cat fullvowel.txt | flookup -i syncopate.bin | egrep '.' | sed 's/^.*\t//' > $@

# filters out (1) anything correct (2) entries with spaces 
# (3) entries missing full-vowel form (so 1st column in resulting paste empty)
comparison.txt: syncopated-test.txt headwords.txt
	touch $@
	mv -f $@ comparison-prev.txt
	paste syncopated-test.txt headwords.txt | tolow | egrep -v '^(.+).\1$$' | egrep -v ' ' | egrep -v '^[^A-Za-z]' > $@
	-diff -u comparison-prev.txt $@
	wc -l comparison-prev.txt $@

diacriticbug.txt: comparison.txt
	cat comparison.txt | sed 's/ǧ/g/g; s/ȟ/h/g; s/ǩ/k/g' | egrep '^(.+)[^a-z]\1$$' | sed 's/\t.*//' > $@
	wc -l $@

consonanttypos.txt: comparison.txt
	cat comparison.txt | while read x; do if ! echo "$$x" | tr -d "aeiouw'" | egrep '^(.+).\1$$' > /dev/null; then echo $$x; fi; done > $@

# analyze usage of apostrophe in Biigtigong forms 
badapost.txt: allaposts.txt headwords.txt
	cat headwords.txt | egrep -o "[^aeiou-]+'[^aeiou-]+"  | egrep -v ' ' | egrep -v -f allaposts.txt | sort | uniq -c | sort -r -n > $@

badchar.txt: headwords.txt
	-cat headwords.txt | egrep -v '(weǧnesh| OR )' | egrep "[^A-EG-KM-PSTWYZa-eg-km-pstwyzǧǩȟ ?'-]" > $@

badvowel.txt: headwords.txt
	-cat headwords.txt | egrep '(a[eio]|e[aio]|i[aeo]|o[aei])' > $@

clusters.txt: consonants.txt
	(cat consonants.txt; cat consonants.txt | egrep -v '^n([sy]|zh)' | egrep -v '^sht' | egrep -v '^[wy]' | sed 's/$$/w/') | sort -u > clusters.txt

badcluster.txt: fullvowel.txt clusters.txt
	-cat fullvowel.txt | egrep -v ' ' | egrep -o '[^aeiou-]+' | keepif -n clusters.txt | sort | uniq -c | sort -r -n > $@

clean:
	rm -f badapost.txt allaposts.txt badchar.txt badcluster.txt badvowel.txt syncopate.bin headwords.txt fullvowel.txt syncopated-test.txt comparison.txt clusters.txt ascii-headwords.txt classified-nouns.txt othernouns.txt naI.txt niI.txt naII.txt niII.txt naIII.txt niIII.txt naIVa.txt niIVa.txt naIVb.txt naV.txt niV.txt naVI.txt niVI.txt naCon.txt niCon.txt comparison-prev.txt consonanttypos.txt diacriticbug.txt multichar.txt

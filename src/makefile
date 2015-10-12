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

syncopated-test.txt: fullvowel.txt syncopate.bin
	cat fullvowel.txt | flookup -i syncopate.bin | egrep '.' | sed 's/^.*\t//' > $@

# filters out (1) anything correct (2) entries with spaces 
# (3) entries missing full-vowel form (so 1st column in resulting paste empty)
comparison.txt: syncopated-test.txt headwords.txt
	touch $@
	mv -f $@ comparison-prev.txt
	paste syncopated-test.txt headwords.txt | egrep -v '^(.+).\1$$' | egrep -v ' ' | egrep -v '^[^A-Za-z]' > $@
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
	rm -f badapost.txt allaposts.txt badchar.txt badcluster.txt badvowel.txt syncopate.bin headwords.txt fullvowel.txt syncopated-test.txt comparison.txt clusters.txt ascii-headwords.txt

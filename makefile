all: master.apl master.en.html master.fr.html

master.apl: master.hpweb
	./genere-hpweb master

master.fr.html: master.hpweb
	./genere-hpweb master

master.en.html: master.hpweb
	./genere-hpweb master

master.fr.md: master.hpweb
	./genere-hpweb master

master.en.md: master.hpweb
	./genere-hpweb master


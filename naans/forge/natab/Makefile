default:
	@echo "Type 'make natab.roff' to create roffable NAAN table."
	@echo "Type 'make natab.dist' to update natab at CDL and NLM."

natab.roff: natab
	expand natab | sed 's/\\/\\\e/g' > natab.roff

natab.dist:
	# Use ssh instead of scp to bypass the -p-like mode setting that
	# generates an error message (since 'cdldir' owns remote file)
	#@echo XXX 'ssh cdlib-update.cdlib.org "cat > /cdldir/stage/htdocs/inside/diglib/ark/natab" < natab'
	#@echo Use http://cdlib-update.cdlib.org:8081/cgi-bin/docmove/docmove to move to production.
	@echo Use http://cdlib-stage.cdlib.org/cgi-bin/docmove/docmove to move to production.
	@echo Make sure you put full email into naans/ directory.
	ssh cdlib-stage.cdlib.org "cat > /cdlib/apache/htdocs/services/uc3/natab" < natab
	scp -p natab grandfathered Makefile naan_gen naan_rec jak@jak-desktop.ad.ucop.edu:wr/ark/natab/
	# scp -p natab www.cdlib.org:/cdldir/stage/htdocs/inside/diglib/ark/
	#scp -p natab noble.nlm.nih.gov:/depot/package/apache_2.0.46/vendor/htdocs/project/ark/etc/natab
	#echo "Rick, please save attached file in 'project/ark/etc/natab'." \
		| pine -attach natab rodgers@nlm.nih.gov

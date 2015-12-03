# NB: Relies currently on GRANVL (Greppable ANVL), so each ANVL element
# must be expressed on one long line (ie, no continuation lines).
#
# GNU 'make' cheat sheet: variable $@ is the target and $^ is a list of
# all rule prerequisites; use $$ to quote $; command prefixes: '@' to
# suppress echo of a command, '-' to ignore errors.

FILES = private public
#FILES = private public shoulders
ALL = $(FILES) commit replicate
TODAY = `date "+%Y.%m.%d"`
#ALL = $(FILES) replicate
.PHONY: print_usage $(ALL) vmsg umsg mod_date

print_usage:
	@echo 'Usage:'
	@echo ''
	@echo "today is $(TODAY)"
	@echo '   $ make diffs.txt   # BEFORE "all", if you plan to "announce"'
	@echo '   $ make all         # to create derivative files and replicate'
	@echo '   $ make announce    # email diffs to folks at replica sites'
	@echo ''
	@echo 'Some other useful targets; invoke with "make <target>":'
	@echo ''
	@echo '  ' $(ALL)
	@echo ''

all: $(ALL)
files: $(FILES)

private: vmsg mod_date naan_contacts.txt naan_emails.txt mn.asc

vmsg:
	@echo Making private files.

# We now update the date (TEMPER) inside the master file, guaranteeing
# that master_naans will be freshly modified.  Perform two sanity checks
# to see that the date was set and we didn't wipe out the master file.
# yyy replace `date` call below with a ref to $TODAY
#
mnaans = master_naans
mod_date:
	@perl -p000 -i'.bak' -e 'BEGIN { $$today = `date "+%Y.%m.%d"`; }' \
		-e 's/^(erc:.*when:\s*)([^\n]*\n)/$$1$$today/s and $$ok++;' \
		-e 'END { $$ok or print "ERROR -- mod_date failure\n"; }' \
			$(mnaans)
	@if [ `diff $(mnaans).bak $(mnaans) | wc -l` -gt '4' ] ; then \
		echo PANIC -- mod_date target changed more than expected: ; \
		diff $(mnaans).bak $(mnaans) ; \
		exit 1; \
	fi

public: umsg naan_registry.txt naan_table.html naan_redirects.txt

umsg:
	@echo Making public files.

# private? public?
#shoulders: shldr_registry.txt shldr_table.html
#	@echo Making shoulder files.
# Simple replication of shoulder file for now.
#shoulders: master_shoulders
#	@echo 'Copying shoulders to stage.'
#	@scp $^ $(stage):/cdlib/apache/htdocs/services/uc3/ 

commit:
	hg commit -m 'probably just new NAAN entries'

# Private stuff
#
naan_contacts.txt: master_naans
	@sed -n 's/^!contact/contact/p' $^ > $@

# The next target implements light, portable (Solaris, Linux, BSD)
# security to protect contact info when we replicate full master
# registry.  It does simple rot13 obfuscation, pretending via "mn.asc"
# to be stronger.
##Formerly:
##@gpg -c -a --quiet --yes --no-use-agent --passphrase W0O1dr8-._p \
##	--output $@ $^
### Decrypt with "gpg -d --passphrase yyyyyy mn.asc > restored_master"
#
mn.asc: master_naans
	@tr '[A-Za-z]' '[N-ZA-Mn-za-m]' < $^ > $@

naan_emails.txt: naan_contacts.txt
	@perl -lne '/([^@ ]+@[^ ]+)/ and print $$1;' $^ > $@

# Public stuff
#
# Create naan_registry.txt, public base used for most other derivatives.
naan_registry.txt: master_naans
	@sed '/^#!/d;/^!/d' $^ > $@

naan_table.txt: naan_registry.txt
	@perl -000 -n -e '/^naa:\s*who:\s*(.*)\s*what:\s*(\d+)/ and ' \
		-e 'print "$$2\t$$1\n";' $^ > $@

# For HTML table, further refine the name of the institution by dropping
# the acronym and putting any alternate name in parentheses.  Need lots
# of preamble to copy look and feel of CDL website.
# 
preamble = '\
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n\
<html xmlns=\"http://www.w3.org/1999/xhtml\">\n\
<head>\n\
<title>Identity Service: Name Assigning Authority Numbers (NAANs)</title>\n\
<script type=\"text/javascript\" \
    src=\"/services/uc3/javascript/content_rotate.js\"></script>\n\
<!-- BEGIN HEAD CONTENT-->\n\
<!--\#include virtual=\"/includes/head.html\" -->\n\
<!-- END HEAD CONTENT -->\n\
<!-- BEGIN XTF METADATA -->\n\
<meta id=\"author\" name=\"author\" content=\"John Kunze\" />\n\
<meta id=\"title\" name=\"title\" content=\"UC3: Name Assigning Authority Numbers (NAANs)\" />\n\
<!-- END XTF METADATA-->\n\
<link href=\"/services/uc3/stylesheets/styles.css\" rel=\"stylesheet\" type=\"text/css\" />\n\
</head>\n\
<body>\n\
<!-- BEGIN PAGE ID -->\n\
<div id=\"uc3\">\n\
<!-- BEGIN LAYOUT 1 -->\n\
<!--\#include virtual=\"/includes/layout1-2col.html\" -->\n\
<!-- END LAYOUT 1 -->\n\
<!-- BEGIN SECONDARY NAVIGATION -->\n\
<!--\#include virtual=\"/cgi-bin/side_nav.cgi?uc3-curation-identity\" -->\n\
<!-- END SECONDARY NAVIGATION -->\n\
<!-- BEGIN LAYOUT 2 -->\n\
<!--\#include virtual=\"/includes/layout2-2col.html\" -->\n\
<!-- END LAYOUT 2 -->\n\
<!-- BEGIN CONTENT -->\n\
<div id=\"content\">\n\
<h1 class=\"title\">Registered Name Assigning Authority Numbers</h1>\n\
<p>Below is a list of $$o registered Name Assigning Authority Numbers\n\
(NAANs).  Each organization is identified by a unique NAAN, which can be\n\
used as a prefix for the object identifiers that it assigns.  For example,\n\
CDL assigns ARK identifiers that begin with its NAAN, 13030, as a prefix.\n\
See the <a href=\"/services/uc3/naan_registry.txt\">\n\
NAAN Registry</a> for more information.\n\
<br/><br/><table cellpadding=\"5\">\n'

postamble='\
</table>\n\
</div>\n\
<!-- BEGIN DOCUMENT INFO --><div id=\"document-info\">\n\
<div id=\"last-updated\">Last updated: <!--\#config timefmt=\"%B %d, %Y\" -->\n\
<!--\#echo var=\"LAST_MODIFIED\" -->\n\
</div>\n\
<div id=\"document-owner\">Document owner: <a href=\"http://www.universityofcalifornia.edu/directories/ucopsearch.php?first_name=john&amp;last_name=kunze&amp;submit=1\">John Kunze</a>\n\
</div>\n\
</div>\n\
<!-- BEGIN DOCUMENT INFO -->\n\
<!-- BEGIN LAYOUT 3 -->\n\
<!--\#include virtual=\"/includes/layout3-2col.html\" -->\n\
<!-- END LAYOUT 3 -->\n\
<!-- BEGIN FOOTER -->\n\
<!--\#include virtual=\"/includes/footer.html\" -->\n\
<!-- END FOOTER -->\n\
</div>\n\
<!-- END PAGE ID -->\n\
<!-- BEGIN SCRIPTS -->\n\
<!--\#include virtual=\"/includes/scripts.html\" -->\n\
<!-- END SCRIPTS -->\n\
</body>\n\
</html>\n\
'

#echo "$o = $(shell wc -l < naan_table.txt)" = number of registrations
naan_table.html: naan_table.txt
	@sort --ignore-case --key=2 $^ | perl -n \
		-e 'BEGIN {$$o='$(shell wc -l < $^)';print "'$(preamble)'"}' \
		-e 'if (/([^\t]*)\t(.*?)(\(=\)\s*(.*?)\s*)?\(=\).*/) {' \
			-e '$$t=$$2; $$4 and $$t.="($$4)";' \
			-e 'print("<tr><td>$$1</td><td>$$t</td></tr>\n");' \
		-e '}' \
		-e 'END {print "'$(postamble)'"}' \
			> $@

#		-e 'END {print "</table>\n", ' \
#		-e   '"<!--#include virtual=\"/includes/footer.html\" -->"', \
#		-e   '"</div></div></body>\n</html>\n"}' \

# Now we want to create lines of this form:
#    RedirectMatch ^/((ark:/12148)|12148/?)(.*)$ http://ark.bnf.fr/$2$3
#
naan_redirects.txt: naan_registry.txt
	@perl -000 -n \
		-e 'BEGIN {print "# ARK and URL resolution for N2T\n"}' \
		-e '/^naa:.*\nwhat:\s*(\d+).*\nwhere:\s*(\S+)/s and print ' \
		-e '"RedirectMatch ^/((ark:/$$1)|$$1/?)(.*)\$$ $$2/\$$2\$$3\n";' \
			$^ > $@

# xxx some dumb bug keeps wiping out the diffs.txt, so we save a dated version
# xxx previous.announce is, for now, an aid for creating diffs manually
diffs.txt: master_naans
	hg diff -U 1 $^ > $@
	@echo "See 'previous.announce' for changeset id from last announced diffs."
	#@cp $@ $@.$(TODAY)

# change 'jak' to your login if you're not 'jak'
stage = jak@cdlib-stage.cdlib.org
prod = jak@www.cdlib.org

# xxx this is actually a kind of "publish" as much as "replicate"
# The hg push below "replicates" any files that aren't on the dependency
# list below, eg, forge/grandfathered .
#
replicate: naan_registry.txt naan_table.html naan_table.txt mn.asc
	@echo "Publishing to $(stage) "
	@scp $^ diffs.txt $(stage):/cdlib/apache/htdocs/services/uc3/ 
	@echo "Publishing to $(prod) "
	@scp $^ diffs.txt $(prod):/cdlib/apache/htdocs/services/uc3/ 
	hg push

#remote = jak@ucop.edu
#ccremote = jakkbl@gmail.com
remote = sebastien.peyrard@bnf.fr MarillJ@mail.nlm.nih.gov
ccremote = shalvid@mail.nlm.nih.gov \
           thomas.ledoux@bnf.fr \
	   jak@ucop.edu joan.starr@ucop.edu

#remote = jak@ucop.edu jkunze@ucop.edu
#ccremote = jakkbl@gmail.com

#XXXXXXX this announcement is still broken

#Greetings, this message is the first of its kind since last June, so some\n\
#explanation of the silence is in order.  Between then and now, CDL migrated\n\
#its technical infrastructure to Amazon Web Services.  We also did general\n\
#cleanup of the NAAN registry, which included fixing typos and character\n\
#encodings, as well as changing some mistaken NAAN assignments (very\n\
#fortunately the NAANs in question had not been used).  While this particular\n\
#message contains a large number of changes, going forward you may expect the\n\
#automated messages to resume with their usual small number of changes and\n\
#usual frequency.\n\
#\n\

# This string is printed with perl to get the \n's to be recognized.
announcement="\n\
This is an automated message informing you that the file,\n\
http://cdlib.org/uc3/naan_registry.txt, has been updated.\n\
Please find \"diffs\" (generated by \"hg\") below.\n\
\n\
Questions to jak@ucop.edu\n\
\n\
==========\n\
"

# hg tip > prev_announce
#		echo $(announcement) | cat - diffs.txt.$(TODAY)

announce:
	@hg id > previous.announce
	@(NAME="N2T Role Account"; export NAME; \
		perl -e 'print $(announcement)' | cat - diffs.txt \
		| mailx -s 'NAAN registry updated' -c "$(ccremote)" $(remote))

# end of makefile

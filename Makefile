.PHONY: all

HOSTS=*heroeswm.ru *heroeswm.com *lordswm.com

SCRIPT=hwm_pl_info_enchancer.user.js
define CONVERT
	sub conv {\
		$$r = unpack "H*", $$conv->convert(shift);\
		$$r =~ s/([0-9a-f]{4})/\\u$$1/g;$$r;\
	}\
	$$conv = new Text::Iconv("utf-8", "utf-16be");\
	while (<>) {\
		s/([\x80-\xFF]+)/conv("$$1");/ge;\
		print;\
	};
endef

define SETHOST
	while (<>) {\
		if ($$_ =~ /###HOST###/) {\
			for $$host (qw{${HOSTS}}) {\
				$$new = $$_;\
				$$new =~ s/###HOST###/$$host/g;\
				print $$new;\
			}\
		} else {\
			print; \
		}\
	};
endef

all: ${SCRIPT}

min: ${SCRIPT}
	${SCRIPT}.min

#jquery.min.js:
#	wget http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js -O jquery.min.js

${SCRIPT}: header.js userscript.coffee Makefile
	coffee -b -c tables.coffee
	coffee -b -c userscript.coffee
	perl -e '${SETHOST}' ./header.js > ${SCRIPT}
	echo >> ${SCRIPT}
	echo '(function(){' >> ${SCRIPT}
	perl -MText::Iconv -e '${CONVERT}' ./tables.js | \
		replace '###BUILD_DATE###' "`date`" >> ${SCRIPT}
	echo >> ${SCRIPT}
	cat jquery.min.js >> ${SCRIPT}
	echo >> ${SCRIPT}
	perl -MText::Iconv -e '${CONVERT}' ./userscript.js | \
		replace '###BUILD_DATE###' "`date`" >> ${SCRIPT}
	echo '})()' >> ${SCRIPT}
	rm userscript.js
	rm tables.js

#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 VERSION INFO"
	echo ""
fi

VERSION=$1
INFO=$2
COMMIT=`git log --format="%H" -n 1`
DATE=`date -u +%Y-%m-%dT%H:%M:%SZ`
NEWVERSIONPLACEHOLDER="<!--BopPadMapper_NEWVERSION-->"

# printf ain't an option, as sed gets confused with line endings
NEWVERSION=`echo "<version name=\"${VERSION}\" author=\"Martin Bloedorn\" time=\"${DATE}\">\n"`
NEWVERSION+=`echo "<changelog><![CDATA[${INFO}]]></changelog>\n"`
NEWVERSION+=`echo "<source>https://github.com/MartinBloedorn/ReaThings/raw/${COMMIT}/JSFX/BopPadMapper/BopPadMapper.jsfx</source>\n"`
NEWVERSION+=`echo "<source file=\"BopPadMapper_Dependencies/boppad.jsfx-inc\">https://github.com/MartinBloedorn/ReaThings/raw/${COMMIT}/JSFX/BopPadMapper/BopPadMapper_Dependencies/boppad.jsfx-inc</source>\n"`
NEWVERSION+=`echo "<source file=\"BopPadMapper_Dependencies/memory.jsfx-inc\">https://github.com/MartinBloedorn/ReaThings/raw/${COMMIT}/JSFX/BopPadMapper/BopPadMapper_Dependencies/memory.jsfx-inc</source>\n"`
NEWVERSION+=`echo "</version>\n"`
NEWVERSION+=`echo "${NEWVERSIONPLACEHOLDER}"`

printf "Appending new version:\n\n"
printf "${NEWVERSION}\n"

sed -i 's|'"${NEWVERSIONPLACEHOLDER}"'|'"${NEWVERSION}"'|g' index.xml
xmllint --format index.xml > index.xml.tmp
mv index.xml.tmp index.xml




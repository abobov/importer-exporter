#!/bin/sh

set -e

TEMPLATE_POM=template.pom
OUT_POM=3dcitydb-impexp.pom

ant -f ../build.xml dist
version=$(awk -F = '/^impexp\.version=/ { print $2 }' ../default.properties | tr -d '\r\n')
sed "s/@@VERSION@@/$version/" "$TEMPLATE_POM" > "$OUT_POM"

mvn install:install-file -DpomFile="$OUT_POM" \
    -Dfile="../3dcitydb-impexp-$version/lib/3dcitydb-impexp.jar"

#! /bin/sh

wget -O commons-lang3-sources.jar https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0/commons-lang3-3.14.0-sources.jar
wget -O commons-lang3.jar https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0/commons-lang3-3.14.0.jar

mvn install:install-file \
    -Dfile=commons-lang3.jar \
    -Dsources=commons-lang3-sources.jar \
    -DgroupId=org.apache.commons \
    -DartifactId=commons-lang3 \
    -Dversion=3.14.0 \
    -Dpackaging=jar \
    -DlocalRepositoryPath=repository \
    -DcreateChecksum=true
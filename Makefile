.ONESHELL: # Applies to every targets in the file!

# Maven lifecycle https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html

JAR = $(HOME)/project/target/project-jar-with-dependencies.jar
SOURCES = $(HOME)/project/target/project-sources.jar

GROUP_ID = groupId
ARTIFACT_ID = artifactID
VERSION = 0.0.1

# $HOME/.m2/repository/
mvn_install_home:
	mvn install:install-file \
		-Dfile=$(JAR) \
		-DgroupId=$(GROUP_ID) \
		-DartifactId=$(ARTIFACT_ID) \
		-Dsources=$(SOURCES) \
		-Dversion=$(VERSION) \
		-Dpackaging=jar

mvn_install_local_repo:
	mvn install:install-file \
		-Dfile=$(JAR) \
		-DgroupId=$(GROUP_ID) \
		-DartifactId=$(ARTIFACT_ID) \
		-Dsources=$(SOURCES) \
		-Dversion=$(VERSION) \
		-Dpackaging=jar \
		-DlocalRepositoryPath=lib \
		-DcreateChecksum=true

package:
	mvn package

test:
	mvn test

format:
	mvn formatter:format

.PHONY: dependency

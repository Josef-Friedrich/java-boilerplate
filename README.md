[![Maven Central](https://img.shields.io/maven-central/v/de.pirckheimer-gymnasium/engine-pi.svg?style=flat)](https://central.sonatype.com/artifact/de.pirckheimer-gymnasium/engine-pi)
[![javadoc](https://javadoc.io/badge2/de.pirckheimer-gymnasium/engine-pi/javadoc.svg)](https://javadoc.io/doc/de.pirckheimer-gymnasium/engine-pi)

# java-project-boilerplate

Boilerplate code snippets for my java projects

## Maven Standard Directory Layout

`src/main/java` Application/Library sources<br>
`src/main/resources` Application/Library resources<br>
`src/test/java` Test sources<br>
`src/test/resources` Test resources

<small>
[Source](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html)</small>

## pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>rocks.friedrich</groupId>
  <artifactId>boilerplate</artifactId>
  <version>0.1.0</version>

  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
</project>
```

<small>
[Source](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html)</small>

## naming conventions on groupId, artifactId, and version

### groupId

uniquely identifies your project across all projects. A group ID should follow
Java's package name rules. This means it starts with a reversed domain name you
control. For example

    org.apache.maven, org.apache.commons, de.pirckheimer-gymnasium

## artifactId

is the **name of the jar** without version. If you created it, then you can
choose whatever name you want with **lowercase letters** and no strange symbols.

    eg. maven, commons-math

## version

if you distribute it, then you can choose any typical version with numbers and dots (1.0, 1.1, 1.0.1, ...). For example,

    2.0, 2.0.1, 1.3.1

<small>[Source](https://maven.apache.org/guides/mini/guide-naming-conventions.html)</small>

## format

`make format` or `mvn formatter:format`

https://github.com/revelc/formatter-maven-plugin

[DefaultCodeFormatterConstants](https://git.eclipse.org/c/jdt/eclipse.jdt.core.git/tree/org.eclipse.jdt.core/formatter/org/eclipse/jdt/core/formatter/DefaultCodeFormatterConstants.java)

https://code.revelc.net/formatter-maven-plugin/examples.html#custom-configuration-file

It is best to make or edit the XML formatter files in Eclipse: Window > Preferences > Java > Code Style > Formatter

```xml

<build>
  <plugins>
    <!-- https://code.revelc.net/formatter-maven-plugin/ -->
    <plugin>
      <groupId>net.revelc.code.formatter</groupId>
      <artifactId>formatter-maven-plugin</artifactId>
      <version>2.23.0</version>
      <configuration>
        <configFile>${project.basedir}/.eclipse-formatter/school.xml</configFile>
      </configuration>
    </plugin>
  </plugins>
</build>
```

```xml
<build>
  <plugins>
    <!--
    https://code.revelc.net/formatter-maven-plugin/
    https://code.revelc.net/formatter-maven-plugin/examples.html#basic-configuration-using-external-resource -->
    <plugin>
        <groupId>net.revelc.code.formatter</groupId>
        <artifactId>formatter-maven-plugin</artifactId>
        <version>2.24.1</version>
        <executions>
            <execution>
                <goals>
                    <goal>format</goal>
                </goals>
                <configuration>
                    <configFile>eclipse-formatter.xml</configFile>
                </configuration>
            </execution>
        </executions>
        <dependencies>
            <dependency>
                <groupId>de.pirckheimer-gymnasium</groupId>
                <artifactId>engine-pi</artifactId>
                <version>0.28.0</version>
            </dependency>
        </dependencies>
    </plugin>
  </plugins>
</build>
```

`.vscode/settings.json`

```json
{
  "java.format.settings.url": ".eclipse-formatter/school.xml",
  "editor.tabSize": 4,
  "editor.insertSpaces": true
}
```

## Maven (JAR files) repository inside a project

```xml
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
```

`pom.xml`

```xml
<repositories>
    <repository>
        <id>project-repository</id>
        <url>file://${project.basedir}/repository</url>
    </repository>
</repositories>
```

```xml
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-lang3</artifactId>
  <version>3.14.0</version>
</dependency>
```

## Remove unused imports

Not working?

mvn site

```xml
<reporting>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-pmd-plugin</artifactId>
            <version>3.21.0</version>
        </plugin>
    </plugins>
</reporting>
```

mvn com.xenoamess:remove-unused-imports-maven-plugin:0.0.6:process

```xml
<build>
  <pluginManagement>
    <plugin>
        <groupId>com.xenoamess</groupId>
        <artifactId>remove-unused-imports-maven-plugin</artifactId>
        <version>0.0.6</version>
        <executions>
            <execution>
                <goals>
                    <goal>process</goal>
                </goals>
                <configuration>
                    <ruleNames>
                        <ruleName>UnusedImports</ruleName>
                        <ruleName>DuplicateImports</ruleName>
                        <ruleName>UnnecessaryReturn</ruleName>
                        <ruleName>ImportFromSamePackage</ruleName>
                        <ruleName>DontImportJavaLang</ruleName>
                    </ruleNames>
                    <pmdXmlPath>${basedir}/target/pmd.xml</pmdXmlPath>
                    <breakBuildIfHaveViolationRemains>false</breakBuildIfHaveViolationRemains>
                </configuration>
            </execution>
        </executions>
    </plugin>
  </pluginManagement>
</build>
```

## Reference JAR lib in VScode

```json
{
  "java.project.referencedLibraries": ["+libs/**/*.jar"]
}
```

## Publish to Maven Central

https://central.sonatype.org/publish-ea/publish-ea-guide/#introduction

https://github.com/simpligility/ossrh-demo

`~/.m2/settings.xml`

```xml
<settings>
  <servers>
    <server>
      <!-- https://central.sonatype.com/account -->
      <id>ossrh</id>
      <username>xxx</username>
      <password>xxx</password>
    </server>
  </servers>
  <profiles>
    <profile>
      <id>ossrh</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <gpg.executable>gpg2</gpg.executable>
        <!-- <gpg.passphrase>xxx</gpg.passphrase> -->
      </properties>
    </profile>
  </profiles>
</settings>
```

`pom.xml`

```xml
<project>
    <build>
        <plugins>
            <!-- https://maven.apache.org/plugins/maven-gpg-plugin/usage.html -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-gpg-plugin</artifactId>
                <version>3.2.4</version>
                <executions>
                <execution>
                    <id>sign-artifacts</id>
                    <phase>verify</phase>
                    <goals>
                    <goal>sign</goal>
                    </goals>
                    <configuration>
                    <!-- This is necessary for gpg to not try to use the pinentry programs -->
                    <gpgArguments>
                        <arg>--pinentry-mode</arg>
                        <arg>loopback</arg>
                    </gpgArguments>
                    </configuration>
                </execution>
                </executions>
            </plugin>
            <!-- https://central.sonatype.org/publish/publish-portal-maven/ -->
            <plugin>
                <groupId>org.sonatype.central</groupId>
                <artifactId>central-publishing-maven-plugin</artifactId>
                <version>0.5.0</version>
                <extensions>true</extensions>
                <configuration>
                    <!-- see ~/.m2/settings.xml -->
                    <publishingServerId>central</publishingServerId>
                    <tokenAuth>true</tokenAuth>
                    <autoPublish>true</autoPublish>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

`mvn deploy`

## javadoc

Multiline code snippets

https://reflectoring.io/howto-format-code-snippets-in-javadoc/

## versioning

```xml
<project>
    <build>
        <plugins>
            <!-- https://www.mojohaus.org/versions/versions-maven-plugin/-->
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>versions-maven-plugin</artifactId>
                <version>2.17.1</version>
            </plugin>
        </plugins>
    </build>
</project>
```

`mvn versions:set`

`mvn versions:set -DnewVersion=1.0.1-SNAPSHOT`

`mvn versions:commit`

## junit

from the [junit5-jupiter-starter-maven project](https://github.com/junit-team/junit5-samples/blob/main/junit5-jupiter-starter-maven/pom.xml):

`pom.xml`

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
        <groupId>org.junit</groupId>
        <artifactId>junit-bom</artifactId>
        <version>5.11.1</version>
        <type>pom</type>
        <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.5.0</version>
        </plugin>
    </plugins>
</build>
```

## Copyright

```
/*
 * Copyright (c) 2024 Josef Friedrich.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
```

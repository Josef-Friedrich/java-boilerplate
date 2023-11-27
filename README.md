# java-project-boilerplate

Boilerplate code snippets for my java projects

## format

`make format` or `mvn formatter:format`

https://github.com/revelc/formatter-maven-plugin

[DefaultCodeFormatterConstants](https://git.eclipse.org/c/jdt/eclipse.jdt.core.git/tree/org.eclipse.jdt.core/formatter/org/eclipse/jdt/core/formatter/DefaultCodeFormatterConstants.java)

https://code.revelc.net/formatter-maven-plugin/examples.html#custom-configuration-file

It is best to make or edit the XML formatter files in Eclipse: Window > Preferences > Java > Code Style > Formatter

```xml
<build>
  <plugins>
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
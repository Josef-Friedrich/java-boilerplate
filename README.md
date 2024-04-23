# java-project-boilerplate

Boilerplate code snippets for my java projects

## Maven Standard Directory Layout

`src/main/java` Application/Library sources<br>
`src/main/resources` Application/Library resources<br>
`src/test/java` Test sources<br>
`src/test/resources` Test resources<br>

<small>
[Source](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html)</small>

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
    "java.project.referencedLibraries": [
        "+libs/**/*.jar"
    ]
}
``````

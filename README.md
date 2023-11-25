# java-project-boilerplate

Boilerplate code snippets for my java projects

## format

make format

or

mvn formatter:format

https://github.com/revelc/formatter-maven-plugin

[DefaultCodeFormatterConstants](https://git.eclipse.org/c/jdt/eclipse.jdt.core.git/tree/org.eclipse.jdt.core/formatter/org/eclipse/jdt/core/formatter/DefaultCodeFormatterConstants.java)



https://code.revelc.net/formatter-maven-plugin/examples.html#custom-configuration-file

```xml
<build>
  <plugins>
    <plugin>
      <groupId>net.revelc.code.formatter</groupId>
      <artifactId>formatter-maven-plugin</artifactId>
      <version>2.23.0</version>
      <configuration>
        <configFile>${project.basedir}/eclipse-formatter.xml</configFile>
      </configuration>
    </plugin>
  </plugins>
</build>
```

`.vscode/settings.json`


```json
{
  "java.format.settings.url": "eclipse-formatter.xml",
    // number of spaces for a tab
  "editor.tabSize": 4,
  // insert spaces when pressing tab
  "editor.insertSpaces": true
}
```

package rocks.friedrich.boilerplate;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class BoilerplateTest {

  @Test
  void addition() {
    assertEquals(Boilerplate.getHelloWorld(), "Hello, World!");
  }

}

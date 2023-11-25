package rocks.friedrich.boilerplate;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class BoilerplateTest
{
    @Test
    void helloWorld()
    {
        assertEquals(Boilerplate.getHelloWorld(), "Hello, World!");
    }
}

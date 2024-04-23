package rocks.friedrich.boilerplate;

import org.apache.commons.lang3.StringUtils;

/**
 * A boilerplate class.
 */
public class Boilerplate
{
    /**
     * Return the string “Hello, World!”.
     *
     * @return The string “Hello, World!”.
     */
    public static String getHelloWorld()
    {
        return StringUtils.repeat("Hello, World! ", 3);
    }

    public static void main(String[] args) {
        System.out.println(getHelloWorld());
    }
}

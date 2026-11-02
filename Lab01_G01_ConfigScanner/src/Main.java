import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.Reader;
import java.nio.charset.StandardCharsets;

/** Driver: reads a UTF-8 file, prints every token, then a summary line. */
public class Main {
    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            System.err.println("Usage: java -cp out Main <file.conf>");
            System.exit(2);
        }
        PrintStream out = new PrintStream(System.out, true, "UTF-8");
        int tokens = 0, errors = 0;

        try (Reader in = new InputStreamReader(new FileInputStream(args[0]), StandardCharsets.UTF_8)) {
            ConfigScanner scanner = new ConfigScanner(in);
            Token t;
            while ((t = scanner.nextToken()) != null) {   // null = end of input
                out.print(t + "\n");                       // "\n" keeps output identical on every OS
                if (t.type.isError()) errors++; else tokens++;
            }
        }
        out.print("# end: tokens=" + tokens + " errors=" + errors + "\n");
        out.flush();
    }
}

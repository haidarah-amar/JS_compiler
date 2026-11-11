import org.antlr.v4.runtime.*;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) throws Exception {

        CharStream input =
                CharStreams.fromPath(Paths.get("src", "input.js"));

        JavaScriptLexer lexer = new JavaScriptLexer(input);

        Token token;

        List<String> errors = new ArrayList<>();

        System.out.println("--- Tokens Found ---");

        while ((token = lexer.nextToken()).getType() != Token.EOF) {

            int line = token.getLine();
            int column = token.getCharPositionInLine() + 1;

            if (token.getType() == JavaScriptLexer.UNTERMINATED_STRING) {

                errors.add(
                        "Error at " + line + ":" + column
                                + " [Unterminated String: " + token.getText() + "]"
                );

            } else if (token.getType() == JavaScriptLexer.ERRCHAR) {

                errors.add(
                        "Error at " + line + ":" + column
                                + " [Unexpected character: " + token.getText() + "]"
                );

            } else {

                String type = JavaScriptLexer.VOCABULARY
                        .getSymbolicName(token.getType());

                System.out.println(
                        "Text: [" + token.getText() + "]"
                                + " -> Type: " + type
                                + " (Line: " + line
                                + ", Column: " + column + ")"
                );
            }
        }

        System.out.println("\n--- Lexical Errors: " + errors.size() + " ---");

        for (String error : errors) {
            System.out.println(error);
        }
    }
}
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
        Token pendingToken = null;

        List<String> errors = new ArrayList<>();

        System.out.println("--- Tokens Found ---");

        while (true) {

            if (pendingToken != null) {
                token = pendingToken;
                pendingToken = null;
            } else {
                token = lexer.nextToken();
            }

            if (token.getType() == Token.EOF) {
                break;
            }

            int line = token.getLine();
            int column = token.getCharPositionInLine() + 1;

            if (token.getType() == JavaScriptLexer.REGEX_LITERAL) {

                String regexText = token.getText();

                int lastSlash = regexText.lastIndexOf('/');

                String flags = regexText.substring(lastSlash + 1);

                // Check the next token for unsupported flags
                Token next = lexer.nextToken();

                boolean adjacent =
                        next.getLine() == line &&
                                next.getCharPositionInLine() ==
                                        token.getCharPositionInLine()
                                                + regexText.length();

                if (adjacent &&
                        next.getType() == JavaScriptLexer.IDENTIFIER) {

                    flags += next.getText();

                } else {
                    pendingToken = next;
                }

                String flagError = null;

                // Check unsupported flags
                for (char flag : flags.toCharArray()) {
                    if ("dgimsuvy".indexOf(flag) == -1) {
                        flagError = "Unsupported regex flag: " + flag;
                        break;
                    }
                }

                // Check duplicate flags
                if (flagError == null) {
                    for (int i = 0; i < flags.length(); i++) {
                        if (flags.indexOf(flags.charAt(i)) != i) {
                            flagError =
                                    "Duplicate regex flag: " + flags.charAt(i);
                            break;
                        }
                    }
                }

                // u and v cannot be used together
                if (flagError == null &&
                        flags.contains("u") &&
                        flags.contains("v")) {

                    flagError = "Regex flags 'u' and 'v' cannot be used together";
                }

                if (flagError != null) {

                    errors.add(
                            "Error at " + line + ":" + column
                                    + " [" + flagError + "]"
                    );

                } else {

                    System.out.println(
                            "Text: [" + regexText + "]"
                                    + " -> Type: REGEX_LITERAL"
                                    + " (Line: " + line
                                    + ", Column: " + column + ")"
                    );
                }

            } else if (token.getType() == JavaScriptLexer.UNTERMINATED_STRING) {

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
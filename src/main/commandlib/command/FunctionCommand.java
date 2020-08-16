package commandlib.command;

import commandlib.command.util.*;

public class FunctionCommand extends Command {

  public FunctionCommand(String[] argVars) {
    super(argVars);
    output = Util.loadTemplateFile("function-locals.asm");
  }

  public String[] write(String[] args, int linePos) {
    String functionDeclaration = "(" + args[1] + ")\n";

    int localVars = Integer.parseInt(args[2]);

    String parsedOutput = functionDeclaration;

    for (int i = 0; i < localVars; i++) {
      parsedOutput += output;
    }

    String[] parsedOutputArr = parsedOutput.split("\n");

    return parsedOutputArr;
  }
}
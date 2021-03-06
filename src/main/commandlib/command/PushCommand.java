package commandlib.command;

import commandlib.command.util.*;
import commandlib.command.memorylocation.*;

public class PushCommand extends Command {

  protected String pushConstant;
  protected String pushLocation;
  protected String pushBase;
  protected String pushStatic;

  public PushCommand(String[] argVars, Boolean _isClassDept) {
    super(argVars, _isClassDept);
    pushConstant = Util.loadTemplateFile("../lib/command-library/push/push-constant.asm");
    pushLocation = Util.loadTemplateFile("../lib/command-library/push/push-location.asm");
    pushBase = Util.loadTemplateFile("../lib/command-library/push/push-base.asm");
    pushStatic = Util.loadTemplateFile("../lib/command-library/push/push-static.asm");
  }

  public String[] write(String[] args, int linePos, String className) {
    String[] parsedOutput = {};

    MemoryLocation pushType = MemoryLocation.getType(args[1]);

    switch (pushType) {
      case CONSTANT:
        parsedOutput = Parse.pushPop(pushConstant, args, argVars, pushType, className);
        break;
      case ARGUMENT:
      case LOCAL:
      case THIS:
      case THAT:
        parsedOutput = Parse.pushPop(pushLocation, args, argVars, pushType, className);
        break;
      case TEMP:
      case POINTER:
        parsedOutput = Parse.pushPop(pushBase, args, argVars, pushType, className);
        break;
      case STATIC:
        parsedOutput = Parse.pushPop(pushStatic, args, argVars, pushType, className);
        break;
      default:
        break;
    }
    return parsedOutput;

  }
}
package commandlib.command;

public abstract class Command {
  protected String name;
  protected String output;
  protected String[] argVars = new String[3];

  public Boolean isClassDept = false;

  public Command(String name) {
    this.name = name;
  }

  public Command(String name, Boolean _isClassDept) {
    this.isClassDept = true;
    this.name = name;
  }

  public Command(String[] _argVars) {
    this.init(_argVars);
  }

  public Command(String[] _argVars, Boolean _isClassDept) {
    this.isClassDept = true;
    this.init(_argVars);
  }

  private void init(String[] _argVars) {
    this.name = _argVars[0];

    for (int i = 1; i < _argVars.length; i++) {
      this.argVars[i - 1] = _argVars[i];
    }
  }

  public String[] write(String[] args, int linePos) {
    return output.split("\n");
  }

  public String[] write(String[] args, int linePos, String className) {
    return output.split("\n");
  }
}
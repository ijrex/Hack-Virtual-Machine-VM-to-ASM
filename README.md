# Hack Virtual Machine

## Parses one or more Hack Virtual Machine (.vm) files in a given directory and writes a single Hack Machine Assembly (.asm) file to the same location.

This personal project has been created as an accompaniment for Chapters 7 and 8 of the book [The Elements of Computing Systems](https://www.nand2tetris.org/course). The aforementioned should be referenced for the full specification of the Hack VM and Hack ASM languages. The Hack ASM code is designed to run on the Hack Hardware platform.

Even though it's unlikely that the Hack VM or ASM languages will change in the future. This Virtual Machine is built with consideration for scalability and accessibility to other developers.

---

# Project Overview

## VM Assembler

#### The  class serves as the software entry point

Loads Hack VM file(s), declares the Command Library and initiates file parsing and writing (explained in detail below).

## Parsing & writing files

The `VMAssembler` takes one or more Hack VM (.vm) files as input. Subsequently, the `readwrite` package in called which  parses the VM code and outputs a single Hack ASM (.asm) file ready to run on the Hack hardware platform.

The key steps `readwrite` takes to create the Hack ASM output are as follows: 

- Bootstrap the pre-built Hack ASM code necessary for programmes to start (assign memory locations etc). Because some tests do not require the bootstrap code, this feature can be disabled on the `readwrite` constructor.

- Translate the Hack VM source files and write ASM code to the output file:
	- Ensure that `sys.vm` is the first Hack VM file to be handled by the programme.
	- March through the Hack VM source files, translating each command line-by-line into blocks of Hack ASM code.
	- Trim all comments and whitespace.

- Append any Libraries to the end of the computer program which are required for certain commands to run.

## Command Library

The Command Library defines all Hack VM commands in the language specification and returns blocks of assembly output as strings.

### The `commandlib` package

This package serves two key purposes:

#### 1. Defining Commands

Hack VM commands are defined in the built-in `commands` map by type and syntax.

`commands.put("push", new PushCommand(new String[] { "push", "LOCATION", "VALUE" }, true));`

In the above example: 
- `push` is the key the command will be referenced by.
- `PushCommand` is an exention of the `Command` constructor class in the nested `commandlib.command` package.
- The String array describes the `push` command's expected arguments. e.g. `{ "push", "LOCATION", "VALUE" }` might be seen in Hack VM as `push constant 999`. Where relevant, the described arguments should match the variables used in their template files (detailed below).
- Certain commands need to know their parent class name (Hack VM file name) in order to be translated. This can be forwarded by appending `true` in the constructor.

#### 2. Returning Hack ASM Code

Translated commands are returned as formatted Strings of Hack ASM code using the following methods.

- **Write** (`write`): Individual lines of VM code which get parsed whilst marching through the Hack VM files.

- **Bootstrap code** (`init`): Chunks of pre-built code to be ran prior to any file parsing. 

- **Libraries** (`lib`): 
Libraries hold blocks of reusable code which don't require the complex stack requirements of functions. Some commands may point to specific Libraries in order to operate. For example, the Hack ASM output of the `add` command simply contains a pointer to the relevent section of the Arithmetic Library; when the translated computer program sees an `add` command, it will simply jump to the correct location in the Arithmetic Library, perform its operation on the stack and then jump back to where it left off.  

### The `commandlib.command` package

Parsing functionality for all Hack VM commands are defined in this nested package using the abstract `Command` class. The procedure to translate individual commands varies by class, however, the `write` method must always return a String array holding individual lines of ASM code; this String Array is essential for the `commandlib` package to keep track of the line number of the computer program.

#### The `Command` Classes

Most commands described in the `commandlib.command` classes utilize Hack ASM (.asm) template files. These templates may contain placeholder variables intended to be replaced with command specific arguments at compile time. 

**Using the `FunctionCommand` command as an example:**

The file scanner comes accross the command `function Main.fibonacci 3`. First of all, the Virtual Machine recognises this is a `function` command from `arg[0]`. Because of the command format described in the `FunctionCommand` constructor, it expects two arguments: `arg[1]` which is in this case `Main.fibonacci`; and `arg[2]` which happens to be `3`.

1. On creation, the `FunctionCommand` constructor has already loaded a Hack ASM template file called `function-locals.asm` into the class’s `output` variable.
2. The `write` method handles the given arguments appropriately, replacing the variables in the `output` variable: 
	- Injecting `arg[1]` into a Hack ASM label command.
	- Performing a regex search on the template file to replace all instances of `$V$_VALUE_$V$` with the value of `arg[2]`.

## The `commandlib.command.memorylocation` package

Specific pointers require assigned memory locations on the Hack hardware platform. As an example, `local` is important enough to have a designated symbol in the Hack ASM language (`LCL`), `temp` doesn’t have its own symbol, but is always saved at `R5` (`RAM[5]`).

This package saves all memory locations/bases as constants, they can be parsed or referenced using their methods.

## Template files 

Template files are saved outside of the main project in the `/lib/command-library` directory and should be fetched using the `loadTemplateFile` util. Searches for template files recursive; the folder structure inside of  `/lib/command-library` exists to aid the developer but is not required by this method. 

It should be noted that the Hack ASM (.asm) template files can run on the Hack CPU emulator and can therefore, have their own unit tests.

Template files can use variables which will be replaced at compile time. To make life easier for the developer, a common syntax is recommended for template file variables. Prefixes and suffixes are outlined below, the middle text should be uppercase and informative to the developer of the intended output.

### `$V$`

A user-defined variable argument to be parsed by the Virtual Machine. These should match the arguments described in the `assignCommandDescriptions` method of the `commandlib` package.

e.g. `$V$_VALUE_$V$`, `$V$_LOCATION_$V$`


### `$C$`

A non user-defined variable argument to be parsed by the Virtual Machine: In the below example, `END_OF_BLOCK` isn’t an argument explicitly given from a command in the Hack VM code; it is however, required to allocate a specific memory address in outputted Hack ASM code.

e.g. `$C$_END_OF_BLOCK_$C$`

### `$S$`

A static variable name. These are not explicitly given by the Hack VM commands, rather the name of the Hack VM file itself (also the class name). Further reading on Hack VM static variables [here](https://www.nand2tetris.org/course).

e.g. `$S$_STATIC_$S$`

### `$L$`

Used for libraries. In the below example, the `add` command using the `ArithmeticCommand` class replaces the variable to point the correct programme location in the Arithmetic Library.
 
 e.g. `@$L$_ARITHMETIC_LIB_$L$` gets replaced with `@ARITHMETIC_ADD`


## `loadfile` package

This package contains two utility classes, `loadfile` and `loadfiles`. These packages are required to load the source Hack VM files as well as ASM template files.

`LoadFile`: Search for, and load an individual file within the project folder or a specified directory. File extention type may also be set. 

`LoadFiles`: Load all files of a specific type within a specified directory.

## Tests

Unit tests can be found in the `/tests` directory and run on the Nand2Tetris CPU Emulator https://www.nand2tetris.org/software.

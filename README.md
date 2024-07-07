# Air Apple

A simple command-line based airline booking system written in ARM64 assembly language for the Apple M1 architecture. This program allows you to allocate seats and cancel tickets using basic user input.

## Features

- Allocate a seat.
- Cancel a ticket.
- Display menu options.
- Simple and easy-to-use command-line interface.

## Requirements

- Apple M1 Mac
- Xcode Command Line Tools (for the assembler and linker)

## Installation

### Step 1: Install Xcode Command Line Tools

Open your terminal and run the following command to install the Xcode Command Line Tools:

```bash
xcode-select --install
```

### Step 2: Assemble the Code

Use the `as` assembler to convert the assembly source file into an object file:

```bash
as -o air_apple.o air_apple.s
```

### Step 3: Link the Object File

Link the object file to create an executable. You can use `ld` directly or `clang` to simplify the process:

Using `ld`:
```bash
ld -o air_apple air_apple.o -lSystem
```

Using `clang`:
```bash
clang -o air_apple air_apple.o -Wl,-no_pie
```

### Step 4: Run the Program

Make the program executable and run it:

```bash
chmod +x air_apple
./air_apple
```

## Usage

1. **Run the Program**:
   - Execute the `./air_apple` command in the terminal.

2. **Allocate a Seat**:
   - Enter `1` and press Enter to allocate a seat. The program will search for the first available seat and allocate it if possible.

3. **Cancel a Ticket**:
   - Enter `2` and press Enter to cancel a ticket. The program will search for an allocated seat and cancel it if possible.

4. **Exit the Program**:
   - Enter `3` and press Enter to exit the program.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This `README.md` provides detailed instructions on how to set up, compile, and run the `Air Apple` assembly program on an Apple M1 Mac.
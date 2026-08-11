# Bash Module – Shell Scripting Practice

This module is practice-first: instead of writing notes, I set myself scripting problems and solved them. Every script starts with the mission it was written to solve, so the file is its own explanation.

---

## Bash – The Game

A ten-level challenge series I built for myself, each level harder than the last and each one building on the previous.

| Level | Mission | Concepts |
| --- | --- | --- |
| 1 | The Basics — set up an `Arena` of character files | Files and directories |
| 2 | Output the numbers 1 to 10, one per line | `for` loops, variables |
| 3 | Check whether `hero.txt` exists in a directory | Conditionals, `-f` test |
| 4 | Copy all `.txt` files into a new backup directory | File manipulation, loops |
| 5 | **Boss Battle 1** — create a directory, populate it, move files conditionally, list both | Everything from levels 1–4 |
| 6 | Accept a filename argument and count its lines; fail cleanly if none given | Argument parsing, guard clauses |
| 7 | Sort all `.txt` files in a directory by size, smallest to largest | Sorting, piping |
| 8 | Search for a word across all `.log` files and report which files match | `grep`, multi-file iteration |
| 9 | Monitor a directory for creation, modification, and deletion, logging with timestamps | Change detection, logging |
| 10 | **Boss Battle 2** — generate files with random line counts, sort by size, and archive any containing "Victory" | Randomisation, sorting, conditional moves |

---

## Bash Challenges

Standalone problems separate from the game:

- `basic_calculator.sh` — two numbers in, arithmetic operations out
- `file_checker_permissions.sh` — check a file exists and display its permissions
- `backup_textfiles.sh` — back up `.txt` files from one directory to another, timestamped
- `file_operations_script.sh` — automate directory and file creation

---

## Concept folders

Smaller scripts written while learning each idea, before applying them in the game:

| Folder | Covers |
| --- | --- |
| `Loops&FlowControl/` | `for` and `while` loops, `if` / `elif` / nested `if`, `break` and `continue` |
| `Functions/` | Defining functions, `local` scope, user input with `read`, input validation with regex, piping between functions |
| `Error_Handling/` | Exit codes and `$?`, guard clauses, checking a command exists, division-by-zero handling |
| `Reading_Files/` | Reading line by line with `while IFS= read -r`, writing to files, processing file contents |

---

## Running the scripts

Most scripts take a directory or filename as an argument:

```bash
chmod +x script_name.sh
./script_name.sh /path/to/target
```

Several prompt for input interactively instead. Read the mission comment at the top of each file — it states exactly what the script expects.

---

## What I took away

- Quoting matters. `"$1"` and `$1` behave differently the moment a path has a space in it.
- `local` inside functions prevents variables leaking into the global scope.
- Guard clauses at the top of a function (check the argument exists, check the file exists, return early) make the rest of the script much simpler.
- `[[ ]]` is safer than `[ ]` in Bash — it handles unset variables and pattern matching without surprises.

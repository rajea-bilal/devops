# 🐧 Linux DevOps Learning

> Documenting Linux commands and solutions from various sources and learning resources.

---

## 📑 Table of Contents

- [🎯 OverTheWire Bandit](#-overthewire-bandit)
- [💻 General Linux Commands](#-general-linux-commands)
- [🛠️ DevOps Tools](#️-devops-tools)
- [📚 Other Resources](#-other-resources)

---

## 🎯 OverTheWire Bandit

### Level 0
**Objective:** Connect to the server

**Commands:**
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

**Notes:**
- Password: `bandit0`

---

### Level 1
**Objective:** 

**Commands:**
```bash

```

**Notes:**

---

### Common Commands Used in Bandit

#### 1. `ssh`
Connects your terminal to another machine and opens a remote shell session.

**Format:**
```bash
ssh username@hostname -p port
```

**Example:**
```bash
ssh bandit13@bandit.labs.overthewire.org -p 2220
```

**Meaning:** "Open an SSH connection to user bandit13 on bandit.labs.overthewire.org, using port 2220."

---

#### 2. `ssh -i <keyfile>`
Uses a private key file to authenticate instead of a password.

**Example:**
```bash
ssh -i bandit14_key bandit14@bandit.labs.overthewire.org -p 2220
```

**Meaning:** "Use bandit14_key as the private SSH key and log in as bandit14."

---

#### 3. `chmod 600 file`
Changes file permissions.

**Meaning:**
- `6` = owner can read/write
- `0` = group has no access
- `0` = others have no access

**Note:** SSH requires private keys to be locked down like this.

---

#### 4. `ls`
Lists files in the current directory.

---

#### 5. `cat <filename>`
Displays the contents of a file.

**Example:**
```bash
cat data.txt
```

**Meaning:** "Show what is inside data.txt."

---

#### 6. `find`
Searches for files in directories.

**Common format:**
```bash
find <path> -name <pattern>
```

**Example:**
```bash
find . -name data.txt
```

**Meaning:** "Look for files named data.txt in this directory and below."

---

#### 7. `sort`
Sorts lines in a file alphabetically or numerically.

**Example:**
```bash
sort data.txt
```

---

#### 8. `uniq -u`
Shows only the unique lines — lines that appear exactly once.

**Example:**
```bash
sort data.txt | uniq -u
```

**Meaning:** "Sort the file, then show the lines that occur only once."

---

#### 9. `grep`
Searches for text patterns inside files.

**Example:**
```bash
grep "password" data.txt
```

**Meaning:** "Find any line in data.txt that contains the word password."

---

#### 10. `base64`
Encodes or decodes data using Base64.

**Decode:**
```bash
base64 -d data.txt
```

**Meaning:** "Decode the Base64 content of data.txt."

---

#### 11. `tr`
Translates or replaces characters.

**ROT13 example:**
```bash
cat data.txt | tr "A-Za-z" "N-ZA-Mn-za-m"
```

**Meaning:** "Replace each letter with the letter 13 positions ahead (ROT13)."

---

#### 12. `xxd -r`
Reverses a hexdump back into a binary file.

**Example:**
```bash
xxd -r data.txt > data.bin
```

**Meaning:** "Take the hex dump in data.txt and rebuild the original file as data.bin."

---

#### 13. `file <filename>`
Identifies what type of file something is.

**Example:**
```bash
file data.bin
```

**Meaning:** "Tell me whether this is gzip, bzip2, tar, text, etc."

---

#### 14. `mv old new`
Renames or moves a file.

**Example:**
```bash
mv data.bin data.gz
```

**Meaning:** "Rename data.bin to data.gz so tools recognise it."

---

#### 15. `gunzip <file.gz>`
Decompresses a gzip file.

---

#### 16. `bunzip2 <file.bz>`
Decompresses a bzip2 file.

---

#### 17. `tar xf <archive>`
Extracts files from a tar archive.

**Meaning of flags:**
- `x` = extract
- `f` = the next argument is a filename

---

#### 18. `nc` (netcat)
Opens a connection to a specific port and lets you send/receive raw data.

**Example:**
```bash
nc localhost 30000
```

**Meaning:** "Connect to port 30000 on the machine I'm currently on. Whatever you type after this is sent to that port, and you see the reply."

---

## 💻 General Linux Commands

### 📁 File Operations
```bash
# List files
ls -la

# Read file
cat filename
less filename
more filename

# Find files
find /path -name "filename"
```

### 📝 Text Processing
```bash
# Search in files
grep "pattern" file
grep -r "pattern" directory

# Sort and unique
sort file | uniq
```

### 🔐 Permissions
```bash
# Change permissions
chmod 755 file
chmod +x file

# Change ownership
chown user:group file
```





### 🌐 Networking
```bash
# Test connectivity
ping hostname
curl url
wget url
```

---

## 🛠️ DevOps Tools

### 🔷 Git
```bash
# Common git commands
git status
git add .
git commit -m "message"
git push origin main
```

---



# Over The Wire Bandit Game

## Bandit Level 12 → Level 13

**Challenge:**
The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)



**Solution:**

```bashmkdir /tmp/bandit12
cp data.txt /tmp/bandit12
cd /tmp/bandit12
xxd -r data.txt
```

### Explanation:

- xxd changes how the data is written, not what the data is.
- It can convert binary data to hex data
```bashxxd file.bin
```
- It can also convert hex data to binary
```bashxxd -r hex.txt binaryfile
```
- "Take hex text and convert it back into binary data"
- Next step was to figure out the compression format
- used file data to see its format
- Once we know the format, we could rename the file with the correct extension because compression tools expect correct extensions to decompress them
- we used the mv command to rename files

Password: 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

**What I learned:**
Files can be compressed in multiple formats
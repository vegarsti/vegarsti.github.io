---
layout: post
title: Some Unix tricks
---
I am starting to believe that the Unix command-line toolbox can fix absolutely any problem related to text wrangling. Let me tell you about a problem I had, and how I used some Unix command-line utilities to solve it.

I'm working on research for my master thesis. As with many statisticians, I am running some simulations many times over. I first simulate some data, and then use an algorithm to estimate something based on that data. For each simulation run, I create some files, typically like so:

```
dataset-directory/0001_data.csv
dataset-directory/0001_A.csv
```
Sometimes a run fails. This doesn't really matter: For any failed simulation, I can just do another one. But what I do need is to keep track of which runs have failed. For the `0001` data, I had a successful run with algorithm `A`. Therefore I want to use the `0001` data on algorithm `B` as well.

After running algorithm `A` on a lot of data, I end up with a large list of files like

```
dataset-directory/0001_data.csv
dataset-directory/0001_A.csv
dataset-directory/0002_data.csv
dataset-directory/0002_A.csv
dataset-directory/0003_data.csv
dataset-directory/0003_A.csv
dataset-directory/0004_data.csv
dataset-directory/0005_data.csv
dataset-directory/0005_A.csv
dataset-directory/0006_data.csv
dataset-directory/0006_A.csv
dataset-directory/0007_data.csv
dataset-directory/0007_A.csv
dataset-directory/0008_data.csv
dataset-directory/0009_data.csv
dataset-directory/0009_A.csv
...
dataset-directory/0499_A.csv
```
The astute observer will note that the file for algorithm `A` on data `0004` and `0008` are missing. How can I get a list of all the data set numbers which didn't succeed?

Well, to be obtuse: Those that didn't succeed are the numbers from `0001` to `0500` except those that suceeded. And one handy command to get a list of numbers is `seq`:

```
$> seq 10
1
2
3
4
5
6
7
8
9
10
```
(Surprise!) It is implied that the sequence starts with `1`. `seq 2 10` wouldn't surprise you, either.

Now, if we can get a list of all the successful runs, we should be able to get what we want by cross-checking the list of successful runs with a `seq` command which prints all possible numbers!

Most command-line utilities do one pretty specific thing. For example, with `cut` you can get the characters on specific locations on each line

```
$> cat text
Lorem ipsum
dolor sit amet
$> cat text | cut -c 2-5
orem
olor
```
Notice here the use of the pipe operator `|`. Like I said, most utilities do one specific thing, and it does that thing well. The neat thing is that these can be combined, feeding the output from one command to another by use of pipes. Another key thing is that these commands work natively on a line-by-line basis -- they just work with an input stream of lines.

We can get a list of the successful file names by piping the files into a `grep` command, which is a command which can use regular expressions. Since all files start with an equal length of 4 digits, we can match these to the regular expression `\d\d\d\d`, which matches 4 digits in a row, and add the file ending for the `A` algorithm.

```
$> ls dataset-directory | egrep '\d\d\d\d_A.csv'
0001_A.csv
0002_A.csv
0003_A.csv
0005_A.csv
0006_A.csv
0007_A.csv
0009_A.csv
...
0499_A.csv
```
We are only interested in the numbers, so we can use `cut -c 1-4` to extract the number parts.

```
$> ls dataset-directory | egrep '\d\d\d\d_A.csv' | cut -c 1-4
0001
0002
0003
0005
0006
0007
0009
...
0499
```
These numbers aren't exactly the same as the numbers from the `seq` command, since these are zero-padded. Therefore we write a quick Python script to parse them as integers.

```
# parse.py
import sys

for line in sys.stdin:
    i = int(line)
    print(i)
```

Now, piping into this script will give us the numbers that we want:

```
$> ls dataset-directory | egrep '\d\d\d\d_A.csv' | cut -c 1-4 | python3 parse.py
1
2
3
5
6
7
9
...
499
```

We're getting there! Now we have to figure out how to cross-check these lists of numbers. Luckily, there exists a command called `comm`, which checks for <u>comm</u>on characters in two input streams. To get the input of a sequence of commands such as the one above, we have to evaluate it and redirect it, which we do by `<(...)`.

```
$> comm <(ls dataset-directory | egrep '\d\d\d\d_A.csv' | cut -c 1-4 | python3 parse.py) <(seq 500)
        1
        2
        3
    4
        5
        6
        7
    8
        9
    10
...
    500
```
This output is a bit disorienting. If we read the manual of `comm` (by doing `man comm`), we see that `comm` "produces three text columns as output: lines only in file1; lines only in file2; and lines in both files." To suppress column 1 -- which is empty, since no numbers are only from the file list -- call `comm` with the flag `-1`. And since we are not interested in the numbers which are in both streams, we suppress with the `-3` flag as well.

```
$> comm -1 -3 <(ls dataset-directory | egrep '\d\d\d\d_A.csv' | cut -c 1-4 | python3 parse.py) <(seq 500)
4
8
...
500
```

And we're done!
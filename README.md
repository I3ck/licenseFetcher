licenseFetcher
==============

Tool to fetch license files of Haskell packages.  


Installation
------------
This assumes that you have both `git` and `stack` installed.

```
$ git clone https://github.com/I3ck/licenseFetcher.git
$ cd licenseFetcher
$ stack install
```


Usage
-----
If trying to fetch all license files of your direct and indirect dependencies, consider using a script similar to:
```
stack ls dependencies | 
while read -r line; do 
    lineArray=(${line})
    name=${lineArray[0]}
    version=${lineArray[1]}
    echo "    fetching license for $name"
    licenseFetcher --packagename="$name" --packageversion="$version" --licensedir="licenses"
done
```
within your program's folder.
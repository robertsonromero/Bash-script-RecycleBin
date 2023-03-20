#!/bin/bash
#I pledge my honor that I have abided by the Stevens Honor System.

h=0
l=0
p=0

function pmessage {
cat << EOF
Usage: $(basename $0) [-hlp] [list of files]
   -h: Display help.
   -l: List junked files.
   -p: Purge all files.
   [list of files] with no other arguments to junk those files"
EOF
}

while getopts ":hlp" option; do
    case "${option}" in
    h)
        h=1;;
    l)
        l=1;;
    p)
        p=1;;
    *)
        echo "Error: Unknown option '-$OPTARG' " >&2
        pmessage 
        exit 1
    esac
done

if [[ ! -e $HOME/.junk ]]; then mkdir $HOME/.junk
fi
readonly junk=$HOME/.junk
numarg=$#
numflags=$(($l+$p+$h))


if [[ numarg -eq 0 ]]; then pmessage
exit 0;
fi

if [[ numflags -gt 1 ]]; then 
cat << EOF 
Error: Too many options enabled.
EOF
pmessage
exit 1


elif [[ numflags -eq 1 && numarg -gt 1 ]]; then 
cat << EOF 
Error: Too many options enabled.
EOF
pmessage
exit 1
fi

if [[ $h -eq 1  ]]; then
pmessage    
exit 0
fi

if [[ $l -eq 1 ]]; then
    ls  -lAF $junk
    exit 0
fi

if [[ $p -eq 1 ]]; then
    rm -rf $junk/{,.*}
    exit 0
fi

for file in "$@"; do
    if [[ ! -e "$file" ]] ; then 
        echo "Warning: '"$file"' not found." 
    else 
        mv $file $junk
    fi
done

exit 0


#!/bin/bash

file=$1

echo "hi your books are being downloaded........."

while read -r line
do
    book=$(echo $line | awk -F ", by " '{print $1}') #gexts the name of the book from the file                                        
    author=$(echo $line | awk -F ", by " '{print $2}') # gets the author of the book from the file                                   
    x=$(curl -s  https://www.gutenberg.org/dirs/GUTINDEX.ALL | grep -w -o -i -E -A 1 "^${book}[,] by ${author}+[[:blank:]]+[[:digit:]]{3,5}" |  grep -E -B 1 '^\s*$' | grep -E -o "[[:digit:]]{3,5}" ) # get the book number from website    
    author_dir=$(echo $author | tr A-Z a-z | sed 's/[[:space:]]/_/g') # changes format of author input lowercase
    book_file=$(echo $book | tr A-Z a-z | sed 's/[[:space:]]/_/g')
    
                                                                                                                      
    if [ ! -d "$author_dir" ];
    then
	mkdir "$author_dir"
        echo "Created directory: $author_dir"
    else
        echo "Directory $author_dir already exists"
    fi 

    wget -q https://www.gutenberg.org/cache/epub/$x/pg$x.txt -O $author_dir/$book_file.txt # downloads the book  
    echo "$book has been DOWNLOADED"
done < "$file"



    

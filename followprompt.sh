#!/bin/bash

file=$1
echo "hi your books are downloading..........."
while IFS= read -r line # starts a loop that reads each line because IFS is empty reads the unmod line very important
do
    book=$(curl -s $line | grep "Title: "| sed 's/Title: //g') #gets the name of the book from the file
    
    author=$(curl -s $line | grep "Author: "| sed 's/Author: //g') # gets the author of the book from the file          
    author_dir=$(echo $author | tr A-Z a-z | sed 's/[[:space:]]/_/g' | sed 's/_$//') # changes format of author input lowercase
    book_file=$(echo $book | tr A-Z a-z | sed 's/[[:space:]]/_/g' | sed 's/_$//')
    
                                                                                                                      
    if [ ! -d "$author_dir" ];
    then
	mkdir "$author_dir"
        echo "Created directory: $author_dir"
    else
        echo "Directory $author_dir already exists"
    fi 

    wget -q $line -O $author_dir/$book_file.txt # downloads the book  


    echo "DOWNLOAD COMPLETE for $book"
done < "$file"

echo "Get to reading neow!"


    

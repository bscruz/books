#!/bin/bash


if [ $# -eq 1 ]
then
    if [ "$1" == "book_list" ]
    then
	echo "hi your books are downloading..........."    

	while read line # starts a loop that reads each line 
	do
	
	    book=$(curl -s $line | grep "Title: "| sed 's/Title: //g') #gets the name of the book from the file
    
	    author=$(curl -s $line | grep "Author: "| sed 's/Author: //g') # gets the author of the book from the file          
	    author_dir=$(echo $author | tr A-Z a-z | sed 's/[[:space:]]/_/g' | sed 's/_$//') # changes format of author input lowercase
	    book_file=$(echo $book | tr A-Z a-z | sed 's/[[:space:]]/_/g' | sed 's/_$//') 
    

            if [ -z "$book" ]
	    then
		1>&2 printf "The $line does not exist, the internet address may be incorrect."
	    
     	    elif [ ! -d "$author_dir" ]; # if directory doesnt exist create a new one
	    then
		mkdir "$author_dir"
		echo "Created directory: $author_dir"
	    else
		echo "Directory $author_dir already exists"
	    fi 

	    wget -q $line -O $author_dir/$book_file.txt # downloads the book QUiETLYYY  

	    echo "DOWNLOAD COMPLETE for $book"
    
	done < "$1" #go back to the book list file (redirects it) and restart the process
	echo "Get to reading neowww" 
    fi
elif [ $# -gt 2 ]
then
    1>&2 printf "Oh no! TOO many inputs \n"
elif [ $# -eq 2 ]
then
    1>&2 printf "Oh no! TOO many inputs \n"
elif [ $# -eq 0 ]
then
    1>&2 printf "Input a file \n"
else
    1>&2 printf "INVALID input the file has to be named book_list \n"
fi

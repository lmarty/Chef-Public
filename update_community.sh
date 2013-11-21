#!/bin/bash
## LJM 11-15-13
## Hack to scrape community cookbooks
## Elegant=0, Functional=1
##
## USAGE :: Copy to your proposed working directory for community cookbooks.  Execute.
## NOTES :: DO NOT RUN THIS IN YOUR PRODUCTION CHEF REPO!! WE DONT WANT ALL THIS IN THERE!


## Well hi there!
echo "Scraping community chef repo to local directory"
if [ -a AA_Last_Update* ]
	then
		echo "The last time you updated was" `cat AA_Last_Update*`;
		echo "Go have a smoke, this is going to take a minute";
fi

## kill old update marker
rm -rf AA_Last_Update*;

## Gobble up community cookbooks into current directory
for monkey in `knife cookbook site list`; do knife cookbook site download $monkey; done;

## Unpack them all, bighammer overwrite existing, delete when done
for zebra in `ls *.tar.gz`; do tar -zxvf $zebra --overwrite --overwrite-dir; rm -rf $zebra; done;

## Sanitize .git configs that aren't ours
for badgit in `find . -name ".git" -print`; do rm -rf $badgit; done;

## Write our update marker
datefile=AA_Last_Update-`date +"%b-%d-%y"`;
touch $datefile;
echo `date +"%b-%d-%y"` >> $datefile

## C-ya
echo "Current community working set is clean and ready to cannibalize!"
echo "FULLY REVIEW ANY COOKBOOKS FROM THE COMMUNITY BEFORE MOVING TO THE PROD REPO!!!!"
echo "COMMUNITY COOKBOOKS ARE UNTRUSTED UNTIL *YOU* REVIEW AND BLESS THEM"

exit 0;



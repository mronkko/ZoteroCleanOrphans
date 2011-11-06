#!/usr/bin/perl

use DBI;
use File::Path;

# Update this to match your data directory
my $zoterostorage="/Users/mronkko/Documents/Research/Zotero";
my $zoterostoragefiles="$zoterostorage/storage";
my $dbh = DBI->connect("dbi:SQLite:dbname=$zoterostorage/zotero.sqlite","","");

# Query all PDF attachments

my $sth = $dbh->prepare('SELECT key FROM items' ) or die "Couldn't prepare statement: " . $dbh->errstr;


$sth->execute() or die "Couldn't execute statement: " . $sth->errstr;

print "Fetching all dirs as a array\n";  

opendir DIR,  $zoterostoragefiles or die "cannot open dir $zoterostoragefiles: $!";

my @files= readdir DIR;
closedir DIR;

while (@data = $sth->fetchrow_array()) {
	# Remove the item the file array
	print"Checking @data[0] \n";
	my $index = 0;
	$index++ until @data[$index] eq @data[0];
	splice(@files,  $index,1);
}

# Loop over the non-existing files
foreach (@files){
	print "Deleting orphaned directory $_ \n";
	# Uncomment the following line to actually delete things (Remove the # character from the beginning of the line)
	# rmtree(["$zoterostoragefiles/$_"]);
}
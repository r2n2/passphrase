#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use LWP::Simple;

my $randomURL="http://www.random.org/integers/?num=NUMXXX&min=1&max=6&col=5&base=10&format=plain&rnd=new";

my $dicewareURL="http://world.std.com/~reinhold/diceware.wordlist.asc";

my $VERSION  = "1.0";
my $dashes   = "---------------";
my $getlist  = 0;
my $help     = 0;
my $listfile = $ENV{DICEWAREFILE};
my $wordcnt  = 3;
my $words;
my %wordlist = ();

my $result = GetOptions ('wordcount=i' => \$wordcnt,
                         'file=s'      => \$listfile,
                         'getwordlist' => \$getlist,
                         'version'     => sub{ Print_Version(); },
                         'help|?'      => sub{ Usage(); }
                        );

if( $getlist )  # Get word list and exit.
{
   $words = get($dicewareURL) or die 'Unable to retreive diceware word list.';

   open(my $OuF, ">", "diceware.wordlist.asc") or
     die "Unable to open \"diceware.wordlist.asc\" output file.\n$!\n";

   print $OuF $words;

   close( $OuF );

   exit;
}

if( -e $listfile )
{
   %wordlist = Read_Wordlist( $listfile );
}
else
{
   Usage();
}

my $rows = 5*$wordcnt;
$randomURL =~ s/NUMXXX/$rows/;

my $content = get($randomURL) or die 'Unable to get random numbers';
$content =~ s/\s+//g;

my @rolls = $content =~ /(.{1,5})/g;

foreach my $num (@rolls)
{
   print "$wordlist{$num} ";
}

print "\n\n";

exit;

## Subroutines ###############################################################
sub Print_Version
{
   print "$0, version $VERSION\n";
   exit;
}


sub Read_Wordlist
{

   my $file = $_[0];

   my %list = ();
   my $InF;

   open( $InF, "<$file" ) or
     die "Error opening \"$file\"\n\t$?\n";

   while( my $rec = <$InF> )
   {
      chomp( $rec );
      if( $rec eq "" ) { next; }

      my($number,$word) = split(/\s/,$rec);
      $list{$number} = $word;
   }

   close( $InF );

   return( %list );

}

##############################################################################
sub Usage
{

   print "
                                passphrase.pl

   Program to create a passphrase using diceware.org's word list and a list of
   numbers retreived at runtime from randomw.org.  It can accept two arguments.
   The diceware.org word file and a roll count.

Usage: passphrase.pl [-file <word-file>] [-getwordlist] [-wordcnt <wordcount>]
                     [-help|?] [-version]

   [-file <word-file>] provides the path and name of the file containing
       diceware.org's word list.  The URL to retreieve this list is
       \"http://world.std.com/~reinhold/diceware.wordlist.asc\".  The
       environment variable DICEWAREFILE may point to the Diceware file or you
       may specify the file on the command line.

   [-getwordlist] Flag to signal retreival of Dice Ware word list.  It is
       quite possible that you do not have the Diecware word list.  In such an
       event this program is capable of retreiving a copy from the diceware
       site itself.  Upon completion the program will exit.

   [-help|?] Provide this help and exit.

   [-wordcnt <wordcount>] is the number of words the passphrase will contain.
      If not provided the default is 3 words.

   [-version] Print the program version and exit.

Example:

   \$ passphrase.pl -f ./diceware-wordlist.asc  -wordcnt 5

    berra egypt envy qa chen

##############################################################################
Note: This program retreives data from the internet.  Specifically two URLs
    are used.  The main URL is to the random.org site and runs a page there to
    create a text page of numbers.  The other URL is the Diceware wordlist
    page.  You are strongly encouraged to examine this code and the URLs to
    make sure that they point to what is claimed.

   Random.org: http://www.random.org/clients/http/ (HTTP Interface Description)
        http://www.random.org/integers/?num=10&min=1&max=6&col=1&base=10&format=plain&rnd=new

   Diceware: http://www.diceware.com/ redirects to
             http://world.std.com/~reinhold/diceware.html

         Wordlist: http://world.std.com/~reinhold/diceware.wordlist.asc
##############################################################################

Author:  Nelson Ingersoll
License: GNU Public License v2
Date:    2012.02.15

";

   exit;

}

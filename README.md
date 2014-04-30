                                passphrase.pl
 
   Program to create a passphrase using diceware.org's word list and a list of
   numbers retrieved at run-time from randomw.org. It can accept several
   arguments.

Usage: passphrase.pl [-file <word-file>] [-getwordlist] [-wordcnt <wordcount>]
                     [-help|?] [-version]

   [-file <word-file>] provides the path and name of the file containing
       diceware.org's word list.  The URL to retrieve this list is
       \"http://world.std.com/~reinhold/diceware.wordlist.asc\".  The
       environment variable DICEWAREFILE may point to the Diceware file or you
       may specify the file on the command line.

   [-getwordlist] Flag to signal retrieval of Diceware word list.  It is
       quite possible that you do not have the Diecware word list.  In such an
       event this program is capable of retrieving a copy from the diceware
       site itself.  Upon completion the program will exit.

   [-help|?] Provide this help and exit.

   [-wordcnt <wordcount>] is the number of words the passphrase will contain.
      If not provided the default is 3 words.

   [-version] Print the program version and exit.

Example:

   \$ passphrase.pl -f ./diceware-wordlist.asc  -wordcnt 5

    berra egypt envy qa chen

##############################################################################
Note: This program retrieves data from the internet.  Specifically two URLs
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

#MarcoPolo#
#####MarcoPolo is a mobile app that facilitates private and public key PGP encryption written in Objective-C for iOS.#####
It was designed for iOS 7 but has not been updated for iOS 8, but should work with minor edits.

The backend implementation that powers the encryption key generator and crypto functions relies on Marcin Krzyzanowski's github [UNetPGP](https://github.com/upnext/unnetpgp), which is a objective-c wrapper for NetPGP from BSD.

##Known issues##
*    UNNetPGP does not generate private keys successfully. Also it does not support the importing private keys created outside of UNetPGP.
*    Due to the above reason a new backend generator for private key creation needs to be replaced, which is minor code change once a effective library is found.

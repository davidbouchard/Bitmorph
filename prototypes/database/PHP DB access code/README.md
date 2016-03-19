# OSC
Ontario Science Centre
# Usage
server.local/update_character/charID/stationID
This will update the character with the most recent stationID, and returns a JSON array with the character info

## Sample return:

> [{"HEXid":"000001","pri\_color":"0","sec\_color":"0","current\_state":"1","sprite\_filename":"000002.png"},
> {"HEXid":"000001","pri\_color":"0","sec\_color":"0","current\_state":"2","sprite\_filename":"000002.png"},
> {"HEXid":"000001","pri\_color":"0","sec\_color":"0","current\_state":"3","sprite\_filename":"000000.png"},
> {"HEXid":"000001","pri\_color":"0","sec\_color":"0","current\_state":"4","sprite\_filename":"000000.png"},
> {"HEXid":"000001","pri\_color":"0","sec\_color":"0","current\_state":"5","sprite\_filename":"000002.png"}]

## Explaination of return
`HEXid` - the ID of the character (string 6 characters)
`pri\_color` - optional storage for a primary color (reference to a color table) (int from -128 to 128)
`sec\_color` - optional storage for a primary color (reference to a color table) (int from -128 to 128)
`current\_state` - What state this visit record is referencing (egg,bodyshape,etc) (int from 1-5)
`sprite\_filename` - Which sprite to use



# Development Notes

## Directory Strucuture

### controllers
This directory contains PHP code to be run on request of a particular page.
A request for "server.local/do-thing" will run the controller at "controllers/do-thing.controller.php".

### errors
This directory contains controllers for HTTP errors, such as 404.

### config
This directory contains configuration files for database information, etc.

### lib
This directory contains classes that can be used by code in any controller.

### framework
This directory contains classes for the autoloader and router system, as well as some basic utilities.

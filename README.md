# Roassal3
Roassal3 is a new agile visualization engine for Pharo 7 and Pharo 8.


## Installation on Pharo
Execute the following incantation in a Playground:
```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3/src';
    load.
``` 

Once loaded, you can execute in a playground:
```Smalltalk
RSAnimationExamples new example06Atom
```
You should an animated version of:
![atom](screenshots/atom.png)

_____
## For developers
A local clone of Roassal3 can be loaded with the following code (you need to provide the full path of the clone):

```Smalltalk
Metacello new
  baseline: 'Roassal3';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/Roassal3' ;
  lock;
  load.
```

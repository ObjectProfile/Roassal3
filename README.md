# Roassal3
[![Build Status](https://travis-ci.org/ObjectProfile/Roassal3.svg?branch=master)](https://travis-ci.org/ObjectProfile/Roassal3)

Roassal3 is a new agile visualization engine for Pharo 7, Pharo 8, and Pharo 9. Roassal is made to visualize in an interactive way data. 


## Installation on Pharo
Execute the following incantation in a Playground:
```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load.
``` 

Once loaded, you can execute in a playground:
```Smalltalk
RSAnimationExamples new example06Atom open
```
You should an animated version of:

![atom](screenshots/smallAtom.png)

## Short Tutorial

This super-short tutorial uses the dataset of _Les Miserables_. It can be loaded in Pharo using:
```Smalltalk
Metacello new
    baseline: 'LesMiserables';
    repository: 'github://bergel/LesMiserables';
    load.
```
The dataset essentially contains two kind of valuables data: _characters_ of the historical novel and _coappearances_ of the characters. We will visualize these data.

After loading Les Miserables and Roassal3, you can execute the following script:

```Smalltalk
"Extract data from Les Miserables French historical novel"
m := LMModel new create.

"Each character is represented as a small ellipse"
characters := m characters collect: [ :c | RSEllipse new size: 5 ].

"c is a canvas. This is where we can draw"
c := RSCanvas new.
c addAll: characters.

"All the characters are displayed as a grid"
RSGridLayout on: characters.

"The canvas can be zoomed in / out using keys I and O"
"It can also be navigated using scrollbars"
c @ RSCanvasController.

```

This produces the following picture:
![alt text](screenshots/LesMiserables01.png)

We can normalize the size of each character based on the number of times she or he coappears:

```Smalltalk
"Extract data from Les Miserables French historical novel"
m := LMModel new create.

"Each character is represented as a small ellipse"
characters := m characters collect: [ :c | RSEllipse new size: 5; model: c ] as: RSGroup.

"c is a canvas. This is where we can draw"
c := RSCanvas new.
c addAll: characters.

"We normalize the size of the characters using their coappearances"
RSNormalizer size 
	shapes: characters;
	normalize: #numberOfCoappearances.

"All the characters are displayed as a grid"
RSGridLayout on: characters.

"Make each element have a popup text"
characters @ RSPopup.

"The canvas can be zoomed in / out using keys I and O"
"It can also be navigated using scrollbars"
c @ RSCanvasController.
```
![alt text](screenshots/LesMiserables02.png)


We can add edges to indicate coappearances:
```Smalltalk
"Extract data from Les Miserables French historical novel"
m := LMModel new create.

"Each character is represented as a small ellipse"
characters := m characters collect: [ :c | RSEllipse new size: 5; model: c ] as: RSGroup.

"c is a canvas. This is where we can draw"
c := RSCanvas new.
c addAll: characters.

"We normalize the size of the characters using their coappearances"
RSNormalizer size 
	shapes: characters;
	normalize: #numberOfCoappearances.

"The same normalization using colors"
RSNormalizer color 
	shapes: characters;
	from: Color gray trans;
	to: Color red trans;
	normalize: #numberOfCoappearances.

eb := RSEdgeBuilder arrowedLine.
eb canvas: c.
eb color: Color gray.
eb moveBehind.
eb 	shapes: characters.
eb connectToAll: #characters.	

"All the characters are displayed as a grid"
RSForceBasedLayout new charge: -900; on: characters.

"Make each element have a popup text and is draggable"
characters @ RSPopup @ RSDraggable.

"The canvas can be zoomed in / out using keys I and O"
"It can also be navigated using scrollbars"
c @ RSCanvasController.
```
![alt text](screenshots/LesMiserables03.png)

Circles can be replaced with labels:
```Smalltalk
"Extract data from Les Miserables French historical novel"
m := LMModel new create.

"Each character is represented as a label"
characters := m characters collect: [ :c | RSLabel
    new size: 5; 
    text: c;
    model: c ] as: RSGroup.

"c is a canvas. This is where we can draw"
c := RSCanvas new.
c addAll: characters.

"We normalize the font size of the characters using their coappearances"
RSNormalizer fontSize 
	shapes: characters;
	from: 5;
	to: 50;
	normalize: #numberOfCoappearances.

"The same normalization using colors"
RSNormalizer color 
	shapes: characters;
	from: Color gray trans;
	to: Color red trans;
	normalize: #numberOfCoappearances.

eb := RSEdgeBuilder arrowedLine.
eb canvas: c.
eb color: Color gray trans.
eb moveBehind.
eb 	shapes: characters.
eb connectToAll: #characters.	

"All the characters are displayed as a grid"
RSForceBasedLayout new charge: -1500; on: characters.

"Make each element have a popup text and is draggable"
characters @ RSPopup @ RSDraggable.

"The canvas can be zoomed in / out using keys I and O"
"It can also be navigated using scrollbars"
c @ RSCanvasController.
```
![alt text](screenshots/LesMiserables04.png)
_____
## Get in touch
Share your happiness by joining the #Roassal channel, in the Pharo discord server: https://pharo.org/community

## Difference between Roassal2 and Roassal3
A list of differences and migration instruction are accessible from the Wiki https://github.com/ObjectProfile/Roassal3/wiki

_____
## Developers section
If you are a regular contributor of Roassal3, you probably wish to have a local clone of it on your local disk. You can load Roassal3 with the following code (assuming that you provide the full path of your clone):

```Smalltalk
Metacello new
  baseline: 'Roassal3';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/Roassal3' ;
  lock;
  load.
```

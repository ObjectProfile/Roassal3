"
I represent borders and line styles.

A same border can be shared amoung different shapes. Here is an example:

```Smalltalk
c := RSCanvas new.

b := RSBorder new color: Color blue.
(30 to: 50 by: 5) do: [ :nb |
	box := RSBox new size: nb.
	ellipse := RSEllipse new width: nb; height: nb + 10.
	box border: b.
	ellipse border: b.
	c add: box; add: ellipse.
	 ].

RSFlowLayout on: c shapes.
c @ RSCanvasController.
c open
```

Another example, using animation: 
```Smalltalk
c := RSCanvas new.

b := RSBorder new color: Color blue.
b dashArray: #(5 1 5).
(30 to: 60) do: [ :nb |
 box := RSBox new size: nb.
 ellipse := RSEllipse new width: nb; height: nb + 10.
 box border: b.
 ellipse border: b.
 c add: box; add: ellipse.
  ].

RSFlowLayout on: c shapes.
c @ RSCanvasController.

c newAnimation 
 from: 0;
 to: 40;
 on: b set: #dashOffset:.
c open
```

"
Class {
	#name : #RSBorder,
	#superclass : #RSObject,
	#instVars : [
		'width',
		'style',
		'paint'
	],
	#category : #'Roassal3-Shapes-Border'
}

{ #category : #visiting }
RSBorder >> accept: visitor [
	^ visitor visitBorder: self
]

{ #category : #'style-cap' }
RSBorder >> capButt [
	self pStyle capStyle: #capButt.
]

{ #category : #'style-cap' }
RSBorder >> capRound [
	self pStyle capStyle: #capRound.
]

{ #category : #'style-cap' }
RSBorder >> capSquare [
	self pStyle capStyle: #capSquare.
]

{ #category : #accessing }
RSBorder >> color [
	^ paint
]

{ #category : #accessing }
RSBorder >> color: aColor [
	"Set a color to the border. The color is provided as argument, and can be either a color object (e.g., `Color red`) or a symbol (e.g., `#yellow`)."
	paint := aColor.
	paint isColor ifTrue: [ ^ self ].
	paint := Color colorFrom: aColor.
]

{ #category : #'style-dashes' }
RSBorder >> dashArray: arrayOfNumbers [
	"Set the pattern for the dash. For example:
-=-=-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

b := RSBorder new color: Color blue.
b dashArray: #(1 5 10 15).
(30 to: 60) do: [ :nb |
	box := RSBox new size: nb.
	ellipse := RSEllipse new width: nb; height: nb + 10.
	box border: b.
	ellipse border: b.
	c add: box; add: ellipse.
	 ].

RSFlowLayout on: c shapes.
c @ RSControlsCanvas.
c
-=-=-=-=-=-=-=-=-=-=-=-=

	"
	self pStyle dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
RSBorder >> dashOffset [
	^ self pStyle dashOffset
]

{ #category : #accessing }
RSBorder >> dashOffset: offset [
	"Set the offset for the dash. The offset is useful when animating. 

```Smalltalk
c := RSCanvas new.

b := RSBorder new color: Color blue.
b dashArray: #(5 1 5).
(30 to: 60) do: [ :nb |
	box := RSBox new size: nb.
	ellipse := RSEllipse new width: nb; height: nb + 10.
	box border: b.
	ellipse border: b.
	c add: box; add: ellipse.
	 ].

RSFlowLayout on: c shapes.
c @ RSControlsCanvas.

c newAnimation 
	from: 0;
	to: 40;
	on: b set: #dashOffset:.

c
```
	"
	self pStyle dashOffset: offset
]

{ #category : #initialization }
RSBorder >> initialize [
	super initialize.
	paint := Color gray.
	width := 1.
]

{ #category : #'style-join' }
RSBorder >> joinBevel [
	self pStyle joinStyle: #joinBevel
]

{ #category : #'style-join' }
RSBorder >> joinMiter [
	self pStyle joinStyle: #joinMiter
]

{ #category : #'style-join' }
RSBorder >> joinRound [
	self pStyle joinStyle: #joinRound
]

{ #category : #private }
RSBorder >> pStyle [ 
	^ style ifNil: [ style := RSStrokeStyle new ].
]

{ #category : #accessing }
RSBorder >> paint [ 
	^ paint
]

{ #category : #accessing }
RSBorder >> paint: aPaint [
	paint := aPaint
]

{ #category : #printing }
RSBorder >> printOn: stream [
	width printOn: stream.
	stream nextPutAll: ', '.
	paint printOn: stream.
	style ifNil: [ ^ self ].
	stream nextPutAll: ', '.
	style printOn: stream.
]

{ #category : #accessing }
RSBorder >> style [
	^style
]

{ #category : #accessing }
RSBorder >> style: aStyle [
	style := aStyle
]

{ #category : #accessing }
RSBorder >> width [ 
	^ width
]

{ #category : #accessing }
RSBorder >> width: anInteger [ 
	"Set the width of the border. 
	
For example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new border: (RSBorder new color: Color red; width: 3); model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

RSNormalizer size
	shapes: shapes;
	normalize: #yourself.

interaction := RSHighlightable new.
interaction highlightColor: Color blue.
interaction highlightBorder: (RSBorder new color: Color black; width: 3).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```
	"
	width := anInteger
]

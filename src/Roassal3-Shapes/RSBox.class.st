"
<keyClass>
`RSBox` represents a box shape, which can be decorated in many ways.

*Responsibility*: represents a 2 dimentional box 

*Collaborators*: may interact with many classes covering composite shapes (e.g., `RSComposite`, `RSGroup`), the `RSCanvas` class, and interaction (e.g., `RSDraggable`, `RSPopup`).

*Variables*:
- `cornerRadius`: angle of the radius. If no radius is applied, the variable is nil

*Example*:
```Smalltalk
RSCanvas new
	add: (RSBox new size: 30);
	yourself
```

A slightly more complex example could be:

```Smalltalk
gradient := LinearGradientPaint new colorRamp: {  0 -> Color red. 1 -> Color black }.

gradient
			start: -50 asPoint;
			stop: 50 asPoint.
c := RSCanvas new.
s := RSBox new size: 80; cornerRadius: 20.
s color: gradient.
c add: s.	
c
```


"
Class {
	#name : #RSBox,
	#superclass : #RSBoundingShape,
	#instVars : [
		'cornerRadius'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSBox >> buildPathOn: visitor [
	visitor buildBoxPath: self
]

{ #category : #accessing }
RSBox >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
RSBox >> cornerRadius: aRSCornerRadius [
	"Set the radius of the corners. Accept a number as argument or a RSCornerRadius.

	For example:
```
c := RSCanvas new.
r := Random seed: 42.
40 timesRepeat: [
	box := RSBox new extent: (r nextInteger: 80) @ (r nextInteger: 80); color: Color gray; cornerRadius: 10.
	box color: Color random translucent.
	box translateTo: (r nextInteger: 200) @ (r nextInteger: 200).
	c add: box.
].
c @ RSCanvasController.
c open
```
"

	cornerRadius := aRSCornerRadius isNumber 
		ifTrue: [ RSCornerRadius new radius: aRSCornerRadius ]
		ifFalse: [ aRSCornerRadius ].
	self resetPath.
]

{ #category : #testing }
RSBox >> hasCornerRadius [
	^ cornerRadius notNil
		and: [ cornerRadius max > 0 and: [ cornerRadius min >= 0 ] ]
]

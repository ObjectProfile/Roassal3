"
A RSFlowLayout arrange shapes in a rectangle including space (gapSize) between them, ideally it give you a square if all elements have an equal height and width.

I work with RSAlignment 
"
Class {
	#name : #RSFlowLayout,
	#superclass : #RSAbstractFlowLayout,
	#category : #'Roassal-Layouts-Flow'
}

{ #category : #examples }
RSFlowLayout class >> exampleLabel [
	
	| words r wordShapes c |
	words := (String loremIpsum: 100) substrings.
	r := Random new.
	wordShapes := words collect: [ :w | 
		RSLabel new
			fontSize: (r nextInteger: 30);
			text: w ] as: RSGroup.

	c := RSCanvas new.
	c addAll: wordShapes.
	self new alignLabel; on: wordShapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : #alignment }
RSFlowLayout >> alignBottom [
	self alignment: #bottom
]

{ #category : #alignment }
RSFlowLayout >> alignLabel [
	"Allow to align labels along their baseline"
	self alignment: #label
]

{ #category : #alignment }
RSFlowLayout >> alignMiddle [
	self alignment: #middle
]

{ #category : #alignment }
RSFlowLayout >> alignTop [
	self alignment: #top
]

{ #category : #initialization }
RSFlowLayout >> initialize [
	super initialize.
	self alignTop
]

{ #category : #testing }
RSFlowLayout >> isAlignBottom [
	^ alignment = #bottom
]

{ #category : #testing }
RSFlowLayout >> isAlignLabel [
	^ alignment = #label
]

{ #category : #testing }
RSFlowLayout >> isAlignMiddle [
	^ alignment = #middle
]

{ #category : #testing }
RSFlowLayout >> isAlignTop [
	^ alignment = #top
]

{ #category : #hook }
RSFlowLayout >> linesFor: shapes [
	| x y maxLastLineHeight nextElement maxWidthFloat lines currentLine hgap vgap |
	hgap := self horizontalGap.
	vgap := self verticalGap.
	x := y := maxLastLineHeight := 0.
	maxWidthFloat := self maxWidth rsValue: shapes.
	lines := OrderedCollection new.
	currentLine := OrderedCollection new.
	shapes doWithIndex: [ :shape :index |
		shape translateTo: (x @ y) + (shape extent / 2.0).
		currentLine add: shape.
		x := x + shape width + hgap.
		maxLastLineHeight := maxLastLineHeight max: shape height.
		nextElement := shapes at: (index + 1 min: shapes size).
		(x + nextElement width) > maxWidthFloat ifTrue: [
			lines add: currentLine.
			x := 0.
			y := y + maxLastLineHeight + vgap.
			currentLine := OrderedCollection new.
			maxLastLineHeight := 0.
		].
	].
	currentLine ifNotEmpty: [ lines add: currentLine ].
	^ lines
]

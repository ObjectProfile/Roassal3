"
A RTFlowLayout arrange elements in a rectangle including space (gapSize) between them, ideally it give you a square if all elements have an equal height and width .

"
Class {
	#name : #RSFlowLayout,
	#superclass : #RSAbstractFlowLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSFlowLayout >> alignLabel [
	"Allow to align labels along their baseline.
	
```Smalltalk
words := (String loremIpsum: 100) substrings.
r := Random new.
wordShapes := words collect: [ :w | RSLabel new fontSize: (r nextInt: 30); text: w ] as: RSGroup.

c := RSCanvas new.
c addAll: wordShapes.
RSFlowLayout new alignLabel; on: wordShapes.
c @ RSCanvasController
```
"
	alignment := #label
]

{ #category : #hook }
RSFlowLayout >> doExecute: elements [

	| x y maxLastLineHeight maxNextLineHeight nextElement maxWidthFloat |
	x := self gapSize.
	y := self gapSize.
	maxLastLineHeight := 0.
	maxNextLineHeight := 0.
	nextElement := elements first.
	maxWidthFloat := self maxWidth rsValue: elements.
	elements doWithIndex: [ :anElement :index | 
		nextElement := index = elements size
			ifTrue: [ anElement ]
			ifFalse: [ elements at: index + 1 ].

		self isAlignBottom ifTrue: [ 
			translator translateBottomLeftOf: anElement to: x @ y.
			x := x + anElement width + self gapSize.
			
			x > maxWidthFloat | (x + nextElement width > maxWidthFloat) ifTrue: [ 
				x := self gapSize.
				maxNextLineHeight := self
					maxNextLineHeightFrom: index + 1
					for: elements.
				y := y + self gapSize + maxNextLineHeight.
				maxNextLineHeight := 0 ] ].

		self isAlignCenter ifTrue: [ 
			translator translateCenterLeftOf: anElement to: x @ y.

			x := x + anElement width + self gapSize.
			maxLastLineHeight := maxLastLineHeight max: anElement height.
			x > maxWidthFloat | (x + nextElement width > maxWidthFloat) ifTrue: [ 
				x := self gapSize.
				maxNextLineHeight := self
					maxNextLineHeightFrom: index + 1
					for: elements.
				y := y + self gapSize + (maxNextLineHeight / 2) + (maxLastLineHeight / 2).
				maxNextLineHeight := 0.
				maxLastLineHeight := 0 ] ].
		alignment = #label ifTrue: [ 
			anElement position: x @ y + (anElement extent / 2) + (0 @ anElement textExtents y_bearing).

			x := x + anElement width + self gapSize.
			maxLastLineHeight := maxLastLineHeight max: anElement height.
			x > maxWidthFloat | (x + nextElement width > maxWidthFloat) ifTrue: [ 
				x := self gapSize.
				maxNextLineHeight := self
					maxNextLineHeightFrom: index + 1
					for: elements.
				y := y + self gapSize + (maxNextLineHeight / 2) + (maxLastLineHeight / 2).
				maxNextLineHeight := 0.
				maxLastLineHeight := 0 ] 
			 ].
		self isAlignTop ifTrue: [ 
			translator translateTopLeftOf: anElement to: x @ y.
			x := x + anElement width + self gapSize.
			maxLastLineHeight := maxLastLineHeight max: anElement height.
			x > maxWidthFloat | (x + nextElement width > maxWidthFloat) ifTrue: [ 
				x := self gapSize.
				y := y + self gapSize + maxLastLineHeight.
				maxLastLineHeight := 0 ] ].

	]
]

{ #category : #'initialize-release' }
RSFlowLayout >> initialize [
	super initialize.
	self alignTop.
]

{ #category : #utility }
RSFlowLayout >> maxNextLineHeightFrom: index for: elements [
	| nextLineX maxNextLineHeight anElement maxWidthFloat i |
	maxNextLineHeight := 0.
	nextLineX := self gapSize.
	i := index min: elements size.
	anElement := elements at: i.
	maxWidthFloat := self maxWidth rsValue: elements.
	[ nextLineX < maxWidthFloat ] whileTrue: [
		nextLineX := nextLineX + self gapSize + anElement width.
		maxNextLineHeight := maxNextLineHeight max: anElement height.
		i = elements size
			ifFalse: [ anElement := elements at: (i := i + 1) ].
		].
	^ maxNextLineHeight
]

"
A RTFlowLayout arrange elements in a rectangle including space (gapSize) between them, ideally it give you a square if all elements have an equal height and width .

"
Class {
	#name : #RSFlowLayout,
	#superclass : #RSAbstractFlowLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSFlowLayout >> alignBottom [
	alignment := #bottom
]

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

{ #category : #alignment }
RSFlowLayout >> alignMiddle [
	alignment := #middle
]

{ #category : #alignment }
RSFlowLayout >> alignTop [
	alignment := #top
]

{ #category : #'initialize-release' }
RSFlowLayout >> initialize [
	super initialize.
	self alignTop.
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
RSFlowLayout >> linesFor: elements [
	| x y maxLastLineHeight nextElement maxWidthFloat lines currentLine gap |
	gap := self gapSize.
	x := y := gap.
	maxLastLineHeight := 0.
	maxWidthFloat := self maxWidth rsValue: elements.
	lines := OrderedCollection new.
	currentLine := OrderedCollection new.
	elements doWithIndex: [ :element :index |
		element position: (x @ y) + (element extent / 2.0).
		currentLine add: element.
		x := x + element width + gap.
		maxLastLineHeight := maxLastLineHeight max: element height.
		nextElement := elements at: (index + 1 min: elements size).
		(x + nextElement width) > maxWidthFloat ifTrue: [
			
			lines add: currentLine.
			x := gap.
			y := y + maxLastLineHeight + gap.
			currentLine := OrderedCollection new.
			maxLastLineHeight := 0.
		].
		
	].
	currentLine ifNotEmpty: [ lines add: currentLine ].
	^ lines
]

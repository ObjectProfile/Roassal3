"
A RTHorizontalFlowLayout is a FlowLayout horizontaly arranged, right queued at default.

"
Class {
	#name : #RSHorizontalFlowLayout,
	#superclass : #RSAbstractFlowLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSHorizontalFlowLayout >> alignCenter [
	alignment := #center
]

{ #category : #alignment }
RSHorizontalFlowLayout >> alignLeft [
	alignment := #left
]

{ #category : #alignment }
RSHorizontalFlowLayout >> alignRight [
	alignment := #right
]

{ #category : #'initialize-release' }
RSHorizontalFlowLayout >> initialize [
	super initialize.
	self alignLeft.
]

{ #category : #testing }
RSHorizontalFlowLayout >> isAlignCenter [
	^ alignment = #center
]

{ #category : #testing }
RSHorizontalFlowLayout >> isAlignLeft [
	^ alignment = #left
]

{ #category : #testing }
RSHorizontalFlowLayout >> isAlignRight [
	^ alignment = #right
]

{ #category : #hook }
RSHorizontalFlowLayout >> linesFor: shapes [
	| gap y x maxLastLineWidth lines currentLine maxHeight nextElement |
	gap := self gapSize.
	x := y := gap.
	maxLastLineWidth := 0.
	maxHeight := self maxWidth rsValue: shapes.
	lines := OrderedCollection new.
	currentLine := OrderedCollection new.
	shapes doWithIndex: [ :element :index |
		"maybe we need to use a mock element in all layouts"
		element translateTo: (x @ y) + (element extent / 2.0).
		currentLine add: element.
		y := y + element height + gap.
		maxLastLineWidth := maxLastLineWidth max: element width.
		nextElement := shapes at: (index + 1 min: shapes size).
		(y + nextElement height) > maxHeight ifTrue: [
			lines add: currentLine.
			y := gap.
			x := x + maxLastLineWidth + gap.
			currentLine := OrderedCollection new.
			maxLastLineWidth := 0.
		].
		
	].
	currentLine ifNotEmpty: [ lines add: currentLine ].
	^ lines
]

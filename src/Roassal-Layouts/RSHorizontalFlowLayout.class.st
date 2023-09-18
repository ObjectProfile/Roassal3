"
A RSHorizontalFlowLayout is a FlowLayout horizontaly arranged, right queued at default.

"
Class {
	#name : #RSHorizontalFlowLayout,
	#superclass : #RSAbstractFlowLayout,
	#category : #'Roassal-Layouts-Flow'
}

{ #category : #examples }
RSHorizontalFlowLayout class >> exampleLabel [
	
	| string characterShapes c |
	string := 'KISSItemSameStar'.
	characterShapes := RSLabel models: string.

	c := RSCanvas new.
	c addAll: characterShapes.
	
	self new maxWidth: characterShapes first height * 4; alignCenter; gapSize: 0; on: characterShapes.
	
	c @ RSCanvasController.
	c showEncompassingRectangles.
	^ c open
]

{ #category : #alignment }
RSHorizontalFlowLayout >> alignCenter [
	self alignment: #center
]

{ #category : #alignment }
RSHorizontalFlowLayout >> alignLeft [
	self alignment: #left
]

{ #category : #alignment }
RSHorizontalFlowLayout >> alignRight [
	self alignment: #right
]

{ #category : #initialization }
RSHorizontalFlowLayout >> initialize [
	super initialize.
	self alignLeft
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
	| hgap vgap y x maxLastLineWidth lines currentLine maxHeight nextElement |
	hgap := self horizontalGap.
	vgap := self verticalGap.
	x := y := maxLastLineWidth := 0.
	
	maxHeight := self maxWidth rsValue: shapes.
	lines := OrderedCollection new.
	currentLine := OrderedCollection new.
	shapes doWithIndex: [ :shape :index |
		"maybe we need to use a mock element in all layouts"
		shape translateTo: (x @ y) + (shape extent / 2.0).
		currentLine add: shape.
		y := y + shape height + vgap.
		maxLastLineWidth := maxLastLineWidth max: shape width.
		nextElement := shapes at: (index + 1 min: shapes size).
		(y + nextElement height) > maxHeight ifTrue: [
			lines add: currentLine.
			y := 0.
			x := x + maxLastLineWidth + hgap.
			currentLine := OrderedCollection new.
			maxLastLineWidth := 0.
		].
	].
	currentLine ifNotEmpty: [ lines add: currentLine ].
	^ lines
]

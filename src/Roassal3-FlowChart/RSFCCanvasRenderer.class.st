Class {
	#name : #RSFCCanvasRenderer,
	#superclass : #RSFCVisitor,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #accessing }
RSFCCanvasRenderer >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #visiting }
RSFCCanvasRenderer >> visitDecision: decision [
	| c aLabel diamond yesShape noShape |
	aLabel := RSLabel new text: decision label.
	diamond := RSShapeFactory diamond.
	c := RSComposite new.
	c shapes: { diamond . aLabel }.
	c model: decision.
	"diamond size: aLabel encompassingRectangle width + 15."
	diamond size: 80 @ 50.

	yesShape := canvas shapeFromModel: decision yesElement.
	noShape := canvas shapeFromModel: decision noElement.

	canvas add: (RSArrowedLine new from: diamond; to: yesShape; attachPoint: RSHorizontalAttachPoint new).
	canvas add: (RSArrowedLine new from: diamond; to: noShape; attachPoint: RSVerticalAttachPoint new).

	canvas add: c
]

{ #category : #visiting }
RSFCCanvasRenderer >> visitFlowline: flowline [

	| shape f t |
	shape := RSShapeFactory arrowedLine.
	shape model: flowline.
	f := canvas shapeFromModel: flowline from.
	self assert: [ f notNil ].
	shape from: f.

	t := canvas shapeFromModel: flowline to.
	self assert: [ t notNil ].
	shape to: t.
	shape attachPoint: (RSBorderAttachPoint new).
	canvas add: shape
]

{ #category : #visiting }
RSFCCanvasRenderer >> visitInputOutput: flowline [
	self visitProcess: flowline
]

{ #category : #visiting }
RSFCCanvasRenderer >> visitProcess: process [
	| s label |
	label := RSLabel new text: process label.
	s := RSComposite new.
	s addShape: label.
	s border: (RSBorder new color: Color black).
	"s adjustToChildren. "
	s model: process.
	canvas add: s.
	s extent: label extent + (20 @ 20).
]

{ #category : #visiting }
RSFCCanvasRenderer >> visitTerminal: terminal [
	canvas add: (RSShapeFactory box cornerRadius: 5; model: terminal)
]

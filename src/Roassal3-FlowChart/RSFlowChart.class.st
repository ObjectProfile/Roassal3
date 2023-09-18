Class {
	#name : #RSFlowChart,
	#superclass : #RSObject,
	#instVars : [
		'elements',
		'variables',
		'canvas'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #building }
RSFlowChart >> accept: aVisitor [
	aVisitor visitFlowchart: self
]

{ #category : #adding }
RSFlowChart >> addElement: anElement [
	elements add: anElement
]

{ #category : #building }
RSFlowChart >> build [
	| v |
	v := RSFCCanvasRenderer new.
	v canvas: canvas.
	self accept: v.

	RSTreeLayout on: canvas nodes.
	canvas nodes @ RSDraggable.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #accessing }
RSFlowChart >> canvas [
	^ canvas
]

{ #category : #'as yet unclassified' }
RSFlowChart >> decisionLabeled: aLabel as: variableName yes: variableNameYes no: variableNameNo [
	| e |
	e := RSFCDecision new label: aLabel.
	e yesElement: (self lookUp: variableNameYes).
	e noElement: (self lookUp: variableNameNo).
	self addElement: e.
	variables at: variableName put: e
]

{ #category : #accessing }
RSFlowChart >> elements [
	^ elements
]

{ #category : #'as yet unclassified' }
RSFlowChart >> flowFrom: variable1 to: variable2 [
	self addElement: (RSFCFlowline new from: (self lookUp: variable1) to: (self lookUp: variable2))
]

{ #category : #initialization }
RSFlowChart >> initialize [
	super initialize.
	elements := OrderedCollection new.
	variables := Dictionary new.
	canvas := RSCanvas new
]

{ #category : #'as yet unclassified' }
RSFlowChart >> inputOutputLabeled: aLabel as: variableName [
	| e |
	e := RSFCInputOutput new label: aLabel.
	self addElement: e.
	variables at: variableName put: e
]

{ #category : #'as yet unclassified' }
RSFlowChart >> lookUp: variable [
	^ variables at: variable
]

{ #category : #'as yet unclassified' }
RSFlowChart >> numberOfElements [
	^ elements size
]

{ #category : #'as yet unclassified' }
RSFlowChart >> processLabeled: aLabel as: variableName [
	| e |
	e := RSFCProcess new label: aLabel.
	self addElement: e.
	variables at: variableName put: e
]

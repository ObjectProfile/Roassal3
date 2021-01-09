Class {
	#name : #RSFlowCanvas,
	#superclass : #Object,
	#instVars : [
		'breadcrumbs',
		'canvas',
		'mapping'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #accessing }
RSFlowCanvas >> breadcrumbs [
	^ breadcrumbs asArray
]

{ #category : #accessing }
RSFlowCanvas >> canvas [
	^ canvas
]

{ #category : #initialization }
RSFlowCanvas >> clickOnModel: aModel [

	"relevantSelectors := aModel class selectors select: [ :sel | sel beginsWith: 'visualize' ]."
	
	(mapping includesKey: aModel class) 
		ifTrue: [
			canvas shapes do: #remove.
			(mapping at: aModel class) value: canvas value: aModel.
			self setOnCanvas: canvas.
			
			 ].
	canvas signalUpdate.
	
	breadcrumbs add: aModel
]

{ #category : #initialization }
RSFlowCanvas >> initialize [
	super initialize.
	canvas := RSCanvas new.
	mapping := Dictionary new.
	breadcrumbs := OrderedCollection new.
]

{ #category : #'instance creation' }
RSFlowCanvas >> open [
	^ canvas open
]

{ #category : #initialization }
RSFlowCanvas >> setOnCanvas: aCanvas [

	| relevantShapes |
	canvas := aCanvas.
	relevantShapes := aCanvas nodes select: [ :s | s model notNil ].
	relevantShapes when: RSMouseClick do: [ :evt |
		self clickOnModel: evt shape model ]
]

{ #category : #initialization }
RSFlowCanvas >> when: aClass visualize: twoArgsBlock [
	"twoArgsBlock follows [ :canvas :object | ... ]"
	mapping at: aClass put: twoArgsBlock
]

Class {
	#name : #RSAbstractConnection,
	#superclass : #Object,
	#instVars : [
		'inputCanvas',
		'outputs',
		'numberOfCreatedCanvases',
		'lastWindow',
		'windowOpener',
		'canvasOpenings'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #'as yet unclassified' }
RSAbstractConnection >> clickOnShape: aShape [
	| c win |
	outputs with: canvasOpenings do: [ :ob :aCanvasOpening |
		c := ob value: aShape model.
		aCanvasOpening canvas: c.
		
		win := c open.
		aCanvasOpening window ifNotNil: [ 
			aCanvasOpening window delete.
			win bounds: aCanvasOpening window bounds ].
		aCanvasOpening window: win.
		
		numberOfCreatedCanvases := numberOfCreatedCanvases + 1	
	]

]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> deleteAllWindows [
	canvasOpenings do: [ :co | co deleteWindow ]
]

{ #category : #'windows callback' }
RSAbstractConnection >> doNotOpenWindow [
	windowOpener := [ :window | window delete ]
]

{ #category : #initialization }
RSAbstractConnection >> initialize [
	super initialize.
	numberOfCreatedCanvases := 0.
	outputs := OrderedCollection new.
	canvasOpenings := OrderedCollection new.
	self openWindow.
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> inputCanvas: aCanvasOrBuilder [
	inputCanvas := aCanvasOrBuilder canvas.
	self prepareInputCanvas
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> lastWindow [
	"Return a reference to the last window open. If none have been open, then it returns nil"
	^ lastWindow
]

{ #category : #accessing }
RSAbstractConnection >> numberOfCreatedCanvases [
	"Return the number of created canvases. Useful for testing"
	^ numberOfCreatedCanvases
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> numberOfOuputs [
	"Return the number of ouputs the connection has"
	^ outputs
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> numberOfOutputs [
	^ outputs size
]

{ #category : #'windows callback' }
RSAbstractConnection >> openWindow [
	"Open per default"
	windowOpener := [ :canvas | canvas openOnce ]
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> output: oneArgBlock [
	"Add the callback of what to do in case of particular action in the input canvas"
	outputs add: oneArgBlock.
	canvasOpenings add: RSCanvasOpening new
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> prepareInputCanvas [
	inputCanvas nodes when: RSMouseClick do: [ :event |
		self clickOnShape: event shape ].
	
	inputCanvas nodes @ RSSelectionPresentationInteraction
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> processWindow: aWindow [
	lastWindow := aWindow.
	windowOpener value: aWindow
]

{ #category : #'windows callback' }
RSAbstractConnection >> windowOpener: oneArgBlock [
	"Take as argument a one-arg block, which will be evaluated on a window that is newly created"
	windowOpener := oneArgBlock
]

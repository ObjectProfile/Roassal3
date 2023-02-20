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

{ #category : #events }
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

{ #category : #'windows callback' }
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
	self openWindow
]

{ #category : #accessing }
RSAbstractConnection >> inputCanvas: aCanvasOrBuilder [
	inputCanvas := aCanvasOrBuilder canvas.
	self prepareInputCanvas
]

{ #category : #accessing }
RSAbstractConnection >> lastWindow [
	"Return a reference to the last window open. If none have been open, then it returns nil"
	^ lastWindow
]

{ #category : #accessing }
RSAbstractConnection >> numberOfCreatedCanvases [
	"Return the number of created canvases. Useful for testing"
	^ numberOfCreatedCanvases
]

{ #category : #accessing }
RSAbstractConnection >> numberOfOuputs [
	"Return the number of ouputs the connection has"
	^ outputs
]

{ #category : #accessing }
RSAbstractConnection >> numberOfOutputs [
	^ outputs size
]

{ #category : #'windows callback' }
RSAbstractConnection >> openWindow [
	"Open per default"
	windowOpener := [ :canvas | canvas openOnce ]
]

{ #category : #accessing }
RSAbstractConnection >> output: oneArgBlock [
	"Add the callback of what to do in case of particular action in the input canvas"
	outputs add: oneArgBlock.
	canvasOpenings add: RSCanvasOpening new
]

{ #category : #initialization }
RSAbstractConnection >> prepareInputCanvas [
	inputCanvas nodes when: RSMouseClick do: [ :event |
		self clickOnShape: event shape ].

	inputCanvas nodes @ RSSelectionPresentationInteraction
]

{ #category : #'windows callback' }
RSAbstractConnection >> processWindow: aWindow [
	lastWindow := aWindow.
	windowOpener value: aWindow
]

{ #category : #'windows callback' }
RSAbstractConnection >> windowOpener: oneArgBlock [
	"Take as argument a one-arg block, which will be evaluated on a window that is newly created"
	windowOpener := oneArgBlock
]

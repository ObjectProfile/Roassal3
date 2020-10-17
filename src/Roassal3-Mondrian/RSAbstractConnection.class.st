Class {
	#name : #RSAbstractConnection,
	#superclass : #Object,
	#instVars : [
		'inputCanvas',
		'outputs',
		'numberOfCreatedCanvases',
		'lastWindow',
		'windowOpener'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #'as yet unclassified' }
RSAbstractConnection >> clickOnShape: aShape [
	| win |
	outputs do: [ :ob |
		win := ob value: aShape model.
		self processWindow: win.
		numberOfCreatedCanvases := numberOfCreatedCanvases + 1	
	]

]

{ #category : #'windows callback' }
RSAbstractConnection >> doNotOpenWindow [
	windowOpener := [ :canvas | "do nothing" ]
]

{ #category : #initialization }
RSAbstractConnection >> initialize [
	super initialize.
	numberOfCreatedCanvases := 0.
	outputs := OrderedCollection new.
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
	outputs add: oneArgBlock
]

{ #category : #'as yet unclassified' }
RSAbstractConnection >> prepareInputCanvas [
	inputCanvas nodes when: RSMouseClick do: [ :event |
		self clickOnShape: event shape ].
	
	inputCanvas nodes @ RSSelectionPresentation
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

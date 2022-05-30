"
This action show or hide the encompassing rectangles of shapes in the canvas
SER = Show Encompassing Rectangles
"
Class {
	#name : #RSSERAction,
	#superclass : #RSAbstractAction,
	#category : #'Roassal3-Pharo8'
}

{ #category : #hooks }
RSSERAction >> execute [
	| canvas |
	canvas := self roassalCanvas.
	canvas shouldShowRectangles
		ifTrue:[ canvas hideEncompassingRectangles]
		ifFalse:[canvas showEncompassingRectangles ].
	canvas signalUpdate
]

{ #category : #hooks }
RSSERAction >> icon [
	^ self iconNamed: #smallDebug 
]

{ #category : #hooks }
RSSERAction >> title [
	^ 'Show or hide encompassing rectangles'
]

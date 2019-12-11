"
I have am useful to define the control points in a fast way, but if you plan to use this controller in many scenarios, try to create a new subclass of RSAbstractCPController and avoid this class
"
Class {
	#name : #RSBlockCPController,
	#superclass : #RSAbstractCPController,
	#instVars : [
		'block'
	],
	#category : #'Roassal3-Shapes-CP'
}

{ #category : #accessing }
RSBlockCPController >> block [
	^ block
]

{ #category : #accessing }
RSBlockCPController >> block: aBlockClosure [
	block := aBlockClosure
]

{ #category : #hooks }
RSBlockCPController >> controlPointsFor: anEdge [
	^ block cull: anEdge
]

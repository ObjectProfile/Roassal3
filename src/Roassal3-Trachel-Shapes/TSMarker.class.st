"
I represent a marker for TSLine, TSPolygon and TSBezier
"
Class {
	#name : #TSMarker,
	#superclass : #TSObject,
	#instVars : [
		'shape',
		'offset',
		'transition'
	],
	#category : #'Roassal3-Trachel-Shapes-Border'
}

{ #category : #converting }
TSMarker >> asMarker [
	^ self
]

{ #category : #initialization }
TSMarker >> initialize [
	super initialize.
	offset := 0.
	transition :=0.
]

{ #category : #accessing }
TSMarker >> offset [
	^ offset
]

{ #category : #accessing }
TSMarker >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
TSMarker >> shape [
	^ shape
]

{ #category : #accessing }
TSMarker >> shape: anObject [
	shape := anObject
]

{ #category : #accessing }
TSMarker >> transition [
	^ transition
]

{ #category : #accessing }
TSMarker >> transition: anObject [
	transition := anObject
]

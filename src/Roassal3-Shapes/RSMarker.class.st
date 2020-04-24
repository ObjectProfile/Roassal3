"
I represent a marker for RSLine, RSPolygon and RSBezier
"
Class {
	#name : #RSMarker,
	#superclass : #RSObject,
	#instVars : [
		'shape',
		'offset',
		'offsetRatio'
	],
	#category : #'Roassal3-Shapes-Border'
}

{ #category : #converting }
RSMarker >> asMarker [
	^ self
]

{ #category : #initialization }
RSMarker >> initialize [
	super initialize.
	offset := 0.
	offsetRatio :=0.
]

{ #category : #accessing }
RSMarker >> offset [
	^ offset
]

{ #category : #accessing }
RSMarker >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
RSMarker >> offsetRatio [
	^ offsetRatio
]

{ #category : #accessing }
RSMarker >> offsetRatio: aFloat [
	"[0 1] value"
	offsetRatio := aFloat
]

{ #category : #accessing }
RSMarker >> shape [
	^ shape
]

{ #category : #accessing }
RSMarker >> shape: anObject [
	shape := anObject
]

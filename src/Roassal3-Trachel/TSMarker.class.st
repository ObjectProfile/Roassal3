"
I represent a marker for TSLine, TSPolygon and TSBezier
"
Class {
	#name : #TSMarker,
	#superclass : #TSObject,
	#instVars : [
		'shape',
		'offset',
		'offsetRatio'
	],
	#category : #'Roassal3-Trachel-Border'
}

{ #category : #converting }
TSMarker >> asMarker [
	^ self
]

{ #category : #initialization }
TSMarker >> initialize [
	super initialize.
	offset := 0.
	offsetRatio :=0.
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
TSMarker >> offsetRatio [
	^ offsetRatio
]

{ #category : #accessing }
TSMarker >> offsetRatio: aFloat [
	"[0 1] value"
	offsetRatio := aFloat
]

{ #category : #accessing }
TSMarker >> shape [
	^ shape
]

{ #category : #accessing }
TSMarker >> shape: anObject [
	shape := anObject
]

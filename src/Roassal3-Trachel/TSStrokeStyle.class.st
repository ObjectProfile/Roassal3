"
I represent different styles for the stroke
"
Class {
	#name : #TSStrokeStyle,
	#superclass : #TSObject,
	#instVars : [
		'lineCap',
		'lineJoin',
		'dashArray',
		'dashOffset'
	],
	#category : #'Roassal3-Trachel-Border'
}

{ #category : #applying }
TSStrokeStyle >> applyOn: strokePaint [
	strokePaint 
		dashes: dashArray offset: dashOffset;
		perform: lineJoin;
		perform: lineCap.
	
]

{ #category : #accessing }
TSStrokeStyle >> dashArray [
	^ dashArray
]

{ #category : #accessing }
TSStrokeStyle >> dashArray: array [
	dashArray := array
]

{ #category : #accessing }
TSStrokeStyle >> dashOffset [
	^ dashOffset
]

{ #category : #accessing }
TSStrokeStyle >> dashOffset: aNumber [
	dashOffset := aNumber
]

{ #category : #accessing }
TSStrokeStyle >> lineCap [
	^ lineCap
]

{ #category : #accessing }
TSStrokeStyle >> lineCap: selector [
	lineCap := selector
]

{ #category : #accessing }
TSStrokeStyle >> lineJoin [
	^ lineJoin 
]

{ #category : #accessing }
TSStrokeStyle >> lineJoin: selector [
	lineJoin := selector
]

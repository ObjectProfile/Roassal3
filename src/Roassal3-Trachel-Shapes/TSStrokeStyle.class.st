"
I represent different styles for the stroke
"
Class {
	#name : #TSStrokeStyle,
	#superclass : #TSObject,
	#instVars : [
		'capStyle',
		'joinStyle',
		'dashArray',
		'dashOffset'
	],
	#category : #'Roassal3-Trachel-Shapes-Border'
}

{ #category : #accessing }
TSStrokeStyle >> capStyle [
	^ capStyle
]

{ #category : #accessing }
TSStrokeStyle >> capStyle: symbol [
	capStyle := symbol
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

{ #category : #initialization }
TSStrokeStyle >> initialize [
	super initialize.
	dashOffset := 0
]

{ #category : #accessing }
TSStrokeStyle >> joinStyle [
	^ joinStyle
]

{ #category : #accessing }
TSStrokeStyle >> joinStyle: symbol [
	joinStyle := symbol
]

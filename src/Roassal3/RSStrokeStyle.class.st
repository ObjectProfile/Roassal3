"
I represent different styles for the stroke
"
Class {
	#name : #RSStrokeStyle,
	#superclass : #RSObject,
	#instVars : [
		'capStyle',
		'joinStyle',
		'dashArray',
		'dashOffset'
	],
	#category : #'Roassal3-Border'
}

{ #category : #accessing }
RSStrokeStyle >> capStyle [
	^ capStyle
]

{ #category : #accessing }
RSStrokeStyle >> capStyle: symbol [
	capStyle := symbol
]

{ #category : #accessing }
RSStrokeStyle >> dashArray [
	^ dashArray
]

{ #category : #accessing }
RSStrokeStyle >> dashArray: array [
	self assert: array isArray description: 'enter an array of numbers'.
	dashArray := array
]

{ #category : #accessing }
RSStrokeStyle >> dashOffset [
	^ dashOffset
]

{ #category : #accessing }
RSStrokeStyle >> dashOffset: aNumber [
	dashOffset := aNumber
]

{ #category : #initialization }
RSStrokeStyle >> initialize [
	super initialize.
	dashOffset := 0
]

{ #category : #accessing }
RSStrokeStyle >> joinStyle [
	^ joinStyle
]

{ #category : #accessing }
RSStrokeStyle >> joinStyle: symbol [
	joinStyle := symbol
]

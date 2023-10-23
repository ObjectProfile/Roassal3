"
I represent different styles for the stroke
"
Class {
	#name : 'RSStrokeStyle',
	#superclass : 'RSObject',
	#instVars : [
		'capStyle',
		'joinStyle',
		'dashArray',
		'dashOffset'
	],
	#category : 'Roassal-Shapes-Border',
	#package : 'Roassal-Shapes',
	#tag : 'Border'
}

{ #category : 'instance creation' }
RSStrokeStyle class >> fromString: aString [
	| inst |
	inst := self new.
	(aString includesSubstring: '--')
		ifTrue: [ ^ inst dashArray: #(4 2) ].
	(aString includesSubstring: '-.')
		ifTrue: [ ^ inst dashArray: #(4 1 1 1) ].
	(aString includesSubstring: '.')
		ifTrue: [ ^ inst dashArray: #(1) ].

	^ nil
]

{ #category : 'comparing' }
RSStrokeStyle >> = anObject [
	^ self == anObject or: [
		anObject notNil and: [
			capStyle = anObject capStyle and: [
				joinStyle = anObject joinStyle and: [
					dashOffset = anObject dashOffset and: [
						dashArray = anObject dashArray ] ] ] ] ]
]

{ #category : 'accessing' }
RSStrokeStyle >> capStyle [
	^ capStyle
]

{ #category : 'accessing' }
RSStrokeStyle >> capStyle: symbol [
	capStyle := symbol
]

{ #category : 'accessing' }
RSStrokeStyle >> dashArray [
	^ dashArray
]

{ #category : 'accessing' }
RSStrokeStyle >> dashArray: array [
	self assert: array isArray description: 'enter an array of numbers'.
	dashArray := array
]

{ #category : 'accessing' }
RSStrokeStyle >> dashOffset [
	^ dashOffset
]

{ #category : 'accessing' }
RSStrokeStyle >> dashOffset: aNumber [
	dashOffset := aNumber
]

{ #category : 'comparing' }
RSStrokeStyle >> hash [
	^ ((capStyle hash hashMultiply + joinStyle hash) hashMultiply +
	  (dashOffset hash hashMultiply + dashArray hash)) hashMultiply
]

{ #category : 'initialization' }
RSStrokeStyle >> initialize [
	super initialize.
	dashOffset := 0
]

{ #category : 'accessing' }
RSStrokeStyle >> joinStyle [
	^ joinStyle
]

{ #category : 'accessing' }
RSStrokeStyle >> joinStyle: symbol [
	joinStyle := symbol
]

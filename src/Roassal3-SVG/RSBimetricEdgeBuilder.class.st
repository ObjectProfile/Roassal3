"
I am an edge builder for bimetric lines
"
Class {
	#name : #RSBimetricEdgeBuilder,
	#superclass : #RSLineBuilder,
	#instVars : [
		'widthFrom',
		'widthTo'
	],
	#category : #'Roassal3-SVG-Edges'
}

{ #category : #'private - utility' }
RSBimetricEdgeBuilder >> edgeFrom: source to: target [
	| edge |
	edge := super edgeFrom: source to: target.
	edge
		widthFrom: (widthFrom rsValue: edge model);
		widthTo: (widthTo rsValue: edge model).
	^ edge
]

{ #category : #accessing }
RSBimetricEdgeBuilder >> widthFrom [
	^ widthFrom
]

{ #category : #accessing }
RSBimetricEdgeBuilder >> widthFrom: anObject [
	widthFrom := anObject
]

{ #category : #accessing }
RSBimetricEdgeBuilder >> widthTo [
	^ widthTo
]

{ #category : #accessing }
RSBimetricEdgeBuilder >> widthTo: anObject [
	widthTo := anObject
]

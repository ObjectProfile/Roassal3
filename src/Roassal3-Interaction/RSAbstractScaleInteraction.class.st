"
I define accessors for min and max scale value for some scale interactions
"
Class {
	#name : #RSAbstractScaleInteraction,
	#superclass : #TSInteraction,
	#instVars : [
		'minScale',
		'maxScale'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
RSAbstractScaleInteraction >> initialize [
	super initialize.
	self 
		minScale: 0.1;
		maxScale: 3.
]

{ #category : #accessing }
RSAbstractScaleInteraction >> maxScale [
	^ maxScale
]

{ #category : #accessing }
RSAbstractScaleInteraction >> maxScale: anObject [
	maxScale := anObject
]

{ #category : #accessing }
RSAbstractScaleInteraction >> minScale [
	^ minScale
]

{ #category : #accessing }
RSAbstractScaleInteraction >> minScale: anObject [
	minScale := anObject
]

{ #category : #accessing }
RSAbstractScaleInteraction >> scaleFor: anEvent [
	| delta |
	delta := 1 / anEvent newScale.
	^ (maxScale min: delta ) max: minScale.
]

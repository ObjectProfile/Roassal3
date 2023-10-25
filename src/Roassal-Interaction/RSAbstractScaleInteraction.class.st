"
I define accessors for min and max scale value for some scale interactions
"
Class {
	#name : 'RSAbstractScaleInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'minScale',
		'maxScale'
	],
	#category : 'Roassal-Interaction-Extra',
	#package : 'Roassal-Interaction',
	#tag : 'Extra'
}

{ #category : 'initialization' }
RSAbstractScaleInteraction >> initialize [
	super initialize.
	self
		minScale: 0.1;
		maxScale: 3
]

{ #category : 'accessing' }
RSAbstractScaleInteraction >> maxScale [
	^ maxScale
]

{ #category : 'accessing' }
RSAbstractScaleInteraction >> maxScale: aNumber [
	maxScale := aNumber
]

{ #category : 'accessing' }
RSAbstractScaleInteraction >> minScale [
	^ minScale
]

{ #category : 'accessing' }
RSAbstractScaleInteraction >> minScale: aNumber [
	minScale := aNumber
]

{ #category : 'accessing' }
RSAbstractScaleInteraction >> scaleFor: anEvent [
	| delta |
	delta := 1 / anEvent newScale.
	^ (maxScale min: delta ) max: minScale
]

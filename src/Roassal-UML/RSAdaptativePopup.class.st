"
This class is used to modify the popup behavior in Roassal3-UML

When classes in canvas are too small it will try to show the the entire class scaled to fit in the canvas. if not it will display the name in a box
"
Class {
	#name : #RSAdaptativePopup,
	#superclass : #RSObject,
	#instVars : [
		'smallBuilder',
		'bigBuilder'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #accessing }
RSAdaptativePopup >> bigBuilder: aRSBuilder [
	bigBuilder := aRSBuilder
]

{ #category : #hooks }
RSAdaptativePopup >> bigShapeFor: aRSShape [
	| popup |
	popup := bigBuilder shapeFor: aRSShape model.
	popup removeInteractionIfPresent: RSPopup.
	^ popup
]

{ #category : #testing }
RSAdaptativePopup >> isShapeWillVisibleInCanvas: aRSShape [
	^ aRSShape canvas camera scale > 0.4
]

{ #category : #hooks }
RSAdaptativePopup >> shapeFor: aRSShape [
	^ (self isShapeWillVisibleInCanvas: aRSShape)
		ifTrue: [ self smallShapeFor: aRSShape ]
		ifFalse: [ self bigShapeFor: aRSShape ]
]

{ #category : #accessing }
RSAdaptativePopup >> smallBuilder: aRSSimplePopupBuilder [
	smallBuilder := aRSSimplePopupBuilder
]

{ #category : #hooks }
RSAdaptativePopup >> smallShapeFor: aRSShape [
	^ smallBuilder shapeFor: aRSShape model
]

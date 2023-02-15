"
A field editor for angles in degrees
"
Class {
	#name : #RSLayoutAngleField,
	#superclass : #RSLayoutNumberField,
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #accessing }
RSLayoutAngleField >> label: anObject [
	super label: anObject , ' (in degrees)'
]

{ #category : #accessing }
RSLayoutAngleField >> layoutValue [
	^ super layoutValue radiansToDegrees
]

{ #category : #accessing }
RSLayoutAngleField >> layoutValue: anObject [
	^ super layoutValue: anObject degreesToRadians
]

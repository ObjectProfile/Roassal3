"
A field editor for angles in degrees
"
Class {
	#name : 'RSLayoutAngleField',
	#superclass : 'RSLayoutNumberField',
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'accessing' }
RSLayoutAngleField >> label: anObject [
	super label: anObject , ' (in degrees)'
]

{ #category : 'accessing' }
RSLayoutAngleField >> layoutValue [
	^ super layoutValue radiansToDegrees
]

{ #category : 'accessing' }
RSLayoutAngleField >> layoutValue: aNumber [
	^ super layoutValue: aNumber degreesToRadians
]

"
TODO
"
Class {
	#name : #RSQuadTreeForce,
	#superclass : #RSQuadTree,
	#instVars : [
		'charge',
		'centerOfCharge'
	],
	#category : #'Roassal-Layouts-Util'
}

{ #category : #accessing }
RSQuadTreeForce >> centerOfCharge [
	^ centerOfCharge
]

{ #category : #accessing }
RSQuadTreeForce >> centerOfCharge: aPoint [
	centerOfCharge := aPoint
]

{ #category : #accessing }
RSQuadTreeForce >> charge [
	^ charge
]

{ #category : #accessing }
RSQuadTreeForce >> charge: anObject [
	charge := anObject
]

"
You can combine different attach points
"
Class {
	#name : #RSStartEndAttachPoint,
	#superclass : #RSAttachPoint,
	#instVars : [
		'startAttachPoint',
		'endAttachPoint'
	],
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSStartEndAttachPoint >> basicEndingPointOf: anEdge [

	^ endAttachPoint basicEndingPointOf: anEdge
]

{ #category : #'public - hooks' }
RSStartEndAttachPoint >> basicStartingPointOf: anEdge [

	^ startAttachPoint basicStartingPointOf: anEdge
]

{ #category : #accessing }
RSStartEndAttachPoint >> endAttachPoint [

	^ endAttachPoint
]

{ #category : #accessing }
RSStartEndAttachPoint >> endAttachPoint: anObject [

	endAttachPoint := anObject
]

{ #category : #accessing }
RSStartEndAttachPoint >> startAttachPoint [

	^ startAttachPoint
]

{ #category : #accessing }
RSStartEndAttachPoint >> startAttachPoint: anObject [

	startAttachPoint := anObject
]

Class {
	#name : #RSStartEndCPAPController,
	#superclass : #RSAbstractCPAPController,
	#instVars : [
		'startAttachPoint',
		'endAttachPoint',
		'controller'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #hooks }
RSStartEndCPAPController >> controlPointsFor: anEdge [

	| ap sp ep |
	ap := anEdge attachPoint.
	sp := startAttachPoint ifNil: [ ap ].
	ep := endAttachPoint ifNil: [ ap ].
	^ self
		  controlPointsFrom: (sp startingPointOf: anEdge)
		  to: (ep endingPointOf: anEdge)
]

{ #category : #hooks }
RSStartEndCPAPController >> controlPointsFrom: fromPoint to: toPoint [

	^ controller controlPointsFrom: fromPoint to: toPoint
]

{ #category : #accessing }
RSStartEndCPAPController >> controller: aCPAPController [

	controller := aCPAPController
]

{ #category : #accessing }
RSStartEndCPAPController >> endAttachPoint: anAttachPoint [

	endAttachPoint := anAttachPoint
]

{ #category : #accessing }
RSStartEndCPAPController >> startAttachPoint: anAttachPoint [

	startAttachPoint := anAttachPoint
]

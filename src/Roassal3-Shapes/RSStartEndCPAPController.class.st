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
RSStartEndCPAPController >> controlPointsFor: aLine [

	| ap sp ep |
	ap := aLine attachPoint.
	sp := startAttachPoint ifNil: [ ap ].
	ep := endAttachPoint ifNil: [ ap ].
	^ self
		  controlPointsFrom: (sp startingPointOf: aLine)
		  to: (ep endingPointOf: aLine)
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

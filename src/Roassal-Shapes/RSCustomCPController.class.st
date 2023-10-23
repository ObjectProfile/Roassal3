"
I am a custom control points controller to define crazy things with controls points.
I am more like an example and not for applications
"
Class {
	#name : 'RSCustomCPController',
	#superclass : 'RSAbstractCPController',
	#instVars : [
		'models'
	],
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'hooks' }
RSCustomCPController >> controlPointFor: model at: aLine [
	| point |
	model isPoint ifTrue: [ ^ model ].
	point  := model value.
	(model isKindOf: RSShape) ifTrue: [
		model addConnectedLine: aLine.
		point := model position ].
	^ point
]

{ #category : 'hooks' }
RSCustomCPController >> controlPointsFor: aLine [
	^ self models collect: [ :m | self controlPointFor: m at: aLine ]
]

{ #category : 'accessing' }
RSCustomCPController >> models [
	^ models
]

{ #category : 'accessing' }
RSCustomCPController >> models: aCollection [
	models := aCollection
]

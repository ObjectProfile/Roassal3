"
TODO
"
Class {
	#name : #TSPolyline,
	#superclass : #TSAbstractControPointsLine,
	#instVars : [
		'markers'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSPolyline >> buildPathOn: visitor [
	visitor buildPolyinePath: self
]

{ #category : #'accessing - markers' }
TSPolyline >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #'accessing - markers' }
TSPolyline >> privateMarkers [
	^ markers
]

"
TSLine describes a line.
"
Class {
	#name : #TSLine,
	#superclass : #TSAbstractDualLine,
	#instVars : [
		'markers'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]

{ #category : #accessing }
TSLine >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #accessing }
TSLine >> privateMarkers [
	^ markers
]

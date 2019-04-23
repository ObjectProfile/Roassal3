"
TODO
"
Class {
	#name : #TSPolyline,
	#superclass : #TSAbstractControlPointsLine,
	#instVars : [
		'markers',
		'radius'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSPolyline >> buildPathOn: visitor [
	visitor buildPolyinePath: self
]

{ #category : #accessing }
TSPolyline >> cornerRadii [
	^ radius ifNil: [ 0 ].
]

{ #category : #accessing }
TSPolyline >> cornerRadii: aNumber [
	radius := aNumber abs
]

{ #category : #'accessing - markers' }
TSPolyline >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #'accessing - markers' }
TSPolyline >> privateMarkers [
	^ markers
]

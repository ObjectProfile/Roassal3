"
TODO
"
Class {
	#name : #TSPolyline,
	#superclass : #TSAbstractControPointsLine,
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSPolyline >> buildPathOn: visitor [
	visitor buildPolyinePath: self
]

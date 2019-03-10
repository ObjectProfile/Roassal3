"
TSLine describes a line.
"
Class {
	#name : #TSLine,
	#superclass : #TSAbstractDualLine,
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]

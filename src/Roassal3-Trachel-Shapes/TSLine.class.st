"
TSLine describes a line.
"
Class {
	#name : #TSLine,
	#superclass : #TSAbstractLine,
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSLine >> pathFor: visitor [
	^ visitor pathOfLine: self.
]

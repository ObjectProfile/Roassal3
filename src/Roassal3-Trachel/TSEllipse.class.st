"
I am an ellipse shape
"
Class {
	#name : #TSEllipse,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSEllipse >> pathFor: visitor [
	^ visitor pathOfEllipse: self
]

{ #category : #'as yet unclassified' }
TSEllipse >> radius: integer [
	self extent: integer * 2 asPoint
]

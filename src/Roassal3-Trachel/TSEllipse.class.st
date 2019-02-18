"
I am an ellipse shape
"
Class {
	#name : #TSEllipse,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSEllipse >> accept: visitor [
	visitor visitEllipse: self
]

{ #category : #'as yet unclassified' }
TSEllipse >> radius: integer [
	self extent: integer * 2 asPoint
]

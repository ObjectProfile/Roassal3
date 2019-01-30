Class {
	#name : #TSBox,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel'
}

{ #category : #visiting }
TSBox >> accept: visitor [
	visitor visitBox: self
]

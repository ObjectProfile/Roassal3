Class {
	#name : #RSNote,
	#superclass : #RSBoundingShape,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSNote >> buildPathOn: visitor [

	visitor buildNotePath: self
]

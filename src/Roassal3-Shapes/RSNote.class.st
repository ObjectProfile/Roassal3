Class {
	#name : #RSNote,
	#superclass : #RSBox,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSNote >> buildPathOn: visitor [

	visitor buildNotePath: self
]

Class {
	#name : #RSSimplerNote,
	#superclass : #RSBox,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSSimplerNote >> buildPathOn: visitor [

	visitor buildSimplerNotePath: self
]

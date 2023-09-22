Class {
	#name : 'RSNote',
	#superclass : 'RSBox',
	#category : 'Roassal3-Shapes-Bounding',
	#package : 'Roassal3-Shapes',
	#tag : 'Bounding'
}

{ #category : 'visiting' }
RSNote >> buildPathOn: visitor [

	visitor buildNotePath: self
]

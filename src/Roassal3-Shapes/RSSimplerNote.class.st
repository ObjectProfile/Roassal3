Class {
	#name : 'RSSimplerNote',
	#superclass : 'RSBox',
	#category : 'Roassal3-Shapes-Bounding',
	#package : 'Roassal3-Shapes',
	#tag : 'Bounding'
}

{ #category : 'visiting' }
RSSimplerNote >> buildPathOn: visitor [

	visitor buildSimplerNotePath: self
]

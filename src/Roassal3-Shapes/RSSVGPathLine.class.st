"
I represent path a complex line from one point to another with an svg path
"
Class {
	#name : #RSSVGPathLine,
	#superclass : #RSAbstractDualLine,
	#instVars : [
		'svgPath'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #visiting }
RSSVGPathLine >> buildPathOn: visitor [
	visitor buildSVGLinePath: self.
]

{ #category : #accessing }
RSSVGPathLine >> color [
	^ self paint
]

{ #category : #accessing }
RSSVGPathLine >> color: aColor [
	self paint: aColor
]

{ #category : #accessing }
RSSVGPathLine >> svgPath [
	^svgPath
]

{ #category : #accessing }
RSSVGPathLine >> svgPath: aBlock [
	"aBlock return a string and recives 2 arguments, the start point and the end point"
	svgPath := aBlock 
	
]

"
I represent path a complex line from one point to another with an svg path
"
Class {
	#name : #TSSVGPathLine,
	#superclass : #TSAbstractDualLine,
	#instVars : [
		'svgPath'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #visiting }
TSSVGPathLine >> buildPathOn: visitor [
	visitor buildSVGLinePath: self.
]

{ #category : #accessing }
TSSVGPathLine >> color [
	^ self paint
]

{ #category : #accessing }
TSSVGPathLine >> color: aColor [
	self paint: aColor
]

{ #category : #accessing }
TSSVGPathLine >> svgPath [
	^svgPath
]

{ #category : #accessing }
TSSVGPathLine >> svgPath: aBlock [
	"aBlock return a string and recives 2 arguments, the start point and the end point"
	svgPath := aBlock 
	
]

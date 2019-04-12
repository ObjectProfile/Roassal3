"
I represent path a complex line from one point to another with an svg path
"
Class {
	#name : #TSSVGPathLine,
	#superclass : #TSAbstractDualLine,
	#instVars : [
		'svgPath'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSSVGPathLine >> buildPathOn: visitor [
	visitor buildSVGLinePath: self.
]

{ #category : #accessing }
TSSVGPathLine >> svgPath [
	^svgPath
]

{ #category : #accessing }
TSSVGPathLine >> svgPath: aBlock [
	"aBlock return a string and recives 2 arguments"
	svgPath := aBlock 
	
]

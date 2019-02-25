"
I represent path a complex line from one point to another with an svg path
"
Class {
	#name : #TSSVGPathLine,
	#superclass : #TSAbstractLine,
	#instVars : [
		'svgPath'
	],
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSSVGPathLine >> pathFor: visitor [
	^ visitor pathOfSVGPathLine: self.
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

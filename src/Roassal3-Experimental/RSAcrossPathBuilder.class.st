"
This class provides a simple way do push a group of shapes across a given path
"
Class {
	#name : #RSAcrossPathBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'shapesToLayout',
		'svgShape'
	],
	#category : #'Roassal3-Experimental-AcrossPath'
}

{ #category : #examples }
RSAcrossPathBuilder >> example01Labels [
	<script: 'self new example01Labels open'>
	| path |
	self fromString: 'Roassal3 across the path'.
	path := 'M 100 200 
             C 200 100 300   0 400 100
             C 500 200 600 300 700 200
             C 800 100 900 100 900 100'.
	path := 'M10,90 Q90,90 90,45 Q90,10 50,10 Q10,10 10,40 Q10,70 45,70 Q70,70 75,50'.
	self svgShape: (RSSVGPath new
		svgPath: 'M0 0 L -100 -100';
		border: (RSBorder new width: 3; color: 'blue');
		yourself).
	self build.
	self canvas zoomToFit.
	^ self canvas
]

{ #category : #public }
RSAcrossPathBuilder >> fromString: aString [ 
	| groupOfShapes |
	groupOfShapes := aString collect: [ :char | self labelShapeFor: char ] as: RSGroup.
	self shapesToLayout: groupOfShapes
]

{ #category : #public }
RSAcrossPathBuilder >> labelShapeFor: char [
	^ char isSpaceSeparator 
		ifTrue: [ 
			RSBox new
				size: 7;
				noPaint;
				yourself ]
		ifFalse: [
			RSLabel new
				text: char; 
				metricsProvider: RSPharoMetricsProvider new;
				yourself.
			]
]

{ #category : #hooks }
RSAcrossPathBuilder >> renderIn: aCanvas [
	| visitor |
	aCanvas addAll: shapesToLayout.
	aCanvas add: svgShape.
	visitor := RSBlockSegmentsVisitor new
		simplePoints: [ :segment :current |
			segment consumeShapes: (RSGroup withAll: shapesToLayout) current: current
			 ].
	svgShape accept: visitor.
]

{ #category : #accessing }
RSAcrossPathBuilder >> shapesToLayout [
	^ shapesToLayout
]

{ #category : #accessing }
RSAcrossPathBuilder >> shapesToLayout: aGroupOfShapes [
	shapesToLayout := aGroupOfShapes
]

{ #category : #accessing }
RSAcrossPathBuilder >> svgShape [
	^ svgShape
]

{ #category : #accessing }
RSAcrossPathBuilder >> svgShape: aRSSVGPath [
	svgShape := aRSSVGPath
]

Class {
	#name : #RSPLinesTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'shapeClass',
		'canvas'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #'building suites' }
RSPLinesTest class >> testParameters [
	| m classesToConsider |
	m := ParametrizedTestMatrix new.
	classesToConsider := RSAbstractLine allSubclasses select: [ :c | c isAbstract not ].
	classesToConsider do: [ :cls | 
		m addCase: { (#shapeClass -> cls) }
	].
	^ m 
	
]

{ #category : #running }
RSPLinesTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #accessing }
RSPLinesTest >> shapeClass [
	^ shapeClass
]

{ #category : #accessing }
RSPLinesTest >> shapeClass: aClass [
	"It is expected to have a subclass of RSAbstractLine"
	shapeClass := aClass
]

{ #category : #tests }
RSPLinesTest >> testDraw [

	canvas addShape: (self shapeClass new
		strokeColor: Color red;
		width: 2). 
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSPLinesTest >> testDrawMarkers [
	| line m |
	m := RSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	line := self shapeClass new
		startPoint: 50@50;
		endPoint: 250@50.
	line markerStart: m.
	canvas addShape: line.
	canvas createMorph drawOnMockCanvas.
]

"
Test for all the lines of trachel
"
Class {
	#name : #RSLinesTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSLinesTest >> setUp [
	canvas := RSCanvas new
]

{ #category : #'tests - colors' }
RSLinesTest >> testColorLineAndMarker [
	| line |
	line := RSShapeFactory arrowedLine.
	line color: Color blue.
	self 
		assert: line color equals: Color blue;
		assert: line markerEnd shape borderColor equals: Color blue.
]

{ #category : #running }
RSLinesTest >> testDrawBezierLine [
	canvas addShape: (RSBezier new
		strokeColor: Color red;
		width: 2). 
	canvas createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testDrawLine [
	canvas addShape: (RSLine new
		strokeColor: Color red;
		width: 2). 
	canvas createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testDrawMarkers [
	| line m |
	m := RSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	line := RSLine new
		startPoint: 50@50;
		endPoint: 250@50.
	line markerStart: m.
	canvas addShape: line.
	canvas createMorph drawOnMockCanvas.
]

{ #category : #running }
RSLinesTest >> testLineIncludesPoint [
	| line |
	line := RSLine new
		startPoint: 0@0;
		endPoint: 0@100;
		width: 8;
		yourself.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 4@50).
	self deny: (line includesPoint: 5@50).
	self deny: (line includesPoint: 500@500).

]

{ #category : #running }
RSLinesTest >> testPolylineIncludesPoint [
	| line |
	line := RSPolyline new.
	line width: 10.
	line controlPoints: { 0@0. 0@100 }.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 0@100).
	self assert: (line includesPoint: 0@50).
	self assert: (line includesPoint: 5@50).
	
	self deny: (line includesPoint: 500@500).
	self deny: (line includesPoint: 6@50).
]

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
	super setUp.
	canvas := RSCanvas new
]

{ #category : #running }
RSLinesTest >> testArrowedLine [
	| line head other |
	line := RSArrowedLine new.
	line startPoint: 0@0; endPoint: 100@100.
	head := line markerEnd.
	self assert: head isNotNil.
	
	head := head shape.
	self assert: head class equals: RSPolygon.
	line color: Color blue.
	self assert: line color equals: Color blue.
	self assert: head border color equals: Color blue.
	
	line border: (RSBorder new width: 2; color: Color red).
	self assert: line border width equals: 2.
	self assert: line color equals: Color red.
	self assert: head border width equals: 2.
	self assert: line color equals: Color red.
	
	other := line copy.
	self deny: other equals: line.
	self deny: other markerEnd hash equals: line markerEnd hash.
	
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
RSLinesTest >> testMarkersIncludesPoint [
	| line marker |
	line := RSLine new
		startPoint: 0@ 0;
		endPoint: 200@0;
		yourself.
	marker := RSBox new
		size: 20;
		asMarker.
	self assert: (line includesPoint: 0@0).
	self assert: (line includesPoint: 100@0).
	self assert: (line includesPoint: 200@0).
	self deny: (line includesPoint: 210@0).
	self deny: (line includesPoint: 210@10).
	self deny: (line includesPoint: 210@ -10).
	line markerEnd: marker.
	self assert: (line includesPoint: 210@0).
	self assert: (line includesPoint: 200@9).
	self assert: (line includesPoint: 210@ -10).
	self deny: (line includesPoint: 210@ -11).
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

"
Test for all shapes with a matrix an one encompassing rectangle
"
Class {
	#name : #RSBoundingTest,
	#superclass : #RSCanvasTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSBoundingTest >> testDrawBitamp [
	c addShape: (RSBitmap new
		form: (ColorForm extent: 100@100 depth: 32)).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSBoundingTest >> testDrawBorder [
	c addShape: (RSEllipse new
		radius: 100;
		withBorder;
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSBoundingTest >> testDrawBoxCornerRadius [
	c addShape: (RSBox new
		extent: 100@100;
		cornerRadius: 5;
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSBoundingTest >> testDrawPolygon [
	c addShape: (RSPolygon new).
	c addShape: (RSPolygon new
		points: { 200@10. 250@190. 160@210 };
		yourself).
	c addShape: (RSPolygon new
		cornerRadii: 20;
		points: { 200@10. 250@190. 160@210 };
		yourself).
	self assert: c shapes second points equals: {(-5@ -100). (45@80). (-45@100)}.
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSBoundingTest >> testDrawRing [
	| r |
	r := RSPieSlice new.
	"empty"
	c addShape: r.
	"circle"
	c addShape: (RSPieSlice new
		innerRadius: 0;
		externalRadius: 100;
		alphaAngle: 0;
		betaAngle: 360).
	"slice"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		alphaAngle: 30;
		betaAngle: 90;
		segmentSpacing: 5).
	"donut"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 360).
	"corner radii"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 45;
		cornerRadii: 20).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSBoundingTest >> testDrawSVG [
	c addShape: (RSSVGPath new).
	c addShape: (RSSVGPath new
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSBoundingTest >> testHasChildren [
	| b |
	b := RSBox new.
	self deny: b hasChildren.
	b := RSEllipse new.
	self deny: b hasChildren
]

{ #category : #tests }
RSBoundingTest >> testPosition [
	| b |
	b := RSBox new.
	self assert: b position equals: 0@0.
	b position: 0@0.
]

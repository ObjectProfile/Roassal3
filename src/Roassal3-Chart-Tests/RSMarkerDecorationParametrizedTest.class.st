"
A RSXLabelDecorationTest is a test class for testing the behavior of RSXLabelDecoration
"
Class {
	#name : #RSMarkerDecorationParametrizedTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'marker'
	],
	#category : #'Roassal3-Chart-Tests-Decoration'
}

{ #category : #'building suites' }
RSMarkerDecorationParametrizedTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  addCase: { (#marker -> RSXMarkerDecoration new) };
		  addCase: { (#marker -> RSYMarkerDecoration new) };
		  yourself
]

{ #category : #tests }
RSMarkerDecorationParametrizedTest >> marker: aMarkerDecoration [

	marker := aMarkerDecoration
]

{ #category : #tests }
RSMarkerDecorationParametrizedTest >> testColor [

	marker color: Color blue.
	self assert: marker color equals: Color blue
]

{ #category : #tests }
RSMarkerDecorationParametrizedTest >> testMarker [

	| aMarker |
	aMarker := RSBox new
		           size: 5;
		           asMarker.
	marker marker: aMarker.
	self assert: marker shape markers first equals: aMarker
]

{ #category : #tests }
RSMarkerDecorationParametrizedTest >> testWidth [

	marker width: 18.
	self assert: marker width equals: 18
]

"
A RSXLabelDecorationTest is a test class for testing the behavior of RSXLabelDecoration
"
Class {
	#name : 'RSMarkerDecorationParametrizedTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'decoration'
	],
	#category : 'Roassal-Chart-Tests-Decoration',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Decoration'
}

{ #category : 'building suites' }
RSMarkerDecorationParametrizedTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  addCase: { (#decoration -> RSXMarkerDecoration new) };
		  addCase: { (#decoration -> RSYMarkerDecoration new) };
		  addCase: { (#decoration -> RSLineSpineDecoration new) };
		  yourself
]

{ #category : 'tests' }
RSMarkerDecorationParametrizedTest >> decoration: aMarkerDecoration [

	decoration := aMarkerDecoration
]

{ #category : 'tests' }
RSMarkerDecorationParametrizedTest >> testBorder [

	| border |
	border := RSBorder new
		          width: 4;
		          color: Color black;
		          yourself.
	decoration border: border.
	self assert: decoration border equals: border
]

{ #category : 'tests' }
RSMarkerDecorationParametrizedTest >> testColor [

	decoration color: Color blue.
	self assert: decoration color equals: Color blue
]

{ #category : 'tests' }
RSMarkerDecorationParametrizedTest >> testMarker [

	| aMarker |
	aMarker := RSBox new
		           size: 5;
		           asMarker.
	decoration marker: aMarker.
	self assert: decoration shape markers first equals: aMarker
]

{ #category : 'tests' }
RSMarkerDecorationParametrizedTest >> testWidth [

	decoration width: 18.
	self assert: decoration width equals: 18
]

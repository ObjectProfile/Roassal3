"
A RSKiviatTest is a test class for testing the behavior of RSKiviat
"
Class {
	#name : 'RSKiviatTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Radar',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Radar'
}

{ #category : 'tests' }
RSKiviatTest >> testAccessingCreatedShapes [
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 2 3).
	kiviat axisNames: #(a b c).
	kiviat build.
	self assert: (kiviat labels collect: #text) asArray equals: #(a b c).
	self assert: (kiviat axis allSatisfy: [:shape | shape class = RSLine ]).
	self assert: (kiviat backgroundShapes  allSatisfy: [ :shape | shape class = RSEllipse ]).
	self assert: kiviat polygonShapes size equals: 1.
	self assert: (kiviat polygonShapes allSatisfy: [ :shape | shape class = RSPolygon ]).

	self assert: kiviat shapes isNotNil.
	self
		assert: kiviat shapes size
		equals: (#(backgroundShapes axis labels polygonShapes)
			collect: [ :selector | (kiviat perform: selector) size ]) sum
]

{ #category : 'tests' }
RSKiviatTest >> testBasic [
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 2 3).
	kiviat axisNames: #(a b c).
	self assert: kiviat shouldUseEllipse.
	self assert: kiviat radius equals: 200.
	self deny: kiviat shouldUsePolygonBorder.
	self assert: kiviat shouldUsePolygonFillColor.
	self deny: kiviat shouldUseDots
]

{ #category : 'tests' }
RSKiviatTest >> testMaxMinValues [
	| kiviat |
	"one value"
	kiviat := RSKiviat new.
	kiviat addRow: #(1 2 3).
	kiviat axisNames: #(a b c).
	kiviat minValue: 1.
	kiviat maxValue: 5.
	kiviat build
]

{ #category : 'tests' }
RSKiviatTest >> testOddCollectionSize [
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 2 3).
	kiviat axisNames: #(a).
	self should: [ kiviat build ] raise: Error
]

{ #category : 'tests' }
RSKiviatTest >> testZeroValues [
	| kiviat |
	"one value"
	kiviat := RSKiviat new.
	kiviat addRow: #(1).
	kiviat axisNames: #(a).
	kiviat build.
	"zero values"
	kiviat := RSKiviat new.
	kiviat addRow: #().
	kiviat axisNames: #().
	kiviat build.

	kiviat := RSKiviat new.
	"use addRow: first"
	self should: [ kiviat build ] raise: Error
]

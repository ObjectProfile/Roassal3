"
A RSSunburstBuilderTest is a test class for testing the behavior of RSSunburstBuilder
"
Class {
	#name : 'RSSunburstBuilderTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Examples',
	#package : 'Roassal-Global-Tests',
	#tag : 'Examples'
}

{ #category : 'tests' }
RSSunburstBuilderTest >> testBasic [
	| segment1 segment2 line attachPoint startPoint endPoint |
	segment1 := RSPieSlice new
		innerRadius: 0;
		externalRadius: 100;
		alphaAngle: 0;
		betaAngle: 360;
		yourself.
	segment2 := RSPieSlice new
		innerRadius: 100;
		externalRadius: 150;
		alphaAngle: -45;
		betaAngle: 45;
		yourself.

	line := RSLine new
		from: segment1;
		to: segment2;
		yourself.
	attachPoint := RSSunburstAttachPoint new.
	startPoint := attachPoint basicStartingPointOf: line.
	endPoint := attachPoint basicEndingPointOf: line.
	self assert: startPoint closeTo: 0@0.
	self assert: endPoint closeTo: 125@0
]

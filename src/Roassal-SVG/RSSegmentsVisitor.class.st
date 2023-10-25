"
This class iterates over a RSSVGPath path segments
"
Class {
	#name : 'RSSegmentsVisitor',
	#superclass : 'RSObject',
	#category : 'Roassal-SVG-Segments',
	#package : 'Roassal-SVG',
	#tag : 'Segments'
}

{ #category : 'visiting' }
RSSegmentsVisitor >> visitBoundingShape: aRSSVGPath [
	| b segment |
	b := AthensSimplePathBuilder new.
	aRSSVGPath segments do: [ :each |
		b perform: each first withArguments: each second ].
	segment := b pathStart.
	[ segment notNil ] whileTrue: [
		segment visitWith: self.
		segment := segment next ]
]

{ #category : 'visiting' }
RSSegmentsVisitor >> visitCloseSegment: aSegment [
]

{ #category : 'visiting' }
RSSegmentsVisitor >> visitCubicSegment: aSegment [
]

{ #category : 'visiting' }
RSSegmentsVisitor >> visitLineSegment: aSegment [
]

{ #category : 'visiting' }
RSSegmentsVisitor >> visitMoveSegment: aSegment [
]

{ #category : 'visiting' }
RSSegmentsVisitor >> visitQuadSegment: aSegment [
]

"
I am a layout for Sunburst Visualization, I use a radius to calculate the better distance of all arcs in the visualization.

You can use radius to set the total radius of sunburst
or use the selector extent:, that uses radius size
"
Class {
	#name : #RSSunburstExtentStrategy,
	#superclass : #RSAbstractSunburstLayout,
	#instVars : [
		'wside'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #accessing }
RSSunburstExtentStrategy >> extent: aPoint [
	wside := aPoint x min: aPoint y
]

{ #category : #'initialize-release' }
RSSunburstExtentStrategy >> initialize [
	super initialize.
	self extent: 500@500
]

{ #category : #accessing }
RSSunburstExtentStrategy >> radiusForDepth: depth [
	| w2 maxDepth |
	w2 := wside/2.
	maxDepth := builder maxLevel.
	^ ((depth * w2 * w2) / (maxDepth + 1) ) sqrt
]

{ #category : #hook }
RSSunburstExtentStrategy >> setCenterRadius: shape [
	shape externalRadius: (self radiusForDepth: 1).
	
]

{ #category : #hook }
RSSunburstExtentStrategy >> setNormalRadius: shape [
	| r1 r2 off depth |
	depth := shape propertyAt: #depth.
	off := self radialSpacing * (depth -1 ).
	r1 := (self radiusForDepth: depth -1) + off.
	r2 := (self radiusForDepth: depth) + off.
	shape
		innerRadius: r1;
		externalRadius: r2.
]

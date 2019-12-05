"
I am a layout for sunburst visualization,

I put the arcs in a constant delta separation, you can define the center width.
"
Class {
	#name : #RSSunburstConstantWidthStrategy,
	#superclass : #RSAbstractSunburstLayout,
	#instVars : [
		'arcWidth',
		'centerWidth'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #accessing }
RSSunburstConstantWidthStrategy >> arcWidth [
	^ arcWidth
]

{ #category : #accessing }
RSSunburstConstantWidthStrategy >> arcWidth: aNumber [
	arcWidth := aNumber
]

{ #category : #accessing }
RSSunburstConstantWidthStrategy >> centerWidth [
	^ centerWidth
]

{ #category : #accessing }
RSSunburstConstantWidthStrategy >> centerWidth: anObject [
	centerWidth := anObject
]

{ #category : #'initialize-release' }
RSSunburstConstantWidthStrategy >> initialize [
	super initialize.
	self arcWidth: 50.
	self centerWidth: 50.
]

{ #category : #hook }
RSSunburstConstantWidthStrategy >> setCenterRadius: shape [
	shape externalRadius: self centerWidth.
	
]

{ #category : #hook }
RSSunburstConstantWidthStrategy >> setNormalRadius: shape [
	| r1 r2 off depth |
	depth := shape attributeAt: #depth.
	off := self radialSpacing * (depth-1).
	r1 := ((depth - 2) * arcWidth) + off.
	r2 := ((depth -1 )* arcWidth ) + off.
	shape
		innerRadius: r1 + self centerWidth;
		externalRadius: r2 + self centerWidth.
]

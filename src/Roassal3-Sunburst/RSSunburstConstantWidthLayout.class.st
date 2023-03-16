"
I am a layout for sunburst visualization,

I put the arcs in a constant delta separation, you can define the center width.
"
Class {
	#name : #RSSunburstConstantWidthLayout,
	#superclass : #RSAbstractSunburstLayout,
	#instVars : [
		'arcWidth',
		'centerWidth'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #accessing }
RSSunburstConstantWidthLayout >> arcWidth [
	^ arcWidth
]

{ #category : #accessing }
RSSunburstConstantWidthLayout >> arcWidth: aNumber [
	arcWidth := aNumber
]

{ #category : #accessing }
RSSunburstConstantWidthLayout >> centerWidth [
	^ centerWidth
]

{ #category : #accessing }
RSSunburstConstantWidthLayout >> centerWidth: anObject [
	centerWidth := anObject
]

{ #category : #initialization }
RSSunburstConstantWidthLayout >> initialize [
	super initialize.
	self arcWidth: 50.
	self centerWidth: 50
]

{ #category : #hook }
RSSunburstConstantWidthLayout >> setCenterRadius: shape [
	shape externalRadius: self centerWidth
]

{ #category : #hook }
RSSunburstConstantWidthLayout >> setNormalRadius: shape [
	| r1 r2 off depth |
	depth := shape propertyAt: #depth.
	off := self radialSpacing * (depth-1).
	r1 := ((depth - 2) * arcWidth) + off.
	r2 := ((depth -1 )* arcWidth ) + off.
	shape
		innerRadius: r1 + self centerWidth;
		externalRadius: r2 + self centerWidth
]

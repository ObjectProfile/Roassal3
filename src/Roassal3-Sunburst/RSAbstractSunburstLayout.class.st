"
I am the abstract class for sunburst visualizations in Roassal2, check my subclasses 

* RTSunburstConstanWidthLayout
* RtSunburstExtentLayout

You can use this layout in with RTLayoutBuilder or with RTSunburstBuilder
and their examples to get more info
"
Class {
	#name : #RSAbstractSunburstLayout,
	#superclass : #TSLayout,
	#instVars : [
		'hasCenter',
		'radialSpacing',
		'builder'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #accessing }
RSAbstractSunburstLayout >> builder [
	^ builder
]

{ #category : #accessing }
RSAbstractSunburstLayout >> builder: aSunburstBuilder [
	builder := aSunburstBuilder
]

{ #category : #hook }
RSAbstractSunburstLayout >> doExecute: elements [
	| virtual |
	
	elements isEmpty ifTrue: [ ^  self ].
	elements size = 1 ifTrue: [ 
		^ self layoutSunburst: elements first ].
	virtual := RSElement new
		shape: RSPieSlice new;
		yourself.
		
	virtual attributes at: builder childrenKey put: elements.
	elements do: [ :e | e attributes at: #parent put: virtual ].
	virtual attributes at: #parent put: nil.
	virtual attributes at: #depth put: 0.
	self layoutSunburst: virtual.
	elements do: [ :e | e attributes at: #parent put: nil ].
]

{ #category : #accessing }
RSAbstractSunburstLayout >> hasCenter [
	^ hasCenter
]

{ #category : #accessing }
RSAbstractSunburstLayout >> hasCenter: aBool [
	hasCenter := aBool
]

{ #category : #'initialize-release' }
RSAbstractSunburstLayout >> initialize [
	super initialize.
	self
		hasCenter: true;
		radialSpacing: 5.
]

{ #category : #'initialize-release' }
RSAbstractSunburstLayout >> layoutSunburst: el [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractSunburstLayout >> radialSpacing [
	^ radialSpacing 
]

{ #category : #accessing }
RSAbstractSunburstLayout >> radialSpacing: aNumber [
	radialSpacing := aNumber
]

"
TSLine describes a line.
"
Class {
	#name : #TSLine,
	#superclass : #TSAbstractDualLine,
	#instVars : [
		'markers'
	],
	#classInstVars : [
		'delta'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSLine class >> delta [
	^ delta ifNil: [ delta := 5 ]
]

{ #category : #accessing }
TSLine class >> delta: aNumber [
	self assert: aNumber >= 0 description: 'The delta for TSLine can not be negative'.
	delta := aNumber
]

{ #category : #accessing }
TSLine class >> reset [
	<script: 'self reset'>
	delta := nil.
]

{ #category : #visiting }
TSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]

{ #category : #testing }
TSLine >> includesPoint: aPoint [
	^ aPoint
		onLineFrom: self startPoint 
		to: self endPoint 
		within: TSLine delta
	
]

{ #category : #accessing }
TSLine >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #accessing }
TSLine >> privateMarkers [
	^ markers
]

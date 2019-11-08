"
TSLine describes a line.
"
Class {
	#name : #RSLine,
	#superclass : #RSAbstractDualLine,
	#instVars : [
		'markers'
	],
	#classInstVars : [
		'delta'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSLine class >> delta [
	^ delta ifNil: [ delta := 5 ]
]

{ #category : #accessing }
RSLine class >> delta: aNumber [
	self assert: aNumber >= 0 description: 'The delta for TSLine can not be negative'.
	delta := aNumber
]

{ #category : #accessing }
RSLine class >> reset [
	<script: 'self reset'>
	delta := nil.
]

{ #category : #visiting }
RSLine >> buildPathOn: visitor [
	visitor buildLinePath: self
]

{ #category : #testing }
RSLine >> includesPoint: aPoint [
	^ aPoint
		onLineFrom: self startPoint 
		to: self endPoint 
		within: RSLine delta
	
]

{ #category : #accessing }
RSLine >> markers [
	^ markers ifNil: [ markers := Array new: 3 ].
]

{ #category : #accessing }
RSLine >> privateMarkers [
	^ markers
]

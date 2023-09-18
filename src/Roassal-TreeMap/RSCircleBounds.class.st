"
used to find the bounds for each circle
"
Class {
	#name : #RSCircleBounds,
	#superclass : #RSObject,
	#instVars : [
		'circles',
		'indices'
	],
	#category : #'Roassal3-TreeMap-Circular'
}

{ #category : #'instance creation' }
RSCircleBounds class >> maxCircles: anInteger [
	^ self new
		maxCircles: anInteger;
		yourself
]

{ #category : #accessing }
RSCircleBounds >> findStart: circle [
	| high low probe |
	high := circles size + 1.
	low := 1.
	[ (high - low) > 1 ] whileTrue: [
		probe := ((high + low)/2) asFloat floor.
		(circle intersects: (circles at: probe))
			ifTrue: [ high := probe ]
			ifFalse: [ low := probe ]
	 ].
	^ indices at: low
]

{ #category : #accessing }
RSCircleBounds >> maxCircles: anInteger [
	circles := OrderedCollection new: anInteger.
	indices := OrderedCollection new: anInteger
]

{ #category : #public }
RSCircleBounds >> push: circle index: index [
	| new |
	new := circles
		ifEmpty: [ circle ]
		ifNotEmpty: [ (circles at: circles size) combine: circle ].
	circles add: new.
	indices add: index.
	^ new
]

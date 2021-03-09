"
A RSAbstractElasticBoxTest is a test class for testing the behavior of RSAbstractElasticBox
"
Class {
	#name : #RSElasticBoxTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Interaction-Tests-ElasticBox'
}

{ #category : #running }
RSElasticBoxTest >> setUp [
	| shapes |
	super setUp.
	canvas := RSCanvas new.
	shapes := (1 to: 10) collect: [ :i | RSBox new size: 5; yourself ].
	RSGridLayout on: shapes.
	canvas addAll: shapes.
]

{ #category : #tests }
RSElasticBoxTest >> testBasic [
	canvas @ RSElasticBox
]

{ #category : #tests }
RSElasticBoxTest >> testEvents [
	| number elastic |
	elastic := RSElasticBox new.
	number := nil.
	elastic 
		when: RSSelectionStartEvent do: [ :evt | number := 0 ];
		when: RSSelectionChangedEvent do: [ :evt | number := number + 1 ];
		when: RSSelectionEndEvent do: [ :evt | number := number +10 ].
	canvas @ elastic.
	canvas announce: (RSMouseRightDragStart new position: 0@0).
	self assert: number equals: 0.
	canvas announce: (RSMouseDragging new position: 10@10).
	self assert: number equals: 1.
	canvas announce: (RSMouseDragEnd new position: 0@0).
	self assert: number equals: 11.
]

{ #category : #tests }
RSElasticBoxTest >> testEventsDraggableCanvas [
	| elastic number |
	elastic := RSElasticBox new.
	elastic rightLeft.
	canvas @ elastic.
	number := nil.
	elastic when: RSSelectionStartEvent do: [ :evt | number := 0 ].
	canvas announce: (RSMouseLeftDragStart new position: 0@0).
	self assert: number equals: 0.
]

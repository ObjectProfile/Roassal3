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
	canvas addAll: shapes
]

{ #category : #tests }
RSElasticBoxTest >> testBasic [
	canvas @ RSElasticBoxInteraction
]

{ #category : #tests }
RSElasticBoxTest >> testEvents [
	| number elastic |
	elastic := RSElasticBoxInteraction new.
	number := nil.
	elastic
		when: RSSelectionStartEvent do: [ :evt | number := 0 ] for: self;
		when: RSSelectionChangedEvent do: [ :evt | number := number + 1 ] for: self;
		when: RSSelectionEndEvent do: [ :evt | number := number +10 ] for: self.
	canvas @ elastic.
	canvas announce: (RSMouseLeftDragStart new shiftKeyPressed: true; position: 0@0).
	self assert: number equals: 0.
	canvas announce: (RSMouseDragging new position: 10@10).
	self assert: number equals: 1.
	canvas announce: (RSMouseDragEnd new position: 0@0).
	self assert: number equals: 11
]

{ #category : #tests }
RSElasticBoxTest >> testEventsDraggableCanvas [
	| elastic number |
	elastic := RSElasticBoxInteraction new.
	canvas @ elastic.
	number := nil.
	elastic when: RSSelectionStartEvent do: [ :evt | number := 0 ] for: self.
	canvas announce: (RSMouseLeftDragStart new shiftKeyPressed: true; position: 0@0).
	self assert: number equals: 0
]

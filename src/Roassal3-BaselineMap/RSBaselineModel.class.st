"
Used to convert instances of BaselineOf into RSBaselineModel 
"
Class {
	#name : #RSBaselineModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'name',
		'level',
		'dependencies'
	],
	#category : #'Roassal3-BaselineMap-Model'
}

{ #category : #comparing }
RSBaselineModel >> = another [
	^ name = another name
]

{ #category : #accessing }
RSBaselineModel >> baselineClass [

	^ class
]

{ #category : #accessing }
RSBaselineModel >> baselineClass: aClass [
	class := aClass
]

{ #category : #private }
RSBaselineModel >> browse [
	class ifNil: [ ^ nil ].
	^ class browse
]

{ #category : #accessing }
RSBaselineModel >> dependencies [

	^ dependencies
]

{ #category : #accessing }
RSBaselineModel >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #comparing }
RSBaselineModel >> hash [
	^ name hash
]

{ #category : #inspector }
RSBaselineModel >> inspectionBaselineMap: builder [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := RSBaselineMapSettings classMapBuilder new
		in: [ :map |
			self baselineClass
				ifNotNil: [ map baseline: self baselineClass ] ];
		build;
		canvas.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]

{ #category : #accessing }
RSBaselineModel >> level [

	^ level
]

{ #category : #accessing }
RSBaselineModel >> level: anObject [

	level := anObject
]

{ #category : #accessing }
RSBaselineModel >> name [

	^ name
]

{ #category : #accessing }
RSBaselineModel >> name: anObject [

	name := anObject
]

{ #category : #printing }
RSBaselineModel >> printOn: stream [
	stream << name
]

"
I am a builder that can be used to generate dependencies between baselines
"
Class {
	#name : #RSMapBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'models',
		'baseline',
		'context'
	],
	#category : #'Roassal3-BaselineMap-UI'
}

{ #category : #hooks }
RSMapBuilder >> adjustWidth: aMaxNumber [
	shapes do: [ :shape |
		shape children first width: aMaxNumber.
		shape adjustToChildren ]
]

{ #category : #accessing }
RSMapBuilder >> baseline [
	^ baseline
]

{ #category : #accessing }
RSMapBuilder >> baseline: aBaselineClass [
	baseline := aBaselineClass.
	self computeModels
]

{ #category : #'hooks - model' }
RSMapBuilder >> computeModels [
	| todo rootModel |
	models := OrderedCollection new.
	rootModel := self newModelFor: baseline.
	rootModel level: 1.
	todo := LinkedList with: rootModel.
	self findModels: todo
]

{ #category : #accessing }
RSMapBuilder >> context [
	^ context
]

{ #category : #accessing }
RSMapBuilder >> context: aClyFullBrowserClassContext [
	context := aClyFullBrowserClassContext
]

{ #category : #'accessing - defaults' }
RSMapBuilder >> cornerRadius [
	^ 10
]

{ #category : #'accessing - defaults' }
RSMapBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #'hooks - model' }
RSMapBuilder >> dependenciesFrom: aBMBaselineModel [
	^ aBMBaselineModel baselineClass version projects
		collect: #constructClassName
		thenSelect: #notNil
]

{ #category : #'hooks - model' }
RSMapBuilder >> findDependencies: aBMBaselineModel todoList: todoList [
	| dependencies newModels |
	dependencies := nil.
	[
		dependencies := self dependenciesFrom: aBMBaselineModel.
		newModels := dependencies collect: [ :each |
			self newModelFromDependency: each level: aBMBaselineModel level ].
		todoList addAll: newModels.
	] onErrorDo: [ :ex | dependencies := #() ].
	^ dependencies
]

{ #category : #'hooks - model' }
RSMapBuilder >> findModels: todoList [
	| model |
	todoList ifEmpty: [ ^ self ].
	model := todoList removeFirst.

	(models includes: model) ifFalse: [
		models add: model.
		model dependencies: (self findDependencies: model todoList: todoList).
	].
	self findModels: todoList
]

{ #category : #accessing }
RSMapBuilder >> groupsOfBaselines [
	^ models groupedBy: [ :model | model level ]
]

{ #category : #hooks }
RSMapBuilder >> layoutOn: aCanvas [
	RSHorizontalTreeLayout new
		horizontalGap: 50;
		verticalGap: 5;
		on: aCanvas nodes
]

{ #category : #accessing }
RSMapBuilder >> models [
	^ models
]

{ #category : #'instance creation' }
RSMapBuilder >> newBorderFor: anObject [
	^ nil
]

{ #category : #'instance creation' }
RSMapBuilder >> newBox [
	^ RSBox new
		yourself
]

{ #category : #'instance creation' }
RSMapBuilder >> newLabelFor: model [
	^ RSLabel new
		text: model name;
		color: Color black;
		yourself
]

{ #category : #'instance creation' }
RSMapBuilder >> newLineBuilder [
	^ RSLineBuilder arrowedLine
		withBorderAttachPoint;
		color: Color black;
		yourself
]

{ #category : #'instance creation' }
RSMapBuilder >> newModel [
	^ RSBaselineModel new
]

{ #category : #'instance creation' }
RSMapBuilder >> newModelFor: anObject [
	^ self newModel
		name: anObject name;
		baselineClass: anObject;
		yourself
]

{ #category : #'hooks - model' }
RSMapBuilder >> newModelFromDependency: aString level: level [
	| class |
	class := Smalltalk globals at: aString asSymbol
		ifPresent: [ :cls | cls ]
		ifAbsent: [ nil ].

	^ self newModel
		name: aString;
		baselineClass: class;
		level: level + 1;
		yourself
]

{ #category : #'instance creation' }
RSMapBuilder >> newShapeFor: model [
	| label box |
	label := self newLabelFor: model.
	box := self newBox
		extent: label extent + 10;
		border: (self newBorderFor: model);
		cornerRadius: self cornerRadius;
		yourself.
	^ ({ box. label } asShapeFor: model)
		draggable;
		yourself
]

{ #category : #hooks }
RSMapBuilder >> renderIn: aCanvas [
	| modelsByGroup |
	models ifNil: [ ^ self ].
	modelsByGroup := self groupsOfBaselines.
	modelsByGroup keysAndValuesDo: [ :level :layerGroup |
		self renderLayer: layerGroup level: level in: aCanvas ].
	self renderLinesOn: aCanvas.
	self layoutOn: aCanvas
]

{ #category : #hooks }
RSMapBuilder >> renderLayer: layerGroup level: key in: aCanvas [
	| max |
	max := 0.
	shapes := layerGroup collect: [ :model | | shape |
		shape := self newShapeFor: model.
		max := max max: shape width.
		shape ] as: RSGroup.
	self adjustWidth: max.
	aCanvas addAll: shapes
]

{ #category : #hooks }
RSMapBuilder >> renderLinesOn: aCanvas [
	self newLineBuilder
		canvas: aCanvas;
		connectToAll: [ :model |
			model dependencies collect: [ :depName |
				models detect: [ :each | each name = depName ]
				 ] ].
	aCanvas lines pushBack
]

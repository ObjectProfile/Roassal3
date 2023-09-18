"
This class creates bridge between my BMMapBuilder and calypso browser
"
Class {
	#name : #RSMapBrowserToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'targetClass'
	],
	#category : #'Roassal3-BaselineMap-UI'
}

{ #category : #baselines }
RSMapBrowserToolMorph class >> baselineClassActivation [
	<classAnnotation>
	^ ClyTabActivationStrategyAnnotation for: ClyClass asCalypsoItemContext
]

{ #category : #testing }
RSMapBrowserToolMorph class >> shouldBeActivatedInContext: aBrowserContext [
	^ aBrowserContext isClassSelected
		and: [ aBrowserContext lastSelectedClass inheritsFrom: BaselineOf ]
]

{ #category : #accessing }
RSMapBrowserToolMorph >> activationPriority [
	^ -300
]

{ #category : #building }
RSMapBrowserToolMorph >> build [
	| canvas morph |
	canvas := self buildBaselineMap.
	morph := canvas createMorph.
	morph onAnnouncement: MorphDeleted
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #building }
RSMapBrowserToolMorph >> buildBaselineMap [
	^ RSBaselineMapSettings classMapBuilderOrDefault new
		baseline: self targetClass;
		context: context;
		build;
		canvas
]

{ #category : #initialization }
RSMapBrowserToolMorph >> defaultIconName [
	^ #objects
]

{ #category : #initialization }
RSMapBrowserToolMorph >> defaultTitle [
	^ 'Graph'
]

{ #category : #testing }
RSMapBrowserToolMorph >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self targetClass = anotherBrowserTool targetClass
]

{ #category : #initialization }
RSMapBrowserToolMorph >> setUpModelFromContext [
	self targetClass: context lastSelectedClass
]

{ #category : #accessing }
RSMapBrowserToolMorph >> targetClass [

	^ targetClass
]

{ #category : #accessing }
RSMapBrowserToolMorph >> targetClass: anObject [

	targetClass := anObject
]

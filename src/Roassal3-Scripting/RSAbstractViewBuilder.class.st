"
I am the base for custom visualization, like sunburst, treemap, grapher custom visualizations with different interactions. In order to change the domain and obtain a similar visualization
"
Class {
	#name : #RSAbstractViewBuilder,
	#superclass : #RS3Object,
	#instVars : [
		'shape',
		'elements',
		'container',
		'weight'
	],
	#category : #'Roassal3-Scripting-Builders'
}

{ #category : #building }
RSAbstractViewBuilder >> build [
	"Public method that produces the visualization"
	self renderIn: self view.
	^ elements
]

{ #category : #accessing }
RSAbstractViewBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ]
]

{ #category : #accessing }
RSAbstractViewBuilder >> container: aRSViewORTSGroup [
	""
	self 
		assert: aRSViewORTSGroup canvas notNil | (aRSViewORTSGroup class = RSGroup)
		description: 'The container of this builder must be a TSCanvas or TSGroup'.
	
	container := aRSViewORTSGroup
]

{ #category : #private }
RSAbstractViewBuilder >> defaultContainer [
	^ RSView new
]

{ #category : #accessing }
RSAbstractViewBuilder >> elements [
	"usually to keep a referece to created elements by this builder"
	^ elements ifNil: [ self view elements ].
]

{ #category : #accessing }
RSAbstractViewBuilder >> elements: aCollectionOfRSElements [
	elements := aCollectionOfRSElements
]

{ #category : #'as yet unclassified' }
RSAbstractViewBuilder >> gtInspectorBuilderIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Builder'];
		initializeView: [ 
			self build.
			self view when: RSExtentChangedEvent do: [ self view zoomToFit ].
			self view.
			 ]
]

{ #category : #hooks }
RSAbstractViewBuilder >> open [
	^ self view open
]

{ #category : #hooks }
RSAbstractViewBuilder >> renderIn: aView [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractViewBuilder >> shape [
	^ shape
]

{ #category : #accessing }
RSAbstractViewBuilder >> shape: aRSShapeBuilder [
	shape := aRSShapeBuilder
]

{ #category : #accessing }
RSAbstractViewBuilder >> view [
	^ self container view
]

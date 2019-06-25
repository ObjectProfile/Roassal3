"
I am the base for custom visualization, like sunburst, treemap, grapher custom visualizations with different interactions. In order to change the domain and obtain a similar visualization
"
Class {
	#name : #RSAbstractBuilder,
	#superclass : #RSObject,
	#instVars : [
		'shape',
		'elements',
		'container'
	],
	#category : #'Roassal3-Core'
}

{ #category : #building }
RSAbstractBuilder >> build [
	"Public method that produces the visualization"
	self renderIn: self view.
	^ elements
]

{ #category : #accessing }
RSAbstractBuilder >> container: aRSViewORTSGroup [
	container := aRSViewORTSGroup
]

{ #category : #accessing }
RSAbstractBuilder >> createView [
	^ RSView new
]

{ #category : #accessing }
RSAbstractBuilder >> elements [
	"usually to keep a referece to created elements by this builder"
	^ elements ifNil: [ self view elements ].
]

{ #category : #accessing }
RSAbstractBuilder >> elements: aCollectionOfRSElements [
	elements := aCollectionOfRSElements
]

{ #category : #hooks }
RSAbstractBuilder >> open [
	^ self view open
]

{ #category : #hooks }
RSAbstractBuilder >> renderIn: aView [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBuilder >> shape [
	^ shape
]

{ #category : #accessing }
RSAbstractBuilder >> shape: aRSShapeBuilder [
	shape := aRSShapeBuilder
]

{ #category : #accessing }
RSAbstractBuilder >> view [
	^ container ifNil: [ container := self createView ]
]

{ #category : #accessing }
RSAbstractBuilder >> view: aRSView [
	self container: aRSView
]

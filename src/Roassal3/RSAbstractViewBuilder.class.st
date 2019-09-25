"
I am the base for custom visualization, like sunburst, treemap, grapher custom visualizations with different interactions. In order to change the domain and obtain a similar visualization
"
Class {
	#name : #RSAbstractViewBuilder,
	#superclass : #RSObject,
	#instVars : [
		'shape',
		'elements',
		'container',
		'weight'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #building }
RSAbstractViewBuilder >> build [
	"Public method that produces the visualization"
	self renderIn: self view.
	^ elements
]

{ #category : #default }
RSAbstractViewBuilder >> childrenKey [
	^ #elements
]

{ #category : #accessing }
RSAbstractViewBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ]
]

{ #category : #accessing }
RSAbstractViewBuilder >> container: aRSViewORTSGroup [
	""
	self 
		assert: aRSViewORTSGroup view notNil | (aRSViewORTSGroup class = TSGroup)
		description: 'The container of this builder must be a RSView or TSGroup'.
	
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

{ #category : #weight }
RSAbstractViewBuilder >> leafWeight: block [
	self weightElement: [ :e | 
		(e attributes includesKey: #weight) 
			ifTrue: [ e attributes at: #weight ]
			ifFalse: [ | w children |
				children := e attributes at: self childrenKey.
				children 
					ifEmpty: [ w := block rsValue: e model ]
					ifNotEmpty: [ 
						w := children
							inject: 0 
							into: [ :s :el | s + (weight rsValue: el) ] ].
				w := w max: self minWeightValue.
				e attributes at: #weight put: w.
				w ] ].
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

{ #category : #weight }
RSAbstractViewBuilder >> weight [
	^ weight
]

{ #category : #weight }
RSAbstractViewBuilder >> weight: anObject [
	self weightElement: [ :e| anObject rsValue: e model ].
]

{ #category : #weight }
RSAbstractViewBuilder >> weightElement: block [
	"
	This builder uses weight variable do calculate the size of each rectangle
	weight block recives an element of the square and return a number
	self weightElement: [:element | 1 ]"
	weight := block
	
	
]

{ #category : #weight }
RSAbstractViewBuilder >> weightOf: e [
	^ self weight rsValue: e
]

"
TODO
"
Class {
	#name : #RSConditionalLayout,
	#superclass : #RSLayout,
	#instVars : [
		'condition',
		'thenLayout',
		'elseLayout',
		'overallLayout'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSConditionalLayout >> condition [
	^ condition
]

{ #category : #accessing }
RSConditionalLayout >> condition: aBlockOrSymbolOrValue [
	"The argument will be evaluated for each Roassal elements.
	elements that meet the condition will be evaluated using the thenLayout, else they will be given to the elseLayout
	"
	condition := aBlockOrSymbolOrValue
]

{ #category : #'as yet unclassified' }
RSConditionalLayout >> doExecute: elements [
	| thenElements elseElements |
	thenElements := TSGroup new.
	elseElements := TSGroup new.
	elements do: [ :anElement | (condition rsValue: anElement) 
											ifTrue: [ thenElements add: anElement ] 
											ifFalse: [ elseElements add: anElement ] ].
	thenLayout on: thenElements.
	elseLayout on: elseElements.
	overallLayout on: (TSGroup with: thenElements with: elseElements)


]

{ #category : #accessing }
RSConditionalLayout >> elseLayout [
	^ elseLayout
]

{ #category : #accessing }
RSConditionalLayout >> elseLayout: aLayout [
	elseLayout := aLayout
]

{ #category : #'as yet unclassified' }
RSConditionalLayout >> initialize [
	super initialize.
	condition := true.
	thenLayout := RSTreeLayout new.
	elseLayout := RSGridLayout new.
	overallLayout := RSHorizontalLineLayout new.
]

{ #category : #accessing }
RSConditionalLayout >> overallLayout [
	^ overallLayout
]

{ #category : #accessing }
RSConditionalLayout >> overallLayout: anObject [
	overallLayout := anObject
]

{ #category : #accessing }
RSConditionalLayout >> thenLayout [
	^ thenLayout
]

{ #category : #accessing }
RSConditionalLayout >> thenLayout: aLayout [
	thenLayout := aLayout
]

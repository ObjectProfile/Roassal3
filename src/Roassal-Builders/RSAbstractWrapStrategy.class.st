"
My subclasses can define the way to wrap a text
"
Class {
	#name : #RSAbstractWrapStrategy,
	#superclass : #RSObject,
	#instVars : [
		'wrapMaxWidth'
	],
	#category : #'Roassal3-Builders-Text'
}

{ #category : #initialization }
RSAbstractWrapStrategy >> initialize [
	super initialize.
	self wrapMaxWidth: 200
]

{ #category : #accessing }
RSAbstractWrapStrategy >> wrapMaxWidth [
	^ wrapMaxWidth
]

{ #category : #accessing }
RSAbstractWrapStrategy >> wrapMaxWidth: aNumber [
	wrapMaxWidth := aNumber
]

{ #category : #hooks }
RSAbstractWrapStrategy >> wrapTextFor: aString with: aRSMultilineLabelBuilder [
	^ self subclassResponsibility
]

"
An utily class
"
Class {
	#name : #SpWrappedItem,
	#superclass : #Object,
	#instVars : [
		'selectedItem'
	],
	#category : #'Roassal3-Inspector-SP2'
}

{ #category : #accessing }
SpWrappedItem >> selectedItem [
	^ selectedItem
]

{ #category : #accessing }
SpWrappedItem >> selectedItem: anObject [
	selectedItem := anObject
]

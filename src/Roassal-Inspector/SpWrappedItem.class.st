"
An utily class
"
Class {
	#name : 'SpWrappedItem',
	#superclass : 'Object',
	#instVars : [
		'selectedItem'
	],
	#category : 'Roassal-Inspector-SP2',
	#package : 'Roassal-Inspector',
	#tag : 'SP2'
}

{ #category : 'accessing' }
SpWrappedItem >> selectedItem [
	^ selectedItem
]

{ #category : 'accessing' }
SpWrappedItem >> selectedItem: anObject [
	selectedItem := anObject
]

{ #category : 'accessing' }
SpWrappedItem >> transmission [
	^ selectedItem
]

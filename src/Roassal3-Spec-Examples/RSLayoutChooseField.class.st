"
This field uses a list of object to pick one
"
Class {
	#name : #RSLayoutChooseField,
	#superclass : #RSLayoutField,
	#instVars : [
		'items'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #rendering }
RSLayoutChooseField >> createWidget [
	^ layoutStudio newDropList
		items: items;
		selectItem: self layoutValue;
		display: [ :item | item asString ];
		whenSelectedItemChangedDo: [ :item | self layoutValue: (self transform: item) ].
]

{ #category : #accessing }
RSLayoutChooseField >> items [

	^ items
]

{ #category : #accessing }
RSLayoutChooseField >> items: anObject [

	items := anObject
]

{ #category : #accessing }
RSLayoutChooseField >> transform: aString [
	^ aString
]

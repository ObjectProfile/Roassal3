"
This field uses a list of object to pick one
"
Class {
	#name : #RSLayoutChooseField,
	#superclass : #RSLayoutField,
	#instVars : [
		'items'
	],
	#category : #'Roassal3-Spec-Examples-Layouts-Fields'
}

{ #category : #rendering }
RSLayoutChooseField >> createWidget [
	^ layoutStudio newDropList
		items: items;
		selectItem: self layoutValue;
		display: [ :item | item asString ];
		whenSelectedItemChangedDo: [ :item | self updateField: item ].
]

{ #category : #accessing }
RSLayoutChooseField >> items [

	^ items
]

{ #category : #accessing }
RSLayoutChooseField >> items: anObject [

	items := anObject
]

{ #category : #updating }
RSLayoutChooseField >> update [
	widget selectItem: self layoutValue
]

{ #category : #update }
RSLayoutChooseField >> updateWidget: aString [
	self layoutValue: (self transform: aString)
]

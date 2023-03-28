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

{ #category : #accessing }
RSLayoutChooseField >> items [

	^ items
]

{ #category : #accessing }
RSLayoutChooseField >> items: anObject [

	items := anObject
]

{ #category : #'instance creation' }
RSLayoutChooseField >> newTextField [
	^ layoutStudio newDropList
		items: items;
		selectItem: self layoutValue;
		display: [ :item | item asString ];
		whenSelectedItemChangedDo: [ :item | self layoutValue: (self transform: item) ].
]

{ #category : #accessing }
RSLayoutChooseField >> transform: aString [
	^ aString
]

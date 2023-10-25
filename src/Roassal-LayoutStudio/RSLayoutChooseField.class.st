"
This field uses a list of objects to pick one
"
Class {
	#name : 'RSLayoutChooseField',
	#superclass : 'RSLayoutField',
	#instVars : [
		'items'
	],
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'rendering' }
RSLayoutChooseField >> createWidget [
	^ layoutStudio newDropList
		items: items;
		selectItem: self layoutValue;
		display: [ :item | item asString ];
		whenSelectedItemChangedDo: [ :item | self updateField: item ]
]

{ #category : 'accessing' }
RSLayoutChooseField >> items [

	^ items
]

{ #category : 'accessing' }
RSLayoutChooseField >> items: anObject [

	items := anObject
]

{ #category : 'updating' }
RSLayoutChooseField >> update [
	widget selectItem: self layoutValue
]

{ #category : 'update' }
RSLayoutChooseField >> updateWidget: aString [
	self layoutValue: (self transform: aString)
]

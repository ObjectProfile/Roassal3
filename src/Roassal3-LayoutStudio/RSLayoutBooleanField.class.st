"
Used to have boolean fields
"
Class {
	#name : #RSLayoutBooleanField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-LayoutStudio-Fields'
}

{ #category : #rendering }
RSLayoutBooleanField >> createWidget [
	^ layoutStudio newCheckBox
		label: label;
		state: self layoutValue;
		whenChangedDo: [ :aBoolean | self updateField: aBoolean ].
]

{ #category : #rendering }
RSLayoutBooleanField >> renderIn: boxLayout [
	boxLayout add: self widget expand: false
]

{ #category : #updating }
RSLayoutBooleanField >> update [
	widget state: self layoutValue
]

{ #category : #update }
RSLayoutBooleanField >> updateWidget: aBoolean [
	self layoutValue: aBoolean
]

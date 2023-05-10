"
This is a number field and allows to modify a value of the layout
"
Class {
	#name : #RSLayoutNumberField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #'instance creation' }
RSLayoutNumberField >> newTextInput [
	^ layoutStudio newNumberInput
		whenTextChangedDo: [ :text | self updateField: text ];
		yourself
]

{ #category : #accessing }
RSLayoutNumberField >> transform: aString [
	^ aString asNumber
]

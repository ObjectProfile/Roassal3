"
This is a number field and allows to modify a value of the layout
"
Class {
	#name : 'RSLayoutNumberField',
	#superclass : 'RSLayoutField',
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'instance creation' }
RSLayoutNumberField >> newTextInput [
	^ layoutStudio newNumberInput
		whenTextChangedDo: [ :text | self updateField: text ];
		yourself
]

{ #category : 'accessing' }
RSLayoutNumberField >> transform: aString [
	^ aString asNumber
]

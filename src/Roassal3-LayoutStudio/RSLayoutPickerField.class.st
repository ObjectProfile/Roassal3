"
This field creates a button, the button will open a window to edit a layout based on field definitions
"
Class {
	#name : #RSLayoutPickerField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-LayoutStudio-Fields'
}

{ #category : #rendering }
RSLayoutPickerField >> createWidget [
	^ layoutStudio newButton
		label: 'Edit';
		"action: [ self openEditor ];"
		yourself
]

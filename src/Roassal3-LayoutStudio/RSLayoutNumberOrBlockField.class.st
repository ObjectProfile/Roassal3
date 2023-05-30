Class {
	#name : #RSLayoutNumberOrBlockField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-LayoutStudio-Fields'
}

{ #category : #rendering }
RSLayoutNumberOrBlockField >> createWidget [
	| presenter choose textField |
	presenter := layoutStudio newPresenter.
	choose := layoutStudio newDropList items: { 'Block'. 'Number' }.
	textField := layoutStudio newTextInput.
	presenter layout: (SpBoxLayout newVertical
		add: choose;
		add: textField;
		yourself).
	^ presenter
	
]

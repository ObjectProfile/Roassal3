"
Used to validate numbers or block that returns a number
"
Class {
	#name : #RSLayoutNumberOrBlockField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-LayoutStudio-Fields'
}

{ #category : #rendering }
RSLayoutNumberOrBlockField >> createWidget [
	widget := layoutStudio newMorph.
	widget morph: (BorderedMorph new
		borderColor: Color red;
		borderWidth: 1;
		yourself).
	self updateTextField: self dropListItems first.
	^ widget
	
]

{ #category : #rendering }
RSLayoutNumberOrBlockField >> dropListItems [
	^ { 'Block'. 'Number' }
]

{ #category : #rendering }
RSLayoutNumberOrBlockField >> updateTextField: aString [
	| choose textField |
	choose := layoutStudio newDropList 
		items: self dropListItems;
		whenSelectedItemChangedDo: [ :item | self updateTextField: item ].
	textField := layoutStudio newTextInput.
	widget layout: (SpBoxLayout newVertical
		borderWidth: 1;
		add: (SpBoxLayout newHorizontal
			add: 'Type: ' asString expand: false;
			add: choose;
			yourself);
		borderWidth: 5;
		add: (SpBoxLayout newHorizontal
			add: ' ' asString withConstraints: [ :c | c width: 10; expand: false] ;
			add: textField;
			yourself);
		yourself).
]

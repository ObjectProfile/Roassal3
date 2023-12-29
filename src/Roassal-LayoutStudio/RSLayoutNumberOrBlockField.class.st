"
Used to validate numbers or block that returns a number
"
Class {
	#name : 'RSLayoutNumberOrBlockField',
	#superclass : 'RSLayoutField',
	#instVars : [
		'currentWidget'
	],
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> createWidget [
	widget := layoutStudio newMorph.
	self updateTextField: self dropListItems first.
	^ widget
]

{ #category : 'update' }
RSLayoutNumberOrBlockField >> currentWidget [
	^ currentWidget
]

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> dropListItems [
	^ { 'Block'. 'Number' }
]

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> layoutValueAsNumber [
	| result value |
	value := self layoutValue.
	result := nil.
	[ result := value asInteger] onErrorDo: [ :ex | result := 3 ].
	^ result
]

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> newCode [
	^ layoutStudio newCode
		text: self layoutValue;
		whenSubmitDo: [ :text | self updateField: text ];
		yourself
]

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> newNumberInput [
	^ layoutStudio newNumberInput
		text: self layoutValueAsNumber asString;
		whenTextChangedDo: [ :text | self updateField: text ];
		yourself
]

{ #category : 'accessing' }
RSLayoutNumberOrBlockField >> transform: aString [

	^ currentWidget class = SpCodePresenter
		ifTrue: [ self class compiler evaluate: aString ]
		ifFalse: [ aString asNumber ]
]

{ #category : 'updating' }
RSLayoutNumberOrBlockField >> update [
	self currentWidget text: self layoutValue asString
]

{ #category : 'rendering' }
RSLayoutNumberOrBlockField >> updateTextField: aString [
	| choose isTextField |
	choose := layoutStudio newDropList
		items: self dropListItems;
		selectItem: aString;
		whenSelectedItemChangedDo: [ :item | self updateTextField: item ].
	isTextField := aString = 'Number'.
	currentWidget := isTextField
		ifTrue: [ self newNumberInput ]
		ifFalse: [ self newCode ].
	widget layout: (SpBoxLayout newVertical
		borderWidth: 1;
		add: (SpBoxLayout newHorizontal
			add: 'Type: ' asString expand: false;
			add: choose;
			yourself) expand: false;
		borderWidth: 5;
		add: (SpBoxLayout newHorizontal
			add: ' ' asString withConstraints: [ :c | c width: 10; expand: false] ;
			add: currentWidget;
			yourself) withConstraints: [:c |
				c height: (isTextField
					ifTrue: [ 25 ]
					ifFalse: [ 100 ]) ];
		yourself).
	layoutStudio update
]

{ #category : 'update' }
RSLayoutNumberOrBlockField >> updateWidget: aString [
	[ self layoutValue: (self transform: aString) ]
		onErrorDo: [ :ex | self inform: ex printString ].
	self currentWidget text: self layoutValue asString
]

"
This is a number field and allows to modify a value of the layout
"
Class {
	#name : #RSLayoutNumberField,
	#superclass : #RSObject,
	#instVars : [
		'label',
		'selector',
		'layoutStudio',
		'textField'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #accessing }
RSLayoutNumberField >> label [

	^ label
]

{ #category : #accessing }
RSLayoutNumberField >> label: anObject [

	label := anObject
]

{ #category : #accessing }
RSLayoutNumberField >> layoutStudio [

	^ layoutStudio
]

{ #category : #accessing }
RSLayoutNumberField >> layoutStudio: anObject [

	layoutStudio := anObject
]

{ #category : #accessing }
RSLayoutNumberField >> layoutValue [
	^ selector value: layoutStudio currentLayout
]

{ #category : #accessing }
RSLayoutNumberField >> layoutValue: anObject [
	layoutStudio apply: self with: anObject
]

{ #category : #rendering }
RSLayoutNumberField >> newTextField [
	^ layoutStudio newTextInput
		text: self layoutValue asString;
		whenSubmitDo: [ :text | self updateField: text ];
		yourself
]

{ #category : #rendering }
RSLayoutNumberField >> renderIn: boxLayout [

	boxLayout add: (SpBoxLayout newVertical
		add: label asString expand: false;
		add: self textField expand: false;
		yourself) expand: false
]

{ #category : #accessing }
RSLayoutNumberField >> selector [

	^ selector
]

{ #category : #accessing }
RSLayoutNumberField >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
RSLayoutNumberField >> textField [
	^ textField ifNil: [ textField := self newTextField ]
]

{ #category : #update }
RSLayoutNumberField >> updateField: aString [
	| number |
	number := nil.
	[number := aString asNumber.
	self layoutValue: number.
	] onErrorDo: [ :ex | ex traceCr ].
	textField text: self layoutValue asString
]

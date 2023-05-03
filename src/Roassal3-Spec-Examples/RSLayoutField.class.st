"
Layout fields work with `RSLayoutDefinition`, they are used to edit instance variables of layouts.
My subclass should override the method `renderIn:`
"
Class {
	#name : #RSLayoutField,
	#superclass : #RSObject,
	#instVars : [
		'label',
		'selector',
		'layoutStudio',
		'widget'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #rendering }
RSLayoutField >> createWidget [
	^ self newTextInput
		text: self layoutValue asString;
		whenTextChangedDo: [ :text | self updateField: text ];
		yourself
]

{ #category : #accessing }
RSLayoutField >> label [

	^ label
]

{ #category : #accessing }
RSLayoutField >> label: anObject [

	label := anObject
]

{ #category : #accessing }
RSLayoutField >> layoutStudio [

	^ layoutStudio
]

{ #category : #accessing }
RSLayoutField >> layoutStudio: anObject [

	layoutStudio := anObject
]

{ #category : #accessing }
RSLayoutField >> layoutValue [
	^ selector value: layoutStudio currentLayout
]

{ #category : #accessing }
RSLayoutField >> layoutValue: anObject [
	layoutStudio apply: self with: anObject
]

{ #category : #'instance creation' }
RSLayoutField >> newTextInput [
	^ layoutStudio newTextInput
]

{ #category : #rendering }
RSLayoutField >> renderIn: boxLayout [

	boxLayout add: (SpBoxLayout newVertical
		add: label asString expand: false;
		add: self widget expand: false;
		yourself) expand: false
]

{ #category : #accessing }
RSLayoutField >> selector [

	^ selector
]

{ #category : #accessing }
RSLayoutField >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
RSLayoutField >> textField [
	^ widget ifNil: [ widget := self createWidget ]
]

{ #category : #accessing }
RSLayoutField >> transform: aString [
	^ self subclassResponsibility
]

{ #category : #update }
RSLayoutField >> updateField: aString [
	[ self layoutValue: (self transform: aString) ] onErrorDo: [ :ex | ex traceCr ].
	widget text: self layoutValue asString
]

{ #category : #accessing }
RSLayoutField >> widget [
	^ self textField
]

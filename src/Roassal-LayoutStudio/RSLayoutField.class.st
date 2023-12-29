"
Layout fields work with `RSLayoutDefinition`, they are used to edit instance variables of layouts.
My subclass should override the method `renderIn:`
"
Class {
	#name : 'RSLayoutField',
	#superclass : 'RSObject',
	#instVars : [
		'label',
		'selector',
		'help',
		'layoutStudio',
		'widget',
		'isEventEnabled',
		'hasChanged'
	],
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'rendering' }
RSLayoutField >> createWidget [
	^ self newTextInput
		text: self layoutValue asString;
		help: self help;
		yourself
]

{ #category : 'public' }
RSLayoutField >> disableEvent [
	isEventEnabled := false
]

{ #category : 'public' }
RSLayoutField >> enableEvent [
	isEventEnabled := true
]

{ #category : 'testing' }
RSLayoutField >> hasChanged [
	^ hasChanged
]

{ #category : 'testing' }
RSLayoutField >> hasChanged: aBool [
	hasChanged := aBool
]

{ #category : 'accessing' }
RSLayoutField >> help [

	^ help
]

{ #category : 'accessing' }
RSLayoutField >> help: anObject [

	help := anObject
]

{ #category : 'initialization' }
RSLayoutField >> initialize [
	super initialize.
	self enableEvent.
	hasChanged := false
]

{ #category : 'accessing' }
RSLayoutField >> label [

	^ label
]

{ #category : 'accessing' }
RSLayoutField >> label: anObject [

	label := anObject
]

{ #category : 'accessing' }
RSLayoutField >> layoutStudio [

	^ layoutStudio
]

{ #category : 'accessing' }
RSLayoutField >> layoutStudio: anObject [

	layoutStudio := anObject
]

{ #category : 'accessing' }
RSLayoutField >> layoutValue [
	^ selector value: layoutStudio currentLayout
]

{ #category : 'accessing' }
RSLayoutField >> layoutValue: anObject [
	hasChanged := true.
	layoutStudio apply: self with: anObject
]

{ #category : 'instance creation' }
RSLayoutField >> newTextInput [
	^ layoutStudio newTextInput
		whenSubmitDo: [ :text | self updateField: text ];
		yourself
]

{ #category : 'printing' }
RSLayoutField >> printOn: stream tab: tabSize [
	stream << selector << ': '.
	self layoutValue printOn: stream
]

{ #category : 'rendering' }
RSLayoutField >> renderIn: boxLayout [
	boxLayout add: (SpBoxLayout newVertical
		add: label asString expand: false;
		add: self widget expand: false;
		yourself) expand: false
]

{ #category : 'accessing' }
RSLayoutField >> selector [

	^ selector
]

{ #category : 'accessing' }
RSLayoutField >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
RSLayoutField >> transform: aString [
	^ aString
]

{ #category : 'updating' }
RSLayoutField >> update [
	widget text: self layoutValue asString
]

{ #category : 'update' }
RSLayoutField >> updateField: aString [
	isEventEnabled ifFalse: [ ^ self ].
	widget ifNil: [ ^ self ].
	self updateWidget: aString
]

{ #category : 'update' }
RSLayoutField >> updateWidget: aString [
	[ self layoutValue: (self transform: aString) ]
		onErrorDo: [ :ex | self inform: ex printString ].
	widget text: self layoutValue asString
]

{ #category : 'accessing' }
RSLayoutField >> widget [
	^ widget ifNil: [ widget := self createWidget ]
]

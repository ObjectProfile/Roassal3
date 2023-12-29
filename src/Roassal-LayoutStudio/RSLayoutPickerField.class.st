"
This field creates a button, the button will open a window to edit a layout based on field definitions
"
Class {
	#name : 'RSLayoutPickerField',
	#superclass : 'RSLayoutField',
	#instVars : [
		'cachedFields'
	],
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'adding' }
RSLayoutPickerField >> add: aClass [
	cachedFields add: aClass
]

{ #category : 'rendering' }
RSLayoutPickerField >> createWidget [
	^ layoutStudio newButton
		label: 'Edit: ', self layoutValue class name;
		action: [ self openEditor ];
		yourself
]

{ #category : 'accessing' }
RSLayoutPickerField >> currentLayout [
	^ self layoutValue
]

{ #category : 'initialization' }
RSLayoutPickerField >> initialize [
	super initialize.
	cachedFields := Set new
]

{ #category : 'rendering' }
RSLayoutPickerField >> openEditor [
	RSLayoutPickerPresenter new
		pickerField: self;
		open
]

{ #category : 'printing' }
RSLayoutPickerField >> printOn: stream tab: tabSize [

	| definition |
	stream << selector << ': '.
	definition := self layoutValue class layoutDefinition.
	definition fields do: [ :field |
		(cachedFields includes: field class) ifTrue: [ field hasChanged: true ].
		field layoutStudio: self ].
	cachedFields ifNotEmpty: [stream << '('].
	definition generateStringCodeOn: stream tab: tabSize.
	cachedFields ifNotEmpty: [stream << ')']
]

{ #category : 'updating' }
RSLayoutPickerField >> update [
	widget label: 'Edit: ', self layoutValue asString
]

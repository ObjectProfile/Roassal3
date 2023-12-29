"
Used to show field definitions for a single layout field picker
"
Class {
	#name : 'RSLayoutPickerPresenter',
	#superclass : 'RSAbstractLayoutPresenter',
	#instVars : [
		'changeLayoutButton',
		'pickerField'
	],
	#category : 'Roassal-LayoutStudio-Core',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Core'
}

{ #category : 'layout' }
RSLayoutPickerPresenter class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #changeLayoutButton expand: false;
		add: #controls;
		yourself
]

{ #category : 'opening' }
RSLayoutPickerPresenter class >> open [
	<script>
	self new open
]

{ #category : 'public' }
RSLayoutPickerPresenter >> apply: aRSLayoutField with: anObject [
	currentLayout perform: aRSLayoutField selector asMutator with: anObject.
	pickerField add: aRSLayoutField class.
	pickerField layoutStudio
		saveNodesPosition;
		refresh
]

{ #category : 'initialization' }
RSLayoutPickerPresenter >> connectPresenters [
	| boxLayout |
	changeLayoutButton
		label: 'Change layout';
		action: [ self changeLayout ].
	boxLayout := SpBoxLayout newVertical.
	boxLayout add: ' '.
	controls layout: boxLayout
]

{ #category : 'public' }
RSLayoutPickerPresenter >> createBoxLayout [

	^ SpBoxLayout newVertical
		spacing: 10;
		add: self attributes;
		yourself
]

{ #category : 'public' }
RSLayoutPickerPresenter >> edit: anAssociation [
	super edit: anAssociation.
	pickerField layoutValue: self currentLayout
]

{ #category : 'initialization' }
RSLayoutPickerPresenter >> initializePresenters [
	changeLayoutButton := self newButton.
	controls := self newPresenter
]

{ #category : 'initialization' }
RSLayoutPickerPresenter >> initializeWindow: aWindow [
	aWindow
		title: pickerField layoutValue class name;
		initialExtent: 300@400
]

{ #category : 'accessing' }
RSLayoutPickerPresenter >> pickerField [
	^ pickerField
]

{ #category : 'accessing' }
RSLayoutPickerPresenter >> pickerField: aRSLayoutPickerField [
	| newLayout |
	pickerField := aRSLayoutPickerField.
	roassalCanvas := pickerField layoutStudio roassalCanvas.
	newLayout := pickerField layoutValue.
	self editLayout: newLayout definition: newLayout class layoutDefinition
]

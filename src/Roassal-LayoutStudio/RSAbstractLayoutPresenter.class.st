"
Common class to layout editors
"
Class {
	#name : 'RSAbstractLayoutPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'controls',
		'roassalCanvas',
		'currentLayout',
		'layoutDefinition',
		'graphTextEditor'
	],
	#category : 'Roassal-LayoutStudio-Core',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Core'
}

{ #category : 'opening' }
RSAbstractLayoutPresenter class >> open [
	^ self subclassResponsibility
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> apply: aRSLayoutField with: anObject [
	^ self subclassResponsibility
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> attributes [
	| attributes |
	attributes := self instantiate: RSLayoutControls.
	attributes layoutStudio: self.
	^ attributes
]

{ #category : 'events' }
RSAbstractLayoutPresenter >> changeLayout [
	| selection |
	selection := self openLayout.
	selection ifNil: [ ^ self ].
	self edit: selection
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> controls [
	^ controls
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> createBoxLayout [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> currentLayout [
	^ currentLayout
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> currentLayout: aRSLayout [
	currentLayout := aRSLayout
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> edit: anAssociation [
	| class definition |
	class := anAssociation key.
	definition := anAssociation value.
	self editLayout: class new definition: definition
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> editLayout: newLayout definition: definition [
	self
		currentLayout: newLayout;
		layoutDefinition: definition.
	roassalCanvas refresh.
	self updateToolPanel.
	self withWindowDo: [ :window | window title: self titlePrefix, newLayout class name ].
	self update
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> layoutDefinition [
	^ layoutDefinition
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> layoutDefinition: aRSLayoutDefinition [
	layoutDefinition := aRSLayoutDefinition
]

{ #category : 'events' }
RSAbstractLayoutPresenter >> openLayout [
	| selection items |
	items := RSLayout classesWithDefinitionsToEdit.
	selection := RSSelectDialog new
		title: 'Select a layout';
		label: 'Select a class';
		items: (items collect: #key);
		openModal.
	selection ifNil: [ ^ nil ].
	^ (items detect: [ :each | each key = selection ])
]

{ #category : 'update' }
RSAbstractLayoutPresenter >> refresh [
	layoutDefinition update.
	roassalCanvas refresh
]

{ #category : 'accessing' }
RSAbstractLayoutPresenter >> roassalCanvas [
	^ roassalCanvas
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> titlePrefix [
	^ 'Edit: '
]

{ #category : 'public' }
RSAbstractLayoutPresenter >> updateToolPanel [
	| newControls |
	newControls := self newPresenter.
	newControls layout: self createBoxLayout.
	controls := newControls
]

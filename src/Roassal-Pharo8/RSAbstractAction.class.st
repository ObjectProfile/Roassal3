"
Users can add actions to the inspector creating a new subclass of abstract action and defined their methods.
"
Class {
	#name : #RSAbstractAction,
	#superclass : #RSObject,
	#instVars : [
		'presentation'
	],
	#category : #'Roassal3-Pharo8'
}

{ #category : #public }
RSAbstractAction class >> registerActionsOn: presentation [
	| instances |
	instances := self allSubclasses reject: #hasAbstractMethods.
	instances := instances collect: #new.
	instances := instances sort: [:a :b | a order < b order].
	instances do: [ :inst | inst registerOn: presentation ].
]

{ #category : #hooks }
RSAbstractAction >> category [ 
	^ nil
]

{ #category : #hooks }
RSAbstractAction >> execute [
	self subclassResponsibility
]

{ #category : #hooks }
RSAbstractAction >> executeOn: roassalPresentation [
	presentation := roassalPresentation.
	self execute
]

{ #category : #hooks }
RSAbstractAction >> icon [
	^ nil
]

{ #category : #hooks }
RSAbstractAction >> order [
	^ 0
]

{ #category : #hooks }
RSAbstractAction >> registerOn: roassalPresentation [
	presentation := roassalPresentation.
	roassalPresentation addAction: (GLMGenericAction new
		action: [ :r | self executeOn: r ];
		icon: self icon;
		title: self title;
		category: self category;
		yourself)
	
]

{ #category : #accessing }
RSAbstractAction >> roassalCanvas [
	^ presentation canvas
]

{ #category : #hooks }
RSAbstractAction >> title [
	^ nil
]

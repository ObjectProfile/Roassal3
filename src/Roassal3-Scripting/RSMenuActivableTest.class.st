Class {
	#name : #RSMenuActivableTest,
	#superclass : #RSTest,
	#instVars : [
		'view',
		'element'
	],
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #running }
RSMenuActivableTest >> setUp [
	super setUp.
	view := RSView new.
	element := RSShapeBuilder box size: 30; color: Color blue; element.
	view add: element
]

{ #category : #tests }
RSMenuActivableTest >> testBasic [
	self assert: element color equals: Color blue.
	element @ (RSMenuActivable new menuDo: [:menu :e | menu 
		add: 'Inspect' 
		target: e
		selector: #inspect
		argument: #() ]).
]

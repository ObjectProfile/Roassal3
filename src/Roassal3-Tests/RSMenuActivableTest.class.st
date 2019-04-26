Class {
	#name : #RSMenuActivableTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'element'
	],
	#category : #'Roassal3-Tests-Roassal'
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
	element @ RSMenuActivable.
	element announce: (TSMouseEnter new canvas: view canvas; shape: element).
	self assert: element color equals: Color red.
	element announce: (TSMouseLeave new canvas: view canvas; shape: element).
	self assert: element color equals: Color blue.
]

{ #category : #tests }
RSMenuActivableTest >> testWithoutMenuActivable [
	self assert: element color equals: Color blue.
	element announce: TSMouseEnter.
	 self assert: element color equals: Color blue.
]

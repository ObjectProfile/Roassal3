Class {
	#name : #RSSearchInCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'c',
		'shapes',
		'con',
		'search'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
RSSearchInCanvasTest >> setUp [
	c := RSCanvas new.
	shapes := (1 to: 10)
		collect: [ :n | 
			RSEllipse new
				size: 20;
				color: Color gray;
				model: n ]
		as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.
	shapes @ RSPopup.
	con := RSCanvasController new.
	search := RSSearchInCanvas new.
	con addInteraction: search.
	search canvas: c.
	c @ con
]

{ #category : #tests }
RSSearchInCanvasTest >> testBasic [
	search searchForShapes: '*4*'.
	self assert: shapes fourth color ~= Color gray.
	self assert: shapes fifth color = Color gray.
	
	search searchForShapes: '*5*'.
	self assert: shapes fourth color ~= Color gray.
	self assert: shapes fifth color ~= Color gray.
	
	self assert: search numberOfHighlightedShapes equals: 2.

	search resetAllHighlightedShapes.
	self assert: shapes fourth color = Color gray.
	self assert: shapes fifth color = Color gray.

]

{ #category : #tests }
RSSearchInCanvasTest >> testIsRegExpValid [
	self deny: (search isRegExpValid: '').
	self deny: (search isRegExpValid: nil).
]

{ #category : #tests }
RSSearchInCanvasTest >> testNoSearch [

	self assert: (c shapes allSatisfy: [ :s | s color = Color gray ])
]

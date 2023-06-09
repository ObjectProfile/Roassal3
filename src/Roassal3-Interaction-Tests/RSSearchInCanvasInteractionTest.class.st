Class {
	#name : #RSSearchInCanvasInteractionTest,
	#superclass : #RSTest,
	#instVars : [
		'c',
		'shapes',
		'con',
		'search'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
RSSearchInCanvasInteractionTest >> setUp [
	super setUp.
	c := RSCanvas new.
	shapes := (1 to: 10) * 100
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
	search := RSSearchInCanvasInteraction new.
	con addInteraction: search.
	search canvas: c.
	c @ con
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testBasic [
	search searchForShapes: '*4*'.
	self assert: (shapes fourth hasProperty: #shadow).
	self deny: (shapes fifth hasProperty: #shadow).

	search searchForShapes: '*5*'.
	self assert: (shapes fourth hasProperty: #shadow).
	self assert: (shapes fifth hasProperty: #shadow).

	self assert: search numberOfHighlightedShapes equals: 2.

	search resetAllHighlightedShapes.
	self deny: (shapes fourth hasProperty: #shadow).
	self deny: (shapes fifth hasProperty: #shadow)
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testExactMatch [
	search useExactMatch.
	search searchForShapes: '4'.
	self deny: (shapes fourth hasProperty: #shadow).

	search doNotUseExactMatch.
	search searchForShapes: '4'.
	self assert: (shapes fourth hasProperty: #shadow)
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testFixedShapes [

	self assert: c numberOfFixedShapes equals: 3.
	search searchForShapes: '*4*'.
	self assert: c numberOfFixedShapes equals: 4.
	search searchForShapes: '*5*'.
	self assert: c numberOfFixedShapes equals: 5.

	search resetAllHighlightedShapes.
	self assert: c numberOfFixedShapes equals: 3
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testFixedShapesAndPopup [

	| lbl |
	search searchForShapes: '*4*'.
	lbl := search fixedLabels first.
	lbl announce: RSMouseEnter new
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testIsRegExpValid [
	self deny: (search isRegExpValid: '').
	self deny: (search isRegExpValid: nil)
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testKeyCombinationOpensSearchWindow [

	| keyEvent |
	keyEvent := RSKeyUp new
		            keyName: 'F';
		            yourself.
	search processKeyUp: keyEvent.
	self assert: search searchField isNil.
	keyEvent := RSKeyUp new
		            keyName: 'F';
		            canvas: c;
		            commandKeyPressed: true; 		            yourself.
	search processKeyUp: keyEvent.
	self assert: search searchField isNotNil
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testNoSearch [

	self assert: (c shapes allSatisfy: [ :s | s color = Color gray ])
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testNumberOfHighlightedShapes [
	self assert: search numberOfHighlightedShapes equals: 0.
	search searchForShapes: '*4*'.
	self assert: search numberOfHighlightedShapes equals: 1.
	search searchForShapes: '*5*'.
	self assert: search numberOfHighlightedShapes equals: 2.
	search searchForShapes: '*3*'.
	self assert: search numberOfHighlightedShapes equals: 3.

	search resetAllHighlightedShapes.
	self assert: search numberOfHighlightedShapes equals: 0
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testSearchTextChangeSelectedShapes [
	self assert: c selectedShapes size equals: 0.
	search searchForShapes: '1'.
	self assert: (c selectedShapes collect: #model) asArray equals: #(100 1000).
	
	
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testShadow [
	self assert: search numberOfPerformedSearches equals: 0.

	search searchForShapes: '*4*'.
	self assert: (shapes fourth hasProperty: #shadow).
	self deny: (shapes fifth hasProperty: #shadow).
	self assert: search numberOfPerformedSearches equals: 1.

	search searchForShapes: '*5*'.
	self assert: (shapes fourth hasProperty: #shadow).
	self assert: (shapes fifth hasProperty: #shadow).
	self
		deny: (shapes fourth propertyAt: #shadow) color
		equals: (shapes fifth propertyAt: #shadow) color.
	self assert: search numberOfPerformedSearches equals: 2.

	self assert: search numberOfHighlightedShapes equals: 2.

	search resetAllHighlightedShapes.
	self deny: (shapes fourth hasProperty: #shadow).
	self deny: (shapes fifth hasProperty: #shadow).
	self assert: search numberOfPerformedSearches equals: 0
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testUpdateShadowSize [
	| shadow extent |
	self assert: search numberOfPerformedSearches equals: 0.
	c camera scale: 2.

	search searchForShapes: '*4*'.
	shadow := shapes fourth propertyAt: #shadow.
	extent := shadow extent.
	c camera scale: 3.
	self assert: shadow extent < extent
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testWithEdge [

	| l |
	l := RSLine new.
	l attachPoint: RSCenteredAttachPoint new.
	l color: Color black.
	l from: shapes first.
	l to: shapes last.
	c add: l.

	search searchForShapes: '*5*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*1*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*10*'.
	self assert: l color equals: Color black
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testWithEdgeAndhighlightable [

	| l interaction |

	interaction := RSHighlightable new.
	interaction highlightBorder: (RSBorder new width: 2).
	interaction withLines.
	c shapes @ interaction.

	l := RSLine new.
	l attachPoint: RSCenteredAttachPoint new.
	l color: Color black.
	l from: shapes first.
	l to: shapes last.
	c add: l.

	search searchForShapes: '*5*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*1*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*10*'.
	self assert: l color equals: Color black
]

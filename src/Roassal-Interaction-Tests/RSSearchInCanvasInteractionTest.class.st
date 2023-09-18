Class {
	#name : #RSSearchInCanvasInteractionTest,
	#superclass : #RSTest,
	#instVars : [
		'shapes',
		'con',
		'search',
		'canvas'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
RSSearchInCanvasInteractionTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := (1 to: 10) * 100
		collect: [ :n |
			RSEllipse new
				size: 20;
				color: Color gray;
				model: n ]
		as: RSGroup.
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	shapes @ RSPopup.
	con := RSCanvasController new.
	search := RSSearchInCanvasInteraction new.
	con addInteraction: search.
	search canvas: canvas.
	canvas @ con
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> setUpWithCollection [

	shapes := RSBox models: Collection withAllSubclasses.
	canvas := RSCanvas new.
	canvas @ con.
	search := canvas searchInteraction.
	canvas addAll: shapes.
	RSGridLayout on: shapes
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testBasic [

	search useExactMatch.
	search searchForShapes: '*4*'.
	self assert: shapes fourth hasShadow.
	self deny: shapes fifth hasShadow.

	search searchForShapes: '*5*'.
	self deny: shapes fourth hasShadow.
	self assert: shapes fifth hasShadow.

	search resetAllHighlightedShapes.
	self deny: shapes fourth hasShadow.
	self deny: shapes fifth hasShadow
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testCustomSearchBlock [

	self setUpWithCollection.
	search searchBlock: [ :shape :regExp | 
		| cls |
		cls := shape model.
		(regExp match: cls name) or: [ regExp match: cls package name ] ].
	search searchForShapes: 'Collection'.
	self assert: canvas selectedShapes notEmpty.
	search searchForShapes: 'Collections-Abstract'.
	self assert: canvas selectedShapes notEmpty
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testExactMatch [
	search useExactMatch.
	search searchForShapes: '4'.
	self deny: (shapes fourth hasShadow).

	search doNotUseExactMatch.
	search searchForShapes: '4'.
	self assert: (shapes fourth hasShadow)
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
		            canvas: canvas;
		            commandKeyPressed: true; 		            yourself.
	search processKeyUp: keyEvent.
	self assert: search searchField isNotNil
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testMinimumSizeOfSearchString [

	search minimumSearchSize: 3.
	search searchForShapes: '10'.
	self assert: canvas selectedShapes isEmpty.
	search searchForShapes: '100'.
	self assert: canvas selectedShapes size equals: 2.
	search searchForShapes: '10'.
	self assert: canvas selectedShapes isEmpty
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testNoSearch [

	self assert: (canvas shapes allSatisfy: [ :s | s color = Color gray ])
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testSearchStringUpdateShadow [

	search searchForShapes: '1'.
	self assert: canvas selectedShapes size equals: 2.
	search searchForShapes: '12'.
	self assert: canvas selectedShapes isEmpty
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testSearchTextChangeSelectedShapes [
	self assert: canvas selectedShapes size equals: 0.
	search searchForShapes: '1'.
	self assert: (canvas selectedShapes collect: #model) asArray equals: #(100 1000).
	search searchForShapes: '1000'.
	self assert: (canvas selectedShapes collect: #model) asArray equals: #(1000).
	
	
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testShadow [

	search useExactMatch.
	search searchForShapes: '*4*'.
	self assert: shapes fourth hasShadow.
	self deny: shapes fifth hasShadow.

	search searchForShapes: '*5*'.
	self deny: shapes fourth hasShadow.
	self assert: shapes fifth hasShadow.

	search resetAllHighlightedShapes.
	self deny: shapes fourth hasShadow.
	self deny: shapes fifth hasShadow
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testUpdateShadowSize [

	| shadow extent |
	canvas camera scale: 2.

	search searchForShapes: '*4*'.
	shadow := shapes fourth shadow.
	extent := shadow extent.
	canvas camera scale: 3.
	self assert: shapes fourth shadow extent < extent
]

{ #category : #tests }
RSSearchInCanvasInteractionTest >> testWithEdge [

	| l |
	l := RSLine new.
	l attachPoint: RSCenteredAttachPoint new.
	l color: Color black.
	l from: shapes first.
	l to: shapes last.
	canvas add: l.

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
	canvas shapes @ interaction.

	l := RSLine new.
	l attachPoint: RSCenteredAttachPoint new.
	l color: Color black.
	l from: shapes first.
	l to: shapes last.
	canvas add: l.

	search searchForShapes: '*5*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*1*'.
	self assert: l color equals: Color black.

	search searchForShapes: '*10*'.
	self assert: l color equals: Color black
]

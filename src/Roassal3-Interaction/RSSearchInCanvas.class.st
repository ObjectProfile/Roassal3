"
I am an option for the canvas controller. 
You can use me as follows (press the / key and the r key):

-=-=-=
c := RSCanvas new.

shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.

c addAll: shapes.
RSGridLayout on: shapes.

shapes @ RSPopup.

con := RSCanvasController new.
con addInteraction: RSSearchInCanvas new.
c @ con.
-=-=-=

"
Class {
	#name : #RSSearchInCanvas,
	#superclass : #RSAbstractControlCanvas,
	#instVars : [
		'highlightedShapes',
		'canvas',
		'colorToHighlight',
		'useExactMatch'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #public }
RSSearchInCanvas >> adjustRegExpIfNecessary: regExp [

	^ useExactMatch ifTrue: [ regExp ] ifFalse: [ '*', regExp, '*' ]
]

{ #category : #util }
RSSearchInCanvas >> candidateShapes [
	"Return shapes for which the model has to be matched. 
	 Only shapes that are not a line and having a model may be eligeable to be highligted"
	self assert: [ canvas notNil ] description: 'Canvas should be set first'.
	^ canvas shapes select: [ :s | s model notNil and: [ s isNode ] ]
]

{ #category : #accessing }
RSSearchInCanvas >> canvas: aCanvas [
	"Set the canvas from which shapes should be searched in"
	canvas := aCanvas
]

{ #category : #'public - configuration' }
RSSearchInCanvas >> colorToHighlight: aColor [
	"Set the color to highlight shapes when searching"
	colorToHighlight := aColor
]

{ #category : #'public - configuration' }
RSSearchInCanvas >> doNotUseExactMatch [
	"Expect a regular expression as input, but a * is prepended and appended to the regexp"
	useExactMatch := false
]

{ #category : #util }
RSSearchInCanvas >> highlightShape: s [
	"Highlight a shape. Remember it in case we need to unlighted"
	highlightedShapes add: s.
	^ RSHighlightable new record: s selector: #color value: colorToHighlight
]

{ #category : #util }
RSSearchInCanvas >> highlightShapes: shapesToHighlight [
	shapesToHighlight do: [ :s | self highlightShape: s ]
]

{ #category : #initialization }
RSSearchInCanvas >> initialize [
	super initialize.

	"The variable highlightedShapes contains the shapes that have been searched and therefore highlighted"
	highlightedShapes := OrderedCollection new.
	colorToHighlight := Color red.
	self doNotUseExactMatch
]

{ #category : #util }
RSSearchInCanvas >> isRegExpValid: regExp [
	"Is the regular expression relevant to be processed"
	^ regExp notNil and: [ regExp notEmpty ]
]

{ #category : #util }
RSSearchInCanvas >> numberOfHighlightedShapes [
	"Return the number of shapes that have been highlited"
	^ highlightedShapes size
]

{ #category : #private }
RSSearchInCanvas >> obtainRegExpToHighlight [
	"Open a UI"
	^ UIManager default
		request: 'Enter a reg exp to search for an item'
		initialAnswer: '*value*'
]

{ #category : #public }
RSSearchInCanvas >> onShape: aCanvas [
	aCanvas 
		when: RSKeyDown do: [ :evt | self processKeyDown: evt ]
]

{ #category : #private }
RSSearchInCanvas >> processKeyDown: evt [
	| char |
	self canvas: evt canvas.
	char := evt keyCharacter.
	char == $/ ifTrue: [ self searchForShapes ].
	char == $r ifTrue: [ self resetAllHighlightedShapes ]
]

{ #category : #rendering }
RSSearchInCanvas >> renderLegendOn: aLegendBuilder [
	aLegendBuilder text: '/' description: 'Search and highlight items'.
	aLegendBuilder text: 'r' description: 'Unhighlight all items'
]

{ #category : #public }
RSSearchInCanvas >> resetAllHighlightedShapes [
	"Restore the colors of all the highlighted shapes"
	self unhighlightShapes: highlightedShapes.
	highlightedShapes := OrderedCollection new.
	canvas signalUpdate
]

{ #category : #public }
RSSearchInCanvas >> searchForShapes [
	"callback called when some shapes have to be search"
	| regExp |
	regExp := self obtainRegExpToHighlight.
	(self isRegExpValid: regExp)
		ifFalse: [ ^ self ].
	self searchForShapes: regExp
]

{ #category : #public }
RSSearchInCanvas >> searchForShapes: regExp [
	"callback called when some shapes have to be search"
	| shapesToHighlight |
	shapesToHighlight := self shapesToHighlightUsingRegExp: (self adjustRegExpIfNecessary: regExp).
		
	"No need to pursue if we have not found anything"
	shapesToHighlight ifEmpty: [ ^ self ].
	
	self highlightShapes: shapesToHighlight.
	canvas signalUpdate
]

{ #category : #util }
RSSearchInCanvas >> shapesToHighlightUsingRegExp: regExp [
	"Return the shapes to be highlighted"	

	| candidateShapes shapesToHighlight |
	candidateShapes := self candidateShapes.
	shapesToHighlight := candidateShapes
		select: [ :s | regExp match: s model asString ].

	^ shapesToHighlight
]

{ #category : #util }
RSSearchInCanvas >> unhighlightShape: s [
	^ RSHighlightable new restore: s selector: #color
]

{ #category : #util }
RSSearchInCanvas >> unhighlightShapes: shapesToHighlight [
	shapesToHighlight do: [ :s | self unhighlightShape: s ]
]

{ #category : #'public - configuration' }
RSSearchInCanvas >> useExactMatch [
	"Expect a regular expression as input"
	useExactMatch := true
]

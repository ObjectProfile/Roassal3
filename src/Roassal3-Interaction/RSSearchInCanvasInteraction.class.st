"
`RSSearchInCanvas` am an option for the canvas controller. 
You can use `RSSearchInCanvas` as follows (press the S key and the R key):

Examples
- `RSSearchInCanvasInteraction class >>#exampleCollection`
- `RSSearchInCanvasInteraction class >>#exampleCollection2`

### Variables
- canvas, the current canvas.
- useExactMach, a configuration flag, if true it will use a exact regular expression
- highlightesShapes, a collection of the group of shapes
- colorsToUse, a color palette to highlight each search group
- highlightableLabels, the current labels on the top left of the search.
Search In Canvas will highlight with a shadow a current shape. You have to click on the search result to jump between results of the list.

The selection of the elements is based on each shape model `asString`
"
Class {
	#name : #RSSearchInCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'canvas',
		'useExactMatch',
		'searchField',
		'minimumSearchSize',
		'searchBlock'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #public }
RSSearchInCanvasInteraction >> adjustRegExpIfNecessary: regExp [

	^ useExactMatch ifTrue: [ regExp ] ifFalse: [ '*', regExp, '*' ]
]

{ #category : #util }
RSSearchInCanvasInteraction >> candidateShapes [
	"Return shapes for which the model has to be matched.
	 Only shapes that are not a line and having a model may be eligeable to be highligted"
	self assert: [ canvas notNil ] description: 'Canvas should be set first'.
	^ canvas allChildren select: [ :child | child model notNil and: [ child isNode ] ]
]

{ #category : #accessing }
RSSearchInCanvasInteraction >> canvas: aCanvas [
	"Set the canvas from which shapes should be searched in"
	canvas := aCanvas
]

{ #category : #'public - configuration' }
RSSearchInCanvasInteraction >> doNotUseExactMatch [
	"Expect a regular expression as input, but a * is prepended and appended to the regexp"
	useExactMatch := false
]

{ #category : #initialization }
RSSearchInCanvasInteraction >> initialize [

	super initialize.
	self doNotUseExactMatch.
	self minimumSearchSize: 1.
	self searchBlock: [ :shape :regExp | 
		regExp match: shape model asString ]
]

{ #category : #testing }
RSSearchInCanvasInteraction >> isKeyForReset: evt [
	^ evt keyName = self keyForReset
]

{ #category : #testing }
RSSearchInCanvasInteraction >> isKeyForSearch: evt [
	^ evt keyName = self keyForSearch and: [ evt commandKeyPressed ]
]

{ #category : #util }
RSSearchInCanvasInteraction >> isRegExpValid: regExp [
	"Is the regular expression relevant to be processed"
	^ regExp notNil and: [ regExp notEmpty ]
]

{ #category : #configuration }
RSSearchInCanvasInteraction >> keyForReset [
	^ 'ESCAPE'
]

{ #category : #configuration }
RSSearchInCanvasInteraction >> keyForSearch [
	^ 'F'
]

{ #category : #initialization }
RSSearchInCanvasInteraction >> minimumSearchSize [

	^ minimumSearchSize
]

{ #category : #accessing }
RSSearchInCanvasInteraction >> minimumSearchSize: anInteger [

	minimumSearchSize := anInteger
]

{ #category : #hooks }
RSSearchInCanvasInteraction >> onShape: aCanvas [
	self canvas: aCanvas.
	aCanvas searchInteraction: self.
	aCanvas when: RSKeyUp send: #processKeyUp: to: self
]

{ #category : #'private - events' }
RSSearchInCanvasInteraction >> openSearchField [

	| canvasMorph ed |
	canvasMorph := canvas morph.
	canvasMorph ifNil: [ canvasMorph := canvas createMorph ].

	ed := RubFloatingEditorBuilder new
		      autoAccept: true;
		      customizeEditorWith: [ :editor | 
			      editor scrollbarsShowNever.
			      editor extent: 200 @ 30.
			      editor position:
					      canvasMorph positionInWorld
					      + (canvasMorph width - editor width @ 0) ];
		      withEditedContentsDo: [ :editedContents | 
			      self searchForShapes: editedContents ];
		      whenEditorEscapedDo: [  ].

	ed openEditor.
	searchField := ed
]

{ #category : #'private - events' }
RSSearchInCanvasInteraction >> processKeyUp: evt [
	
	(self isKeyForSearch: evt) ifTrue: [ self openSearchField ].
	(self isKeyForReset: evt) ifTrue: [ self resetAllHighlightedShapes ]
]

{ #category : #rendering }
RSSearchInCanvasInteraction >> renderLegendOn: aLegendBuilder [
	aLegendBuilder
		text: 'cmd + ',self keyForSearch
		description: 'Search and highlight items'.
	aLegendBuilder
		text: self keyForReset
		description: 'Unhighlight all items'
]

{ #category : #public }
RSSearchInCanvasInteraction >> resetAllHighlightedShapes [
	canvas setSelectedShapes: RSGroup new.
	canvas signalUpdate
]

{ #category : #accessing }
RSSearchInCanvasInteraction >> searchBlock: aBlock [ 
	
	searchBlock := aBlock
]

{ #category : #accessing }
RSSearchInCanvasInteraction >> searchField [
	^ searchField
]

{ #category : #public }
RSSearchInCanvasInteraction >> searchForShapes: regExp [

	"callback called when some shapes have to be search"

	| shapesToHighlight |
	shapesToHighlight := self minimumSearchSize > regExp size
		                     ifTrue: [ RSGroup new ]
		                     ifFalse: [ 
			                     self shapesToHighlightUsingRegExp:
				                     (self adjustRegExpIfNecessary: regExp) ].


	canvas setSelectedShapes: shapesToHighlight.
	canvas signalUpdate
]

{ #category : #util }
RSSearchInCanvasInteraction >> shapesToHighlightUsingRegExp: regExp [

	"Return the shapes to be highlighted"

	| candidateShapes shapesToHighlight matcher |
	candidateShapes := self candidateShapes.
	matcher := regExp asString.
	shapesToHighlight := candidateShapes select: [ :s | 
		                     searchBlock value: s value: matcher ].

	^ shapesToHighlight
]

{ #category : #'public - configuration' }
RSSearchInCanvasInteraction >> useExactMatch [
	"Expect a regular expression as input"
	useExactMatch := true
]

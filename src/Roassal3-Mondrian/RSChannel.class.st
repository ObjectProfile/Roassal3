Class {
	#name : #RSChannel,
	#superclass : #Object,
	#instVars : [
		'inputGroup',
		'outputGroup',
		'effect',
		'isClicked',
		'highlightable',
		'color'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #public }
RSChannel >> build [

	inputGroup when: RSMouseEnter do: [ :evt | 
		self doHighlight.
		"isClicked ifFalse: [ self doHighlight ]."
		evt signalUpdate ].
	inputGroup @ (RSHighlightable new highlightColor: self color).

	inputGroup when: RSMouseLeave do: [ :evt | 
		self doUnhighlight.
		"isClicked ifFalse: [ self doUnhighlight ]."
		evt signalUpdate ].

	inputGroup when: RSMouseClick do: [ :evt | 
		"self doUnhighlight."
		isClicked
			ifTrue: [ self unmark: evt shape. self doUnmark "doUnhighlight" ]
			ifFalse: [ self mark: evt shape. self doMark "doHighlight" ].
		isClicked := isClicked not.
		evt signalUpdate ]
]

{ #category : #accessing }
RSChannel >> color [
	^ color
]

{ #category : #accessing }
RSChannel >> color: aColor [
	color := aColor.
	highlightable highlightColor: aColor

]

{ #category : #accessing }
RSChannel >> defaultColor [
	^ Color blue
]

{ #category : #'private - highlight' }
RSChannel >> doHighlight [
	highlightable highlightColor: self color.
	highlightable doHighlightShapes: outputGroup
]

{ #category : #'private - highlight' }
RSChannel >> doMark [

	outputGroup do: [ :e | self mark: e ]
]

{ #category : #'private - highlight' }
RSChannel >> doUnhighlight [

	highlightable unhighlightRecordedShapes: outputGroup
]

{ #category : #'private - highlight' }
RSChannel >> doUnmark [

	outputGroup do: [ :e | self unmark: e ]
]

{ #category : #initialization }
RSChannel >> initialize [
	super initialize.
	isClicked := false.
	highlightable := RSHighlightable new.
	self color: self defaultColor
]

{ #category : #public }
RSChannel >> input: aCollection [
	self assert: [ aCollection isCollection ] description: 'Should provide a collection'.
	inputGroup := aCollection asGroup
]

{ #category : #accessing }
RSChannel >> isMarked: shape [
	^ shape hasProperty: self symbolMarker
]

{ #category : #'private - highlight' }
RSChannel >> mark: shape [
	| aMark |
	aMark := RSBox new height: 5; width: shape width; color: self color.
	shape canvas add: aMark.
	RSLocation new below; outer; stick: aMark on: shape.
	shape propertyAt: self symbolMarker put: aMark.

]

{ #category : #public }
RSChannel >> output: aCollection [
	self assert: [ aCollection isCollection ] description: 'Should provide a collection'.
	outputGroup := aCollection asGroup
]

{ #category : #'private - highlight' }
RSChannel >> symbolMarker [
	^ #mark, self hash asString asSymbol
]

{ #category : #'private - highlight' }
RSChannel >> unmark: shape [
	
	(shape propertyAt: self symbolMarker) remove.
	shape removeKey: self symbolMarker
]

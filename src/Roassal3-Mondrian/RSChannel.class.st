Class {
	#name : #RSChannel,
	#superclass : #Object,
	#instVars : [
		'inputGroup',
		'outputGroup',
		'effect',
		'isClicked',
		'highlightable'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #accessing }
RSChannel >> build [

	inputGroup when: RSMouseEnter do: [ :evt | 
		isClicked ifFalse: [ self doHighlight ].
		evt signalUpdate ].
	inputGroup @ (RSHighlightable new highlightColor: Color blue).

	inputGroup when: RSMouseLeave do: [ :evt | 
		isClicked ifFalse: [ self doUnhighlight ].
		evt signalUpdate ].

	inputGroup when: RSMouseClick do: [ :evt | 
		isClicked
			ifTrue: [ self unmark: evt shape. self doUnhighlight ]
			ifFalse: [ self mark: evt shape. self doHighlight ].
		isClicked := isClicked not.
		evt signalUpdate ]
]

{ #category : #accessing }
RSChannel >> color: aColor [
	highlightable highlightColor: aColor

]

{ #category : #accessing }
RSChannel >> defaultColor [
	^ Color blue
]

{ #category : #accessing }
RSChannel >> doHighlight [

	highlightable doHighlightShapes: outputGroup
]

{ #category : #accessing }
RSChannel >> doUnhighlight [

	highlightable unhighlightRecordedShapes: outputGroup
]

{ #category : #accessing }
RSChannel >> initialize [
	super initialize.
	isClicked := false.
	highlightable := RSHighlightable new.
	self color: self defaultColor
]

{ #category : #accessing }
RSChannel >> input: aCollection [
	self assert: [ aCollection isCollection ] description: 'Should provide a collection'.
	inputGroup := aCollection asGroup
]

{ #category : #accessing }
RSChannel >> isMarked: shape [
	^ shape hasProperty: #mark 
]

{ #category : #accessing }
RSChannel >> mark: shape [
	| aMark |
	aMark := RSBox new height: 3; width: shape width; color: Color red.
	shape canvas add: aMark.
	RSLocation new below; outer; stick: aMark on: shape.
	shape propertyAt: #mark put: aMark.

]

{ #category : #accessing }
RSChannel >> output: aCollection [
	self assert: [ aCollection isCollection ] description: 'Should provide a collection'.
	outputGroup := aCollection asGroup
]

{ #category : #accessing }
RSChannel >> unmark: shape [
	
	(shape propertyAt: #mark) remove.
	shape removeKey: #previousColor
]

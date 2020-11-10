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
		highlightable doHighlightShapes: outputGroup. 
		evt signalUpdate ].
	inputGroup @ (RSHighlightable new highlightColor: Color blue).
	
	inputGroup when: RSMouseLeave do: [ :evt | 
		highlightable unhighlightRecordedShapes: outputGroup. 
		evt signalUpdate ].
	
	inputGroup when: RSMouseClick do: [ :evt | 
		isClicked 
			ifTrue: [ highlightable unhighlightRecordedShapes: outputGroup ] 
			ifFalse: [ highlightable doHighlightShapes: outputGroup ].
		isClicked := isClicked not.
		evt signalUpdate ].
	
		
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
RSChannel >> output: aCollection [
	self assert: [ aCollection isCollection ] description: 'Should provide a collection'.
	outputGroup := aCollection asGroup
]

Class {
	#name : #RSChannel,
	#superclass : #Object,
	#instVars : [
		'inputGroup',
		'outputGroup',
		'effect'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #accessing }
RSChannel >> build [
	| highlightable |
	highlightable := RSHighlightable new.
	highlightable highlightColor: Color blue.
	inputGroup when: RSMouseEnter do: [ :evt | 
		highlightable doHighlightShapes: outputGroup. 
		evt signalUpdate ].
	
	inputGroup when: RSMouseLeave do: [ :evt | 
		highlightable unhighlightRecordedShapes: outputGroup. 
		evt signalUpdate ].
	
	
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

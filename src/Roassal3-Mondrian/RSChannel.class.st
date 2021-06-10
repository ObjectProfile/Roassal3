Class {
	#name : #RSChannel,
	#superclass : #Object,
	#instVars : [
		'inputGroup',
		'outputGroup',
		'isClicked',
		'highlightable',
		'color',
		'isClickable',
		'marksGoUpward',
		'toggleOnCallback',
		'toggleOffCallback'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #public }
RSChannel >> build [

	inputGroup when: RSMouseEnter do: [ :evt | 
		self doHighlight.
		evt signalUpdate ].
	inputGroup @ (RSHighlightableInteraction new highlightColor: self color).

	inputGroup when: RSMouseLeave do: [ :evt | 
		self doUnhighlight.
		evt signalUpdate ].

	isClickable ifFalse: [ ^ self ].
	inputGroup when: RSMouseClick do: [ :evt | 
		isClicked
			ifTrue: [ self unmark: evt shape. 
						self doUnmark. 	
						"We give the possibility to execute a callback"
						toggleOffCallback rsValue: evt shape. ]
			ifFalse: [ self mark: evt shape. 
						self doMark.
						"We give the possibility to execute a callback"
						toggleOnCallback rsValue: evt shape. ].
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
	highlightable := RSHighlightableInteraction new.
	highlightable highlightColor: aColor

]

{ #category : #accessing }
RSChannel >> defaultColor [
	^ Color blue
]

{ #category : #'private - highlight' }
RSChannel >> doHighlight [
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

{ #category : #'private - highlight' }
RSChannel >> getAllMarksFrom: aShape [
	"Return all the marks from a shape"
	^ aShape properties associations select: [ :ass | ass key beginsWith: #mark ] thenCollect: #value
]

{ #category : #initialization }
RSChannel >> initialize [
	super initialize.
	isClicked := false.
	isClickable := true.
	self color: self defaultColor.
	
	"Marks must go downward"
	marksGoUpward := false.
	
	toggleOnCallback := toggleOffCallback := [ :aShape | "Do nothing for now" ].

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

{ #category : #public }
RSChannel >> makeNotClickable [
	isClickable := false
]

{ #category : #'private - highlight' }
RSChannel >> mark: shape [

	"Mark a shape by locating below it a red bar. Bars can be stacked in case several marks are on the same shape"

	| aMark position parentPosition deltaY |
	aMark := RSBox new
		         height: self markHeight;
		         width: shape width;
		         color: self color.
	shape canvas add: aMark.

	"Kind of buggy"
	"RSLocation new below; outer; stick: aMark on: shape."

	parentPosition := shape parent class == RSCanvas
		                  ifTrue: [ 0 @ 0 ]
		                  ifFalse: [ shape parent position ].
	position := shape position + (0 @ (shape height / 2))
	            + parentPosition.

	"We compute the vertical delta of the mark to be added, based on the existing marks" 
	deltaY := self markHeight * (self getAllMarksFrom: shape) size.
	
	"We must not forget the first mark, half must be added, to have exactly the mark below the shape (not overlapping)"
	deltaY := deltaY + (self markHeight / 2).
	marksGoUpward ifTrue: [ deltaY := deltaY negated ].
	aMark translateTo: position + (0 @ deltaY).

	"Register the mark in the shape"
	shape propertyAt: self symbolMarker put: aMark.

]

{ #category : #accessing }
RSChannel >> markGoUp [

	marksGoUpward := true
]

{ #category : #'private - highlight' }
RSChannel >> markHeight [

	^ 5
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

{ #category : #accessing }
RSChannel >> toggleOffCallback [

	^ toggleOffCallback
]

{ #category : #accessing }
RSChannel >> toggleOffCallback: anObject [

	toggleOffCallback := anObject
]

{ #category : #accessing }
RSChannel >> toggleOnCallback [

	^ toggleOnCallback
]

{ #category : #accessing }
RSChannel >> toggleOnCallback: anObject [

	toggleOnCallback := anObject
]

{ #category : #'private - highlight' }
RSChannel >> unmark: shape [
	| mark |
	mark := shape propertyAt: self symbolMarker.
	mark ifNil: [ ^ self ].
	mark remove.
	shape removeKey: self symbolMarker.

]

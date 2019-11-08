"
I am an utility class for RTLabelGenerator
"
Class {
	#name : #RSNiceLabel,
	#superclass : #RSObject,
	#instVars : [
		'min',
		'max',
		'step',
		'score'
	],
	#category : #'Roassal3-Utils-Labeling'
}

{ #category : #accessing }
RSNiceLabel >> max [
	^ max
]

{ #category : #accessing }
RSNiceLabel >> max: aNumber [
	max := aNumber
]

{ #category : #accessing }
RSNiceLabel >> min [
	^ min
]

{ #category : #accessing }
RSNiceLabel >> min: aNumber [
	min := aNumber
]

{ #category : #accessing }
RSNiceLabel >> numberOfTicks [
	| ticks |
	min < 0 ifTrue: [ 
		ticks := max < 0 ifTrue: [ (max - min) abs ] ifFalse: [ max+min abs  ]
		 ] ifFalse: [ 
		ticks := max - min ].
	^ (ticks / step).
	
]

{ #category : #printing }
RSNiceLabel >> printOn: aStream [
	| x |
	aStream 
		nextPutAll: '(Score: ';
		nextPutAll: (score printShowingDecimalPlaces: 2);
		nextPutAll: ') '.
	x := min.
	[x <= max ] whileTrue: [ 
		aStream nextPutAll: (x printShowingDecimalPlaces: 2).
		aStream nextPutAll: String tab.
		x := x + step ].
	
	
]

{ #category : #accessing }
RSNiceLabel >> score [
	^ score
]

{ #category : #accessing }
RSNiceLabel >> score: aNumber [
	score := aNumber
]

{ #category : #accessing }
RSNiceLabel >> step [
	^ step
]

{ #category : #accessing }
RSNiceLabel >> step: aNumber [
	step := aNumber
]

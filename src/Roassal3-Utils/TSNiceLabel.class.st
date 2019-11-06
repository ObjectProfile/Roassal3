"
I am an utility class for RTLabelGenerator
"
Class {
	#name : #TSNiceLabel,
	#superclass : #TSObject,
	#instVars : [
		'min',
		'max',
		'step',
		'score'
	],
	#category : #'Roassal3-Utils-Labeling'
}

{ #category : #accessing }
TSNiceLabel >> max [
	^ max
]

{ #category : #accessing }
TSNiceLabel >> max: aNumber [
	max := aNumber
]

{ #category : #accessing }
TSNiceLabel >> min [
	^ min
]

{ #category : #accessing }
TSNiceLabel >> min: aNumber [
	min := aNumber
]

{ #category : #accessing }
TSNiceLabel >> numberOfTicks [
	| ticks |
	min < 0 ifTrue: [ 
		ticks := max < 0 ifTrue: [ (max - min) abs ] ifFalse: [ max+min abs  ]
		 ] ifFalse: [ 
		ticks := max - min ].
	^ (ticks / step).
	
]

{ #category : #printing }
TSNiceLabel >> printOn: aStream [
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
TSNiceLabel >> score [
	^ score
]

{ #category : #accessing }
TSNiceLabel >> score: aNumber [
	score := aNumber
]

{ #category : #accessing }
TSNiceLabel >> step [
	^ step
]

{ #category : #accessing }
TSNiceLabel >> step: aNumber [
	step := aNumber
]

"
I am an utility class for RSLabelGenerator.

-=-=-=-=-=-=-=-=-=
values := #(1 2.3 4.3).
c := RSChart new.
d := RSScatterPlot new x: values y: values.
c addPlot: d.
c addDecoration: RSHorizontalTick new.

tick := RSVerticalTick new.
c addDecoration: tick.
c build.

tick createNiceLabelIn: c 
-=-=-=-=-=-=-=-=-=

prints the following: ""(Score: 0.75) 1.00	2.00	3.00	4.00	5.00	""
					
The min and max represents the range of the ticks
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
	#category : #'Roassal3-Chart-Labeling'
}

{ #category : #initialization }
RSNiceLabel >> initialize [
	super initialize.
	score := 0
]

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
	^ self ticks / step
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
		x := x + step ]
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

{ #category : #accessing }
RSNiceLabel >> ticks [
	^  min < 0 ifTrue: [
		 max < 0
			ifTrue: [ (max - min) abs ]
			ifFalse: [ max + min abs  ]
	] ifFalse: [ max - min ]
]

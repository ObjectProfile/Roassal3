"
A basic axis
"
Class {
	#name : #RSAxis,
	#superclass : #Object,
	#instVars : [
		'direction',
		'scale',
		'labels',
		'positionForLabel'
	],
	#category : #'Roassal3-Grapher-Foo'
}

{ #category : #rendering }
RSAxis >> addLabel: value on: plot [
	| label |
	label := TSLabel new
		text: value asString;
		position: (plot scale scale: self direction * value);
		yourself.
	self positionForLabel value: label.
	plot view addShape: label.
]

{ #category : #rendering }
RSAxis >> addTick: value on: plot [
	plot view addShape: (TSBox new
		position: (plot scale scale: self direction * value);
		rotateByDegrees: self direction angle radiansToDegrees;
		extent: 3@15;
		yourself).
]

{ #category : #accessing }
RSAxis >> direction [
	^ direction
]

{ #category : #accessing }
RSAxis >> direction: aPoint [ 
	direction := aPoint.
]

{ #category : #accessing }
RSAxis >> labels [
	^ labels
]

{ #category : #accessing }
RSAxis >> labels: aRSNiceLabel [ 
	labels := aRSNiceLabel
]

{ #category : #accessing }
RSAxis >> positionForLabel [
	^ positionForLabel
]

{ #category : #accessing }
RSAxis >> positionForLabel: aBlockClosure [ 
	positionForLabel := aBlockClosure
]

{ #category : #rendering }
RSAxis >> renderOn: plot [
	(self labels min to: labels max by: labels step) do: [ :value |
		self addTick: value on: plot.
		self addLabel: value on: plot. ].
]

{ #category : #accessing }
RSAxis >> scale [
	^ scale
]

{ #category : #accessing }
RSAxis >> scale: aTSScaleLinear [ 
	scale := aTSScaleLinear
]

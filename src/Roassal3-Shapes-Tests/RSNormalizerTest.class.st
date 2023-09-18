"
I am test for RSNormalizer
"
Class {
	#name : #RSNormalizerTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSNormalizerTest >> testBasic [
	| shapes |
	shapes := (1 to: 2) collect: [ :n | RSBox new model: n; yourself ].

	self assert: shapes size equals: 2.
	self assert: shapes first color equals: Color lightGray.
	RSNormalizer color
		shapes: shapes;
		normalize: #yourself.
	self assert: shapes first color equals: Color green.
	RSNormalizer size
		shapes: shapes;
		from: 100;
		to: 200;
		normalize: #yourself.
	self assert: shapes first extent equals: 100@100.
	self assert: shapes first extent equals: 100@100
]

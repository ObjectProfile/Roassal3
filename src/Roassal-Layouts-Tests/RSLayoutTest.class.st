Class {
	#name : #RSLayoutTest,
	#superclass : #RSTest,
	#instVars : [
		'shapes',
		'canvas'
	],
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #testing }
RSLayoutTest class >> isAbstract [
	^ self ==  RSLayoutTest
]

{ #category : #running }
RSLayoutTest >> setUp [
	| eb |
	super setUp.

	canvas := RSCanvas new.
	shapes := (1 to: 10) collect: [ :i | 
		(RSBox model: i) 
			size: 5;
			yourself ] as: RSGroup.
	canvas addAll: shapes.

	eb := RSLineBuilder line.
	eb canvas: canvas.
	eb shapes: shapes.
	eb connectFrom: [ :nb | nb // 2 ]
]

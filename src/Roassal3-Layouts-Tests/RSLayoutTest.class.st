Class {
	#name : #RSLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'shapes',
		'canvas'
	],
	#category : #'Roassal3-Layouts-Tests'
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
	shapes := (1 to: 10) collect: [ :i | RSBox new size: 5; model: i ] as: RSGroup.
	canvas addAll: shapes.
	
	eb := RSLineBuilder line.
	eb canvas: canvas.
	eb shapes: shapes.
	eb connectFrom: [ :nb | nb // 2 ]
	

]

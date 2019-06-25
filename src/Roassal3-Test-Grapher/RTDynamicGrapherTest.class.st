Class {
	#name : #RTDynamicGrapherTest,
	#superclass : #RTTest,
	#category : #'Roassal3-Test-Grapher-Tests-Builder-Grapher'
}

{ #category : #tests }
RTDynamicGrapherTest >> testBasic [

	| b |
	b := RTDynamicGrapher new.
	b maxX: 100.
	b maxY: 100.

	b x: #x; y: #y.
	
	b build.
	
	b shape circle color: (Color red alpha: 0.3).
	b addAll: ((1 to: 10) collect: [ :i | (100 atRandom @ 100 atRandom) ]).
	b view  
]

Class {
	#name : #RSExamplesTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Examples'
}

{ #category : #tests }
RSExamplesTest >> executeTest: method in: exampleClass [
	| res |
	res := exampleClass perform: method selector.
	self
		  deny: res = exampleClass
		  description: [ 
		  '''' , method selector, ''', should return a canvas or view.'
			"
			method browse
			" ]
]

{ #category : #tests }
RSExamplesTest >> testExamples [
	"This tests execute all the examples of Roassal. Introspectively, it looks for subclasses of RSAbstractExamples"

	self timeLimit: 4 minutes.
	RSAbstractExamples subclasses do: [ :cls | 
		| inst methods |
		inst := cls new.
		methods := cls methods 
			select: [ :met | 
				(met selector beginsWith: 'example') 
				and: [ (met hasPragmaNamed: 'noTest') not ] ].
		methods sort: CompiledMethod sortBlock.
		methods
			do: [ :met | self executeTest: met in: inst ]
			displayingProgress: [ :met | met selector ]
			every: 100 ]
		displayingProgress: [ :cls | cls asString ]
		every: 500
]

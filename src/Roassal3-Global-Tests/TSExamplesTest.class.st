Class {
	#name : #TSExamplesTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Examples'
}

{ #category : #tests }
TSExamplesTest >> testExamples [
	"This tests execute all the examples of Roassal. Introspectively, it looks for subclasses of RSAbstractExamples"
	RSAbstractExamples subclasses
		do: [ :cls | 
			| inst methods res |
			inst := cls new.
			methods := cls methods
				select: [ :met | met selector beginsWith: 'example' ].
			methods sort: CompiledMethod sortBlock.
			methods
				do: [ :met | 
					res := inst perform: met selector.
					self
						deny: res = inst
						description: ['''',met selector,''', should return a canvas or view.'] ]
				displayingProgress: [ :met | met selector ]
				every: 100 ]
		displayingProgress: [ :cls | cls asString ]
		every: 500
]

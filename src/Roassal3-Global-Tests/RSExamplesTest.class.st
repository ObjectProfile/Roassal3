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
		description: '''' , method selector, ''', should return a canvas or view.'
]

{ #category : #tests }
RSExamplesTest >> testExamples [
	"This tests execute all the examples of Roassal. Introspectively, it looks for subclasses of RSAbstractExamples"
	| clazz withErrors sameResult |
	self timeLimit: 10 minutes.
	clazz := Smalltalk at: #RSAbstractExamples ifAbsent: [ ^ self ].
	withErrors := OrderedCollection new.
	sameResult := OrderedCollection new.
	clazz subclasses do: [ :cls |
		| inst methods |
		inst := cls new.
		methods := cls methods
			select: [ :met |
				(met selector beginsWith: 'example')
				and: [ (met hasPragmaNamed: 'noTest') not ] ].
		methods sort: CompiledMethod sortBlock.
		methods
			do: [ :met | | res |
				[res := inst perform: met selector.
				res = inst ifTrue: [ sameResult add: met ]]
				on: Error do: [ :ex | | message |
					message := String streamContents: [ :stream |
						ex signalerContext shortDebugStackOn: stream ].
					withErrors add: message -> met ]
				 ]
			displayingProgress: [ :met | met selector ]
			every: 100 ]
		displayingProgress: [ :cls | cls asString ]
		every: 500.
	withErrors ifNotEmpty: [
		'>>> Examples with errors: ' traceCr.
		withErrors do: [ :report |
			report value printString traceCr.
			report key traceCr.
			'' traceCr.
			 ] ].
	withErrors := withErrors collect: [ :each | each value ].

	self assert: withErrors isEmpty description: 'All examples in roassal should run'.
	self assert: sameResult isEmpty description: 'All examples should return a canvas or builder'
]

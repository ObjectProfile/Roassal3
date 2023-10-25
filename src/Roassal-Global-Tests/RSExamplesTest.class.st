Class {
	#name : 'RSExamplesTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Examples',
	#package : 'Roassal-Global-Tests',
	#tag : 'Examples'
}

{ #category : 'tests' }
RSExamplesTest class >> validMethods: methods [
	| result |
	result := methods select: [ :met |
		(met selector beginsWith: 'example') and: [
			(met hasPragmaNamed: 'noTest') not ] ].

	result sort: CompiledMethod sortBlock.
	^ result
]

{ #category : 'tests' }
RSExamplesTest >> executeTest: method in: exampleClass [
	| res |
	res := exampleClass perform: method selector.
	self
		deny: res = exampleClass
		description: '''' , method selector, ''', should return a canvas or view.'
]

{ #category : 'tests' }
RSExamplesTest >> testClassSideExamples [
	| methods errors noSystemWindow |
	self timeLimit: 10 minutes.
	methods := self class validMethods: (RSObject withAllSubclasses
		flatCollect: [:cls | cls class methods ]).
	errors := OrderedCollection new.
	noSystemWindow := OrderedCollection new.

	methods do:[ :met | | window |
		[ window := met selector value: met methodClass soleInstance.
		(window isSystemWindow or: [window isWindowPresenter])
			ifTrue: [ window delete ]
			ifFalse: [ noSystemWindow add: met ]
		 ] onErrorDo: [ :error | errors add: met ].
		]
		displayingProgress: [ :met | met fullDisplayString ]
		every: 500.
	"class side example should return a window and run without errors"
	self assert: errors isEmpty description: 'Some errors in class side examples'.
	self assert: noSystemWindow isEmpty description: 'Some errors in class side examples'
]

{ #category : 'tests' }
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
		methods := self class validMethods: cls methods.

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

"
I am an animation that provides a number interpolating between 0 and 1. and apply it the value to one block
"
Class {
	#name : #TSNumberAnimation,
	#superclass : #TSAbstractAnimation,
	#instVars : [
		'stepAction'
	],
	#category : #'Roassal3-Trachel-Animation'
}

{ #category : #'action handling' }
TSNumberAnimation >> on: object style: getSelector value: endValue [

	| setSelector scale |
	self 
		assert: (object class canUnderstand: getSelector) 
		description: 'Invalid input'.
	setSelector := (getSelector , ':') asSymbol.
	self 
		assert: (object class canUnderstand: setSelector) 
		description: 'Invalid input'.
	scale := TSScale linear
		range: { object perform: getSelector. endValue }.
	self onStepDo: [ :t |
		object perform: setSelector withArguments: { scale scale: t }.
	]
	
	
]

{ #category : #'action handling' }
TSNumberAnimation >> onStepDo: aBlock [
	stepAction := aBlock
]

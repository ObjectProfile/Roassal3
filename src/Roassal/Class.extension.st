Extension { #name : 'Class' }

{ #category : '*Roassal' }
Class >> dependentClassesWithOccurences [
	"Return the list of classes used myself. The result may contains multiple times the same element."

	"Morph dependentClassesWithOccurences"

	| cll |
	cll := OrderedCollection new.
	"A class depends on its superclass"
	self superclass ifNotNil: [ cll add: self superclass ].

	"We unify a class and its metaclass"
	self methods , self classSide methods do: [ :m |
		m literalsDo: [ :l | "We also check if the method is not an extension"
			((((l isVariableBinding and: [ l value notNil ]) and: [
				   l value isBehavior ]) and: [ m protocolName notEmpty ]) and: [
				 m protocolName first ~= $* ]) ifTrue: [ cll add: l value ] ] ].
	^ cll asArray
]

{ #category : '*Roassal' }
Class >> numberOfVariables [
	"Return the number of variables"

	^ self instVarNames size
]

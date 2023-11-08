Extension { #name : 'CompiledMethod' }

{ #category : '*Roassal' }
CompiledMethod >> dependentClassesWithOccurences [
	"Return the list of classes used myself. The result contains my superclass. The result may contains multiple times the same element."

	"(Morph>>#drawOn:) dependentClassesWithOccurences"
	"(CompiledMethod>>#dependentClassesWithOccurences) dependentClassesWithOccurences"
	| cll |
	cll := OrderedCollection new.

	"We unify a class and its metaclass"
	self literalsDo: [ :l |
		"We also check if the method is not an extension"
		(l isVariableBinding and: [ 
			l value isNotNil and: [ 
				l value isBehavior ] ]) ifTrue: [ cll add: l value ].
	].

	^ cll asArray
]

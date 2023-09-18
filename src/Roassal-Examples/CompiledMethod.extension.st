Extension { #name : #CompiledMethod }

{ #category : #'*Roassal3-Examples' }
CompiledMethod >> dependentMethods [
	"Return the list of methods defined in my class for which I may invoke"
	"(self >> #dependentMethods) dependentMethods"
	^ self messages
		select: [ :k | self methodClass methodDict includesKey: k ]
		thenCollect: [ :k | self methodClass >> k ]
]

{ #category : #'*Roassal3-Examples' }
CompiledMethod >> numberOfLinesOfCode [
	^ self linesOfCode
]

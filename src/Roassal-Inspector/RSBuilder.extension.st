Extension { #name : 'RSBuilder' }

{ #category : '*Roassal-Inspector' }
RSBuilder >> asPresenter [
	self build.
	^ self container asPresenter
]

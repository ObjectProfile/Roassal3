Extension { #name : 'RSBuilder' }

{ #category : '*Roassal3-Inspector' }
RSBuilder >> asPresenter [
	self build.
	^ self container asPresenter
]

Extension { #name : #RSAbstractContainerBuilder }

{ #category : #'*Roassal3-Inspector' }
RSAbstractContainerBuilder >> asPresenter [
	self build.
	^ self container asPresenter
]

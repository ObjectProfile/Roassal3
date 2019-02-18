Extension { #name : #AthensCairoSurface }

{ #category : #'*Roassal3-Trachel' }
AthensCairoSurface >> hasBeenFreed [
	"Return true if the external resource has been freed"
	^ handle isNull
]

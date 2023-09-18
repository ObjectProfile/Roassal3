Extension { #name : #AtomicSharedQueue }

{ #category : #'*Roassal-OpenStreetMap' }
AtomicSharedQueue >> removeAllSuchThat: aFullBlockClosure [

	^ self nextOrNilSuchThat: aFullBlockClosure
]

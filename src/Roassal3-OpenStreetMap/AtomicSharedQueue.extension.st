Extension { #name : 'AtomicSharedQueue' }

{ #category : '*Roassal3-OpenStreetMap' }
AtomicSharedQueue >> removeAllSuchThat: aFullBlockClosure [

	^ self nextOrNilSuchThat: aFullBlockClosure
]

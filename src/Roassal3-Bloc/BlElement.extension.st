Extension { #name : #BlElement }

{ #category : #'*Roassal3-Bloc' }
BlElement >> roassalShape [

	^ self userData at: #roassalShape
]

{ #category : #'*Roassal3-Bloc' }
BlElement >> roassalShape: aRSShape [

	self userData at: #roassalShape put: aRSShape
]

{ #category : #'*Roassal3-Bloc' }
BlElement >> updateFromRoassalShape [

	self roassalShape updateBlElement: self.
	self childrenDo: [ :each | each updateFromRoassalShape ]
]

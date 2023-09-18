Extension { #name : #BlElement }

{ #category : #'*Roassal-Bloc' }
BlElement >> roassalShape [

	^ self userData at: #roassalShape
]

{ #category : #'*Roassal-Bloc' }
BlElement >> roassalShape: aRSShape [

	self userData at: #roassalShape put: aRSShape
]

{ #category : #'*Roassal-Bloc' }
BlElement >> updateFromRoassalShape [

	self roassalShape updateBlElement: self.
	self childrenDo: [ :each | each updateFromRoassalShape ]
]

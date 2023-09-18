Extension { #name : #Collection }

{ #category : #'*Roassal3-Layouts' }
Collection >> maxValue: aBlock [
	^ self inject: (aBlock value: self anyOne) into: [ :max :each | max max: (aBlock value: each) ]
]

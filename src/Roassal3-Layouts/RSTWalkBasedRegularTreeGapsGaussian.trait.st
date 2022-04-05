Trait {
	#name : #RSTWalkBasedRegularTreeGapsGaussian,
	#instVars : [
		'randomGaussian'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #gap }
RSTWalkBasedRegularTreeGapsGaussian >> gapAmond: aShape and: anotherShape default: aGap [

	^ aGap + randomGaussian next
]

{ #category : #initialization }
RSTWalkBasedRegularTreeGapsGaussian >> initializeRandomGaussianMu: mu sigma: sigma [

	randomGaussian := (RandomGaussian seed: 541)
		                  mu: mu;
		                  sigma: sigma;
		                  yourself
]

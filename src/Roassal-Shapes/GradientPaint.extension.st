Extension { #name : 'GradientPaint' }

{ #category : '*Roassal-Shapes' }
GradientPaint class >> fromArray: array [
	^ self new
		colorRamp: (array collect: [ :as | as key -> (Color colorFrom: as value)]);
		yourself
]

Extension { #name : #GradientPaint }

{ #category : #'*Roassal3-Shapes' }
GradientPaint class >> fromArray: array [
	^ self new
		colorRamp: (array collect: [ :as | as key -> (Color colorFrom: as value)]);
		yourself
]

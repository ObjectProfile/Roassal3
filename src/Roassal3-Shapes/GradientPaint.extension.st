Extension { #name : #GradientPaint }

{ #category : #'*Roassal3-Shapes' }
GradientPaint class >> linearGradient: array [
	^ LinearGradientPaint new 
		colorRamp: (array collect: [ :as | as key -> (Color colorFrom: as value) ] );
		yourself
]

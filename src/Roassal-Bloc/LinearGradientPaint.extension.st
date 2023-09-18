Extension { #name : #LinearGradientPaint }

{ #category : #'*Roassal3-Bloc' }
LinearGradientPaint >> asBlBackground [

	^ (BlLinearGradientPaint new
		  start: self start;
		  end: self stop;
		  stops: self colorRamp;
		  yourself) asBlBackground
]

"
I am a generalized implementation of Bezier lines.
"
Class {
	#name : #RSdeCasteljauLine,
	#superclass : #RSParametricLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSdeCasteljauLine >> asGroupBernsteinBase [

	| n |
	n := pointsSize - 1.

	^ (0 to: n)
		  collect: [ :each | 
			  RSParametricLineXY new
				  param: param;
				  x: [ :t | t ] y: [ :t | t bernstein: n choose: each ];
				  scale: 100 ]
		  as: RSGroup
]

{ #category : #'as yet unclassified' }
RSdeCasteljauLine >> controlPoints: aSequenceableOfPoints at: t [

	| tUnit |
	tUnit := param unitAt: t.

	^ (self deCasteljau: aSequenceableOfPoints at: tUnit) first
]

{ #category : #accessing }
RSdeCasteljauLine >> deCasteljau: aSequenceableOfPoints at: t [

	| diagonal last |
	diagonal := Array new: pointsSize.
	last := Array new: pointsSize.

	diagonal at: 1 put: aSequenceableOfPoints first.
	last at: 1 put: aSequenceableOfPoints last.

	1 to: pointsSize do: [ :k | 
		| delta |
		delta := pointsSize - k.

		1 to: delta do: [ :i | 
			| aPoint nextPoint |
			aPoint := 1 - t * (aSequenceableOfPoints at: i).
			nextPoint := t * (aSequenceableOfPoints at: i + 1).
			aSequenceableOfPoints at: i put: aPoint + nextPoint ].

		k < pointsSize ifTrue: [ 
			diagonal at: k + 1 put: aSequenceableOfPoints first.
			last at: k + 1 put: (aSequenceableOfPoints at: delta) ] ].

	^ Array with: aSequenceableOfPoints first with: diagonal with: last
]

{ #category : #accessing }
RSdeCasteljauLine >> derivative [

	^ RSdeCasteljauDerivativeLine new
		  param: param;
		  controlPoints: points;
		  yourself
]

{ #category : #accessing }
RSdeCasteljauLine >> difference [

	| diffPoints size |
	size := pointsSize - 1.

	diffPoints := Array new: size.

	1 to: size do: [ :i | 
		| aPoint |
		aPoint := (points at: i + 1) - (points at: i).
		diffPoints at: i put: aPoint ].

	^ self class new
		  param: param;
		  controlPoints: diffPoints;
		  yourself
]

{ #category : #'as yet unclassified' }
RSdeCasteljauLine >> elevate: n [

	| line |
	line := self.

	n timesRepeat: [ line := line increment ].

	^ line
]

{ #category : #accessing }
RSdeCasteljauLine >> increment [

	| incremented sandbox |
	sandbox := Array new: pointsSize + 2.

	sandbox
		replaceFrom: 2
		to: pointsSize + 1
		with: points
		startingAt: 1.

	sandbox
		at: 1 put: 0 @ 0;
		at: pointsSize + 2 put: 0 @ 0.

	incremented := Array new: pointsSize + 1.

	1 to: pointsSize + 1 do: [ :i | 
		| t |
		t := i - 1 / pointsSize.

		incremented
			at: i
			put: t * (sandbox at: i) + (1 - t * (sandbox at: i + 1)) ].

	^ self class new
		  samples: param size;
		  controlPoints: incremented;
		  yourself
]

{ #category : #accessing }
RSdeCasteljauLine >> junction: aCollectionOfPoints left: aBlock [

	^ self
		  junction: 1
		  to: 1
		  left: [ :continuityPoint :tangentPoint :obsculatorPoint :a_succ_i | 
			  | bsplineContinuity bsplineTangent bsplineObsculator |
			  bsplineContinuity := self class new
				                       samples: param size;
				                       controlPoints:
					                       aCollectionOfPoints , { continuityPoint };
				                       yourself.

			  bsplineTangent := self class new
				                    samples: param size;
				                    controlPoints: aCollectionOfPoints , { 
							                    tangentPoint.
							                    continuityPoint };
				                    yourself.

			  bsplineObsculator := self class new
				                       samples: param size;
				                       controlPoints: aCollectionOfPoints , { 
							                       obsculatorPoint.
							                       tangentPoint.
							                       continuityPoint };
				                       yourself.

			  aBlock
				  value: bsplineContinuity
				  value: bsplineTangent
				  value: bsplineObsculator ]
]

{ #category : #accessing }
RSdeCasteljauLine >> junction: aCollectionOfPoints right: aBlock [

	^ self
		  junction: 1
		  to: 1
		  right: [ :continuityPoint :tangentPoint :obsculatorPoint :a_succ_i | 
			  | bsplineContinuity bsplineTangent bsplineObsculator |
			  bsplineContinuity := self class new
				                       samples: param size;
				                       controlPoints:
					                       { continuityPoint } , aCollectionOfPoints;
				                       yourself.

			  bsplineTangent := self class new
				                    samples: param size;
				                    controlPoints: { 
						                    continuityPoint.
						                    tangentPoint } , aCollectionOfPoints;
				                    yourself.

			  bsplineObsculator := self class new
				                       samples: param size;
				                       controlPoints: { 
						                       continuityPoint.
						                       tangentPoint.
						                       obsculatorPoint } , aCollectionOfPoints;
				                       yourself.

			  aBlock
				  value: bsplineContinuity
				  value: bsplineTangent
				  value: bsplineObsculator ]
]

{ #category : #accessing }
RSdeCasteljauLine >> junction: h_i to: h_succ_i left: aBlock [

	| continuityPoint secondControlPoint thirdControlPoint tangentPoint intervalLengthSum obsculatorPoint a_succ_i ratio ratioInverted |
	continuityPoint := points at: 1.
	secondControlPoint := points at: 2.
	thirdControlPoint := points at: 3.

	ratio := h_succ_i / h_i.
	ratioInverted := h_i / h_succ_i.

	intervalLengthSum := h_i + h_succ_i.

	tangentPoint := continuityPoint
	                - (h_i / intervalLengthSum * secondControlPoint)
	                * (intervalLengthSum / h_succ_i).

	obsculatorPoint := tangentPoint * (1 + (h_succ_i / h_i))
	                   - secondControlPoint
	                   -
	                   (h_i / h_succ_i
	                    * (secondControlPoint - thirdControlPoint)).

	obsculatorPoint := ratioInverted * obsculatorPoint.

	a_succ_i := tangentPoint + (ratio * (tangentPoint - obsculatorPoint)).

	^ aBlock
		  value: continuityPoint
		  value: tangentPoint
		  value: obsculatorPoint
		  value: a_succ_i
]

{ #category : #accessing }
RSdeCasteljauLine >> junction: h_i to: h_succ_i right: aBlock [

	| continuityPoint lastButOneControlPoint lastButTwoControlPoint tangentPoint intervalLengthSum obsculatorPoint a_succ_i ratio ratioInverted offset |
	continuityPoint := points atLast: 1.
	lastButOneControlPoint := points atLast: 2.
	lastButTwoControlPoint := points atLast: 3.

	ratio := h_succ_i / h_i.
	ratioInverted := h_i / h_succ_i.

	offset := ratio * (lastButOneControlPoint - lastButTwoControlPoint).

	intervalLengthSum := h_i + h_succ_i.

	tangentPoint := intervalLengthSum * continuityPoint
	                - (h_succ_i * lastButOneControlPoint) / h_i.

	obsculatorPoint := tangentPoint - lastButOneControlPoint.
	obsculatorPoint := obsculatorPoint - offset.
	obsculatorPoint := obsculatorPoint + (ratioInverted * tangentPoint).
	obsculatorPoint := ratio * obsculatorPoint.

	a_succ_i := tangentPoint
	            + (ratioInverted * (tangentPoint - obsculatorPoint)).

	^ aBlock
		  value: continuityPoint
		  value: tangentPoint
		  value: obsculatorPoint
		  value: a_succ_i
]

{ #category : #accessing }
RSdeCasteljauLine >> polar: ratio [

	^ RSdeCasteljauPolarLine new
		  param: param;
		  ratio: ratio;
		  controlPoints: points;
		  yourself
]

{ #category : #'accessing - structure variables' }
RSdeCasteljauLine >> samples: n [

	self param: ((0 to: 1) linspace: n)
]

{ #category : #accessing }
RSdeCasteljauLine >> splitAt: aParam in: aBlock [

	| triple left right |
	sandboxControlPoints
		replaceFrom: 1
		to: pointsSize
		with: points
		startingAt: 1.

	triple := self
		          deCasteljau: sandboxControlPoints
		          at: (aParam min: 1 max: 0).

	left := self class new
		        samples: paramSize;
		        controlPoints: triple second;
		        yourself.

	right := self class new
		         samples: paramSize;
		         controlPoints: triple third;
		         yourself.

	^ aBlock value: left value: right value: self
]

{ #category : #accessing }
RSdeCasteljauLine >> weighted: aCollection [

	^ RSdeCasteljauRationalLine new
		  param: param;
		  weights: aCollection;
		  controlPoints: points;
		  yourself
]

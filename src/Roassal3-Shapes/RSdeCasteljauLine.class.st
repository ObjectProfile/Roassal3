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
	n := points size - 1.
	^ (0 to: n)
		  collect: [ :each | 
			  RSParametricLineXY new
				  samples: param size;
				  x: [ :t | t * 100 ]
				  y: [ :t | (self bernstein: n choose: each at: t) * 100 ];
				  yourself ]
		  as: RSGroup
]

{ #category : #'as yet unclassified' }
RSdeCasteljauLine >> bernstein: n choose: i at: t [

	^ (n choose: i) * (t raisedTo: i) * (1 - t raisedTo: n - i)
]

{ #category : #'as yet unclassified' }
RSdeCasteljauLine >> controlPoints: aSequenceableOfPoints at: t [

	| tUnit |
	tUnit := param unitAt: t.

	^ (self deCasteljau: aSequenceableOfPoints at: tUnit) first
]

{ #category : #accessing }
RSdeCasteljauLine >> deCasteljau: workingPoints at: t [

	| n diagonal last |
	n := workingPoints size.

	diagonal := Array new: n.
	last := Array new: n.

	diagonal at: 1 put: workingPoints first.
	last at: 1 put: workingPoints last.

	1 to: n do: [ :k | 
		1 to: n - k do: [ :i | 
			| aPoint nextPoint |
			aPoint := 1 - t * (workingPoints at: i).
			nextPoint := t * (workingPoints at: i + 1).
			workingPoints at: i put: aPoint + nextPoint ].

		k < n ifTrue: [ 
			diagonal at: k + 1 put: workingPoints first.
			last at: k + 1 put: (workingPoints at: n - k) ] ].

	^ Array with: workingPoints first with: diagonal with: last
]

{ #category : #accessing }
RSdeCasteljauLine >> derivative [

	^ RSdeCasteljauDerivativeLine new
		  samples: param size;
		  controlPoints: points;
		  yourself
]

{ #category : #accessing }
RSdeCasteljauLine >> difference [

	| diffPoints size |
	size := points size - 1.

	diffPoints := Array new: size.

	1 to: size do: [ :i | 
		| aPoint |
		aPoint := (points at: i + 1) - (points at: i).
		diffPoints at: i put: aPoint ].

	^ self class new
		  samples: param size;
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

	| incremented n sandbox |
	n := points size.

	sandbox := Array new: n + 2.

	sandbox
		replaceFrom: 2
		to: n + 1
		with: points
		startingAt: 1.

	sandbox
		at: 1 put: 0 @ 0;
		at: n + 2 put: 0 @ 0.

	incremented := Array new: n + 1.

	1 to: n + 1 do: [ :i | 
		| t |
		t := i - 1 / n.

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
		  samples: param size;
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
	triple := self deCasteljau: points copy at: (aParam min: 1 max: 0).

	left := self class new
		        samples: param size;
		        controlPoints: triple second;
		        yourself.

	right := self class new
		         samples: param size;
		         controlPoints: triple third;
		         yourself.

	^ aBlock value: left value: right value: self
]

{ #category : #accessing }
RSdeCasteljauLine >> weighted: aCollection [

	^ RSdeCasteljauRationalLine new
		  samples: param size;
		  weights: aCollection;
		  controlPoints: points;
		  yourself
]

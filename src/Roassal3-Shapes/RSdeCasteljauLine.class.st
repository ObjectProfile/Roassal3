"
I am a generalized implementation of Bezier lines.
"
Class {
	#name : #RSdeCasteljauLine,
	#superclass : #RSPolyline,
	#instVars : [
		'param',
		'points'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSdeCasteljauLine >> asGroupWithControlNet [

	^ self asGroupWithControlNetColoured: Color gray
]

{ #category : #converting }
RSdeCasteljauLine >> asGroupWithControlNet: aBlock [

	| circles polyline labels location |
	polyline := RSPolyline new
		            controlPoints: points;
		            dotted;
		            yourself.

	circles := Array new: points size.
	labels := Array new: points size.

	location := RSLocation new
		            above;
		            yourself.

	points withIndexCollect: [ :each :index | 
		| circle label |
		circle := RSCircle new
			          model: each;
			          color: Color transparent;
			          radius: polyline border width * Float platinumRatio;
			          draggable;
			          withBorder;
			          position: each;
			          yourself.

		label := RSLabel new
			         useDefaultCodeFont;
			         text: (circle position asFloatPointRound: 3);
			         yourself.

		location stick: label on: circle.

		circle when: RSPositionChangedEvent do: [ :ev | 
			circle model: ev newPosition.
			label text: (ev newPosition asFloatPointRound: 3).

			points at: index put: ev newPosition.
			polyline controlPoints: points.

			self controlPoints: points ].


		circles at: index put: circle.
		labels at: index put: label ].

	polyline color: polyline color translucent.
	self color: self color translucent.

	aBlock
		value: self
		value: circles
		value: labels
		value: polyline.

	^ RSGroup new
		  addAll: circles , labels , { 
					  polyline.
					  self };
		  yourself
]

{ #category : #converting }
RSdeCasteljauLine >> asGroupWithControlNetColoured: aColor [

	^ self asGroupWithControlNet: [ :bspline :circles :labels :line | 
		  bspline color: aColor.
		  line color: aColor translucent.
		  circles with: labels do: [ :circle :label | 
			  circle border color: aColor translucent.
			  label color: aColor translucent ] ]
]

{ #category : #'as yet unclassified' }
RSdeCasteljauLine >> binomial: n choose: i at: t [

	^ (n choose: i) * (t raisedTo: i) * (1 - t raisedTo: n - i)
]

{ #category : #accessing }
RSdeCasteljauLine >> controlPoints: aCollectionOfPoints [

	| n workingPoints |
	n := aCollectionOfPoints size.

	param ifNil: [ self samples: n * 10 ].

	workingPoints := Array new: param size.

	points := aCollectionOfPoints.

	param withIndexDo: [ :t :index | 
		| triple |
		triple := self deCasteljau: points copy at: t.

		workingPoints at: index put: triple first ].

	^ super controlPoints: workingPoints
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
		  controlPoints: diffPoints;
		  yourself
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
				                       controlPoints:
					                       aCollectionOfPoints , { continuityPoint };
				                       yourself.

			  bsplineTangent := self class new
				                    controlPoints: aCollectionOfPoints , { 
							                    tangentPoint.
							                    continuityPoint };
				                    yourself.

			  bsplineObsculator := self class new
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
				                       controlPoints:
					                       { continuityPoint } , aCollectionOfPoints;
				                       yourself.

			  bsplineTangent := self class new
				                    controlPoints: { 
						                    continuityPoint.
						                    tangentPoint } , aCollectionOfPoints;
				                    yourself.

			  bsplineObsculator := self class new
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

{ #category : #'accessing - structure variables' }
RSdeCasteljauLine >> samples: n [

	param := (0 to: 1) linspace: n
]

{ #category : #accessing }
RSdeCasteljauLine >> splitAt: aParam in: aBlock [

	| triple left right |
	triple := self deCasteljau: points copy at: (aParam min: 1 max: 0).

	left := self class new
		        controlPoints: triple second;
		        yourself.

	right := self class new
		         controlPoints: triple third;
		         yourself.

	^ aBlock value: left value: right value: self
]

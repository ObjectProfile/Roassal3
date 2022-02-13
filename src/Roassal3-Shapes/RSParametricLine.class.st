Class {
	#name : #RSParametricLine,
	#superclass : #RSPolyline,
	#instVars : [
		'param',
		'points'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSParametricLine >> asGroupWithControlNet [

	^ self asGroupWithControlNetColoured: Color gray
]

{ #category : #converting }
RSParametricLine >> asGroupWithControlNet: aBlock [

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
			          radius: polyline border width * Float goldenPlatinumRatio;
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
RSParametricLine >> asGroupWithControlNetColoured: aColor [

	^ self asGroupWithControlNet: [ :bspline :circles :labels :line | 
		  bspline color: aColor.
		  line color: aColor translucent.
		  circles with: labels do: [ :circle :label | 
			  circle border color: aColor translucent.
			  label color: aColor translucent ] ]
]

{ #category : #accessing }
RSParametricLine >> controlPoints: aCollectionOfPoints [

	| n workingPoints |
	n := aCollectionOfPoints size.

	points := aCollectionOfPoints.

	workingPoints := Array new: param size.

	param withIndexDo: [ :t :index | 
		| aPoint |
		aPoint := self controlPoints: points copy at: t.

		workingPoints at: index put: aPoint ].

	^ super controlPoints: workingPoints
]

{ #category : #converting }
RSParametricLine >> controlPoints: aSequenceableOfPoints at: t [

	self subclassResponsibility
]

{ #category : #'instance creation' }
RSParametricLine >> newLine [

	^ self class new
		  param: param;
		  yourself
]

{ #category : #accessing }
RSParametricLine >> param: anInterval [

	param := anInterval
]

{ #category : #accessing }
RSParametricLine >> scale: factor [

	^ self newLine
		  controlPoints: (points collect: [ :each | each * factor ]);
		  yourself
]

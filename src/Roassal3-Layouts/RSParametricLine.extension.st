Extension { #name : 'RSParametricLine' }

{ #category : '*Roassal3-Layouts' }
RSParametricLine >> asGroupWithControlNet: aBlock [

	| circles polyline labels location |
	polyline := RSPolyline new
		            controlPoints: points;
		            dotted;
		            yourself.

	circles := Array new: pointsSize.
	labels := Array new: pointsSize.

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

		circle
			when: RSPositionChangedEvent
			do: [ :ev |
				circle model: ev newPosition.
				label text: (ev newPosition asFloatPointRound: 3).

				points at: index put: ev newPosition.
				polyline controlPoints: points.

				self controlPoints: points ]
			for: self.


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

{ #category : '*Roassal3-Layouts' }
RSParametricLine >> asGroupWithControlNetColoured: aColor [

	^ self asGroupWithControlNet: [ :bspline :circles :labels :line | 
		  | translucentColor |
		  translucentColor := aColor translucent.

		  bspline color: aColor.
		  line color: translucentColor.
		  circles with: labels do: [ :circle :label | 
			  circle border color: translucentColor.
			  label color: translucentColor ] ]
]

Trait {
	#name : #RSTParametricXYLines,
	#category : #'Roassal3-Examples'
}

{ #category : #lines }
RSTParametricXYLines >> lineParametricHypotrochoid [

	| s r d a b |
	s := 5.
	r := 3.
	d := 5.

	a := s - r.
	b := a / r.

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: -10 to: 10 samples: 10000;
				   yourself);
		  x: [ :t | a * t cos + (d * (b * t) cos) ]
		  y: [ :t | a * t sin - (d * (b * t) sin) ];
		  scale: 10
]

{ #category : #lines }
RSTParametricXYLines >> lineParametricLissajous [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: 0 to: Float pi * 2 samples: 1000;
				   yourself);
		  x: [ :t | (3 * t) cos ] y: [ :t | (2 * t) sin ];
		  scale: 100
]

{ #category : #lines }
RSTParametricXYLines >> lineParametricNeil [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: -2 to: 2 samples: 100;
				   yourself);
		  x: [ :t | t raisedTo: 2 ] y: [ :t | t raisedTo: 3 ];
		  scale: 10
]

{ #category : #lines }
RSTParametricXYLines >> lineParametricNeil2 [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: -2 to: 2 samples: 100;
				   yourself);
		  x: [ :t | t raisedTo: 2 ] y: [ :t | (t raisedTo: 3) - t ];
		  scale: 10
]

{ #category : #lines }
RSTParametricXYLines >> lineParametricTrochoid [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: 0 to: Float pi samples: 100;
				   yourself);
		  x: [ :t | t cos * (3 * t) cos ] y: [ :t | t sin * (3 * t) cos ];
		  scale: 100
]

{ #category : #lines }
RSTParametricXYLines >> lineParametricUnitCircle [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: 0 to: Float pi * 2 samples: 100;
				   yourself);
		  x: [ :t | t cos ] y: [ :t | t sin ];
		  scale: 100
]

{ #category : #lines }
RSTParametricXYLines >> parametricXYlineButterfly [

	^ RSParametricXYLine new
		  parameterization: (RSLinspaceParameterization new
				   from: 0 to: Float pi * 12 samples: 10000;
				   yourself);
		  x: [ :t | 
			  t sin
			  * (t cos exp - (2 * (4 * t) cos) - ((t / 12) sin raisedTo: 5)) ]
		  y: [ :t | 
			  t cos
			  * (t cos exp - (2 * (4 * t) cos) - ((t / 12) sin raisedTo: 5)) ];
		  scale: 30
]

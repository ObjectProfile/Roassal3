"
Box–Muller transform, see https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
"
Class {
	#name : 'RandomBoxMullerBivariateGaussian',
	#superclass : 'Random',
	#category : 'Roassal3-Random',
	#package : 'Roassal3',
	#tag : 'Random'
}

{ #category : 'converting' }
RandomBoxMullerBivariateGaussian >> asShapeScatter [

	| gen points |
	gen := self copy.
	points := ((1 to: 500) collect: [ :each1 | gen next ]) sorted.

	^ RSComposite new shapes: (RSChart new
			   addPlot: (RSScatterPlot new
					    x: (points collect: [ :each | each x ])
					    y: (points collect: [ :each | each y ]);
					    color: Color gray translucent;
					    yourself);
			   addDecoration: RSHorizontalTick new;
			   addDecoration: RSVerticalTick new;
			   build;
			   shapes)
]

{ #category : 'accessing' }
RandomBoxMullerBivariateGaussian >> density: x [

	self shouldNotImplement
]

{ #category : 'accessing' }
RandomBoxMullerBivariateGaussian >> next [

	| u1 u2 z0 z1 z w |
	u1 := super next.
	u2 := super next.
	z := (-2 * u1 ln) sqrt.
	w := 2 * Float pi * u2.
	z0 := w cos * z.
	z1 := w sin * z.
	^ z0 @ z1
]

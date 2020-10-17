Class {
	#name : #RSConnectionExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Examples'
}

{ #category : #examples }
RSConnectionExample >> example01Basic [
	<script: 'self new example01Basic'>
	
	| c connection |
	c := RSMondrian new.
	c nodes: (1 to: 100 by: 10).
	c open.

	connection := RSPopupConnection new.
	connection inputCanvas: c.
	connection output: [ :inputModel |
		| c2 |
		c2 := RSMondrian new.
		c2 nodes: (1 to: inputModel).
		c2 line connectFrom: [ :vv | vv // 2 ].
		c2 layout cluster.
		c2 build.
	]
]

{ #category : #examples }
RSConnectionExample >> example02TwoViews [
	<script: 'self new example02TwoViews'>
	
	| c connection d |
	c := RSMondrian new.
	c nodes: (1 to: 100 by: 10).
	c open.

	connection := RSPopupConnection new.
	connection inputCanvas: c.
	connection output: [ :inputModel |
		| c2 |
		c2 := RSMondrian new.
		c2 nodes: (1 to: inputModel).
		c2 line connectFrom: [ :vv | vv // 2 ].
		c2 layout cluster.
		c2 build.
	].

	connection output: [ :inputModel |
		| c3 |
		c3 := RSChart new.
		d := RSLinePlot new.
		d y: (((1 to: inputModel) collect: [ :v | Random new nextInt: 42 ]) sortedAs: #yourself).
		c3 addPlot: d.
		c3 build
	]
]

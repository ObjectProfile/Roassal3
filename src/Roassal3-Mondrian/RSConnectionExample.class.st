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
	connection outputCanvas: [ :inputModel |
		| c2 |
		c2 := RSMondrian new.
		c2 nodes: (1 to: inputModel).
		c2 line connectFrom: [ :vv | vv // 2 ].
		c2 layout cluster.
		c2 build.
	]
]

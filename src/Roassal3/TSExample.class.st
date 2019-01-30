Class {
	#name : #TSExample,
	#superclass : #TSObject,
	#category : #'Roassal3-Trachel'
}

{ #category : #'as yet unclassified' }
TSExample >> example01Basic [
	<script: 'self new example01Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		extent: 100@100;
		yourself).
	c addShape: (TSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	c open
]

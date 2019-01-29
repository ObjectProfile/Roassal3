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
	c add: TSBox new.
	c open
]

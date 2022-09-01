"
Just examples
"
Class {
	#name : #RSCircularTreeMapExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-TreeMap-Examples'
}

{ #category : #'as yet unclassified' }
RSCircularTreeMapExamples >> example01Morph [
	<script: 'self new example01Morph open'>
	"| b |
	b := RSCircularTreeMap new.
	b explore: Morph using: #subclasses.
	^ b"
	^ RSCanvas new
]

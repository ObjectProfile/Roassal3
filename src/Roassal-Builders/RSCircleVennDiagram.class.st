"
This class creates a Venn Diagram to visualise two sets of data and their intersection.
This does not work for more than two sets for now.
The formula used to compute it are available at: https://dspace.library.uvic.ca/bitstream/handle/1828/128/phdGradStudiesMay24.pdf
"
Class {
	#name : 'RSCircleVennDiagram',
	#superclass : 'RSBuilder',
	#instVars : [
		'bigSet',
		'smallSet',
		'omega',
		'treshold'
	],
	#category : 'Roassal-Builders-VennDiagram',
	#package : 'Roassal-Builders',
	#tag : 'VennDiagram'
}

{ #category : 'examples' }
RSCircleVennDiagram class >> example1 [

	^ self new
		bigSet: { 1. 2. 3. 4. 5. 6. 8. 9. 0. 0. 8 };
		smallSet: { 1. 2. 10. 20. 50. 14 };
		open
]

{ #category : 'accessing' }
RSCircleVennDiagram >> bigSet [

	^ bigSet
]

{ #category : 'accessing' }
RSCircleVennDiagram >> bigSet: anObject [

	bigSet := anObject asSet
]

{ #category : 'computation' }
RSCircleVennDiagram >> computeDistance [

	| bigRadius smallRadius intersection intersectionWeight lowBoundary highBoundary deltaFunction middle |
	bigRadius := self computeRadius: bigSet.
	smallRadius := self computeRadius: smallSet.
	intersection := bigSet intersection: smallSet.
	intersectionWeight := self weight: intersection.

	lowBoundary := bigRadius - smallRadius.
	highBoundary := bigRadius + smallRadius.
	deltaFunction := [ :d |
	                 | alpha beta delta |
	                 alpha := 2
	                          *
		                          (d squared + bigRadius squared
		                           - smallRadius squared / 2 * bigRadius * d)
			                          arcCos.
	                 beta := 2
	                         *
		                         (d squared - bigRadius squared
		                          + smallRadius squared / 2 * smallRadius
		                          * d) arcCos.
	                 delta := 0.5 * bigRadius squared
	                          * (alpha - alpha) sin
	                          +
	                          (0.5 * smallRadius squared
	                           * (beta - beta sin)).
	                 delta ].

	"Bisection algorithm"
	middle := lowBoundary + highBoundary / 2.
	[ (deltaFunction value: middle) - intersectionWeight < treshold ]
		whileFalse: [
			(deltaFunction value: middle) > intersectionWeight
				ifTrue: [ lowBoundary := middle ]
				ifFalse: [ highBoundary := middle ].
			middle := lowBoundary + highBoundary / 2 ].
	^ middle
]

{ #category : 'accessing' }
RSCircleVennDiagram >> computeRadius: aSet [

	^ ((self weight: aSet) / Float pi) sqrt
]

{ #category : 'initialization' }
RSCircleVennDiagram >> initialize [
	super initialize.
	bigSet := Set new.
	smallSet := Set new.
	treshold := 0.001. "Accuracy of intersection area"
]

{ #category : 'rendering' }
RSCircleVennDiagram >> renderIn: aCanvas [

	| bigRadius smallRadius distance |
	(bigSet isEmpty or: [ smallSet isEmpty ]) ifTrue: [ ^ self ].

	omega := bigSet asSet.
	omega addAll: smallSet.
	bigRadius := self computeRadius: bigSet.
	smallRadius := self computeRadius: smallSet.
	distance := self computeDistance.

	aCanvas newCircle
		radius: bigRadius * 10;
		color: Color blue translucent;
		position: 0 asPoint.
	aCanvas newCircle
		radius: smallRadius * 10;
		position: distance * 10 @ 0;
		color: Color red translucent.
	aCanvas @ RSCanvasController
]

{ #category : 'accessing' }
RSCircleVennDiagram >> smallSet [

	^ smallSet
]

{ #category : 'accessing' }
RSCircleVennDiagram >> smallSet: anObject [

	smallSet := anObject asSet
]

{ #category : 'accessing' }
RSCircleVennDiagram >> weight: aSet [

	^ aSet size / omega size
]

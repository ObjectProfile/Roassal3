"
Similar like TreeMap, but with circles, please check examples for RSTreeMap and RSCircularTreeMap
"
Class {
	#name : #RSCircularTreeMap,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'shape',
		'baseRadius'
	],
	#category : #'Roassal3-TreeMap-Core'
}

{ #category : #accessing }
RSCircularTreeMap >> baseRadius [
	^ baseRadius
]

{ #category : #accessing }
RSCircularTreeMap >> baseRadius: aNumber [
	baseRadius := aNumber
]

{ #category : #defaults }
RSCircularTreeMap >> defaultBaseRadius [
	^ 100
]

{ #category : #'accessing - defaults' }
RSCircularTreeMap >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #defaults }
RSCircularTreeMap >> defaultShape [
	^ RSCircle new
		noPaint;
		withBorder;
		yourself
]

{ #category : #utilities }
RSCircularTreeMap >> expandCircles: aShape parent: parent [
	"
	RTCircularTreeMapExample new example01
	"
	| children |
	aShape
		position: parent x @ parent y;
		radius: parent radius.

	children := aShape schildren.
	children ifNil: [ ^ self ].
	children do: [ :child |
		child
			propertyAt: #circle
			ifPresent: [ :circle |
				self
					expandCircles: child
					parent: (self relativeToCirble: circle parent: parent)
			 ]
		]
]

{ #category : #private }
RSCircularTreeMap >> findBestGapIn: gaps
	children: children
	index: i
	cbounding: cbounding
	bounds: bounds
	circles: circles
	distance: distance
	closest: closest
	gap: gap
	ncircles: ncircles [
	| gapCircle cdistance |
	gaps do: [ :cgap |
		gapCircle := cgap makeGapCircle: (self weight2Rad: (children at: i)).
		cdistance := cbounding distanceTo: gapCircle.
		cdistance < distance ifTrue: [
			cgap circles third ifNotNil: [
				(cgap circles third intersects: gapCircle )
					ifTrue: [ cdistance := Float fmax. ]
			] ifNil: [
				[ :br |
					((bounds findStart: gapCircle) to: ncircles) do: [ :ccircle |
						((circles at: ccircle) intersects: gapCircle)
							ifTrue: [ cdistance := Float fmax. br value ] ]
				] valueWithExit.  ] ].
		cdistance < distance ifTrue: [
			^ { cdistance. gapCircle. cgap}  ].
	].
	^ { distance. closest. gap}
]

{ #category : #initialization }
RSCircularTreeMap >> initialize [
	super initialize.
	shape := self defaultShape.
	self baseRadius: self defaultBaseRadius.
	self weight: 1
]

{ #category : #layout }
RSCircularTreeMap >> layout: aShape [
	| children |
	children := aShape schildren.
	children do: [ :child | self layout: child ].

	children sort: [ :a :b | (self weightOf: a) > (self weightOf: b) ].

	self layoutNodes: children
]

{ #category : #layout }
RSCircularTreeMap >> layoutNodes: children [
	| size circles bounds firstCircle cbounding circle distance scale |
	children ifEmpty: [ ^ self ].
	size := children size min: 100.
	circles := OrderedCollection new: size.

	bounds := RSCircleBounds maxCircles: 100.

	firstCircle := RSCircleTree radius: (self weight2Rad: children first).
	circles add: firstCircle.
	cbounding := bounds push: firstCircle index: 1.
	size > 1 ifTrue: [
		circle := RSCircleTree radius: (self weight2Rad: children second).
		circle
			translateBy: firstCircle center;
			translateBy: (RSCircleVector x: firstCircle radius + circle radius y: 0).
		circles add: circle.
		cbounding := bounds push: circle index: 2.
		size > 2 ifTrue: [
			| gaps closest gap ncircles |
			gaps := OrderedCollection new.
			gaps
				add: (RSCircleGapTree circle1: firstCircle circle2: circle);
				add: (RSCircleGapTree circle1: circle circle2: firstCircle).
			ncircles := 2.
			closest := nil.
			gap := nil.
			(3 to: size) do: [ :i | | arr |
				distance := Float fmax.
				closest := nil.
				gap := nil.
				arr := self
					findBestGapIn: gaps
					children: children
					index: i
					cbounding: cbounding
					bounds: bounds circles: circles
					distance: distance
					closest: closest
					gap: gap
					ncircles: ncircles.

				distance := arr first.
				closest := arr second.
				gap := arr third.

				gaps remove: gap.
				gap addGapsTo: gaps closest: closest.
				circles add: closest.
				ncircles := ncircles + 1.
				(cbounding radius < (distance + closest radius))
					ifTrue: [ cbounding := bounds push: closest index: ncircles  ].

			] ] ].

	scale := 1/ cbounding radius.
	circles doWithIndex: [ :circ :index |
		circ translateBy: (cbounding center scaleBy: -1).
		circ scaleFull: scale.
		(children at: index) propertyAt: #circle put: circ
		].

	^ circles
]

{ #category : #layout }
RSCircularTreeMap >> layoutShapes [
	| virtualRoot |
	virtualRoot := RSEllipse new.
	virtualRoot schildren: rootNodes.
	self
		layout: virtualRoot;
		expandCircles: virtualRoot
			parent: (RSCircleTree radius: self baseRadius)
]

{ #category : #utilities }
RSCircularTreeMap >> relativeToCirble: circle parent: parent [
	| res |
	res := RSCircleTree vector: circle x @ circle y radius: circle radius.
	res scaleFull: parent radius.
	res translateBy: (parent x @ parent y).
	^ res
]

{ #category : #hooks }
RSCircularTreeMap >> renderIn: aCanvas [
	super renderIn: aCanvas.
	self layoutShapes
]

{ #category : #accessing }
RSCircularTreeMap >> shape [
	^ shape
]

{ #category : #hooks }
RSCircularTreeMap >> shapeFor: anObject [
	^ shape copy
		model: anObject;
		yourself
]

{ #category : #weight }
RSCircularTreeMap >> weight2Rad: aShape [
	| aNumber |
	aNumber := self weightOf: aShape.
	^ (aNumber / Float pi) sqrt
]

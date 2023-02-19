"
I create a visualization of hanoi
"
Class {
	#name : #RSHanoiRoassal,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'moves'
	],
	#category : #'Roassal3-Experimental-Hanoi'
}

{ #category : #'meta level' }
RSHanoiRoassal >> animationFor: asso [
	| from to pscale |
	from := self group: asso key.
	to := self group: asso value.
	pscale := nil.
	^ canvas transitionAnimation
		onStepDo: [ :t  | | shapeFrom shapeTo p1 p2 |
			shapeFrom := from last.
			shapeTo := to last.
			p1 := shapeFrom position.
			p2 := shapeTo position.
			pscale ifNil: [
				pscale := NSScale linear
					domain: #(0 0.3 0.6 1);
					range:
						{p1.
						p1 x@0.
						p2 x@0.
						p2 x @ (p2 y - 20)
						}.
				 ].
			shapeFrom position: (pscale scale: t).
			canvas signalUpdate ];
		when: RSAnimationEndEvent do: [
			to addLast: from removeLast. ];
		yourself
]

{ #category : #'meta level' }
RSHanoiRoassal >> createAnimations [
	| allAnimations |
	allAnimations := canvas
		animationFrom: (moves collect: [:asso | self animationFor: asso]).
	allAnimations when: RSAnimationEndEvent do: [ self inform: 'Done!!' ]
]

{ #category : #public }
RSHanoiRoassal >> createBoxFor: index size: size [
	^ RSBox new
		height: size;
		width: index*size;
		position: 0@ (index * size);
		withBorder;
		cornerRadius: 3;
		yourself
]

{ #category : #public }
RSHanoiRoassal >> createCanvasFor: anInteger [
	| color groupA size w |
	canvas := RSCanvas new.
	color := NSScale category20.
	size := 20.
	w := anInteger * size.
	canvas addAll: ((1 to: anInteger)
		collect: [ :i | (self createBoxFor: i size: size)
			color: (color scale: i) ]).

	##(A B C) doWithIndex: [ :sym :i | self createGroup: sym length: anInteger size: size index: i-1. ].
	groupA := canvas propertyAt: #A.
	groupA addAll: canvas nodes reverse.
	canvas camera
		zoomToFit: canvas extent
		rectangle: (w negated@ 0 corner: (w * 3)@(anInteger * size) ) .
	canvas open
		setLabel: 'Hanoi!'.
]

{ #category : #public }
RSHanoiRoassal >> createGroup: aString length: anInteger size: size index: index [
	| w g l |
	canvas propertyAt: aString put: (g:= RSGroup new).
	w := anInteger * size.
	l := RSLabel new
		text: aString;
		position: (index * (w + (w * 0.1))) @ ((anInteger + 1) * size);
		yourself.
	canvas addShape: l.
	g add: l
]

{ #category : #'meta level' }
RSHanoiRoassal >> createLink [
	| node link |
	node := (RSHanoi >> #moveFrom:to:) ast.
	moves := OrderedCollection new.
	link :=  MetaLink new
		arguments: #(context);
		selector: #value:;
		metaObject: [ :context | | a b |
			a := context tempNamed: #a.
			b := context tempNamed: #b.
			moves add: a-> b ];
		yourself.
	node link: link.
	^ link
]

{ #category : #public }
RSHanoiRoassal >> createLinkAnCanvas: anInteger [
	self createCanvasFor: anInteger.
	^ self createLink
]

{ #category : #'meta level' }
RSHanoiRoassal >> group: key [
	^ canvas propertyAt: key
]

{ #category : #running }
RSHanoiRoassal >> run [
	<script: 'self new run'>
	| link size res |
	size := 3.
	link := self createLinkAnCanvas: size.
	res := RSHanoi new hanoi: size from: 'A' bridge: 'B' to: 'C'.
	link uninstall.
	[self createAnimations ] on: Error do: [ :ex | self inform: ex asString ].
	^ res
]

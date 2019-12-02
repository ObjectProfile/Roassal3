"
I am a specific interaction based on the example23RotatedAnimation
"
Class {
	#name : #RSRotatedPieLabel,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'pieBuilder',
		'animation'
	],
	#category : #'Roassal3-Pie-Decorators'
}

{ #category : #hooks }
RSRotatedPieLabel >> onElement: view [
	| lines update |
	lines := RSEdgeBuilder polyline
		dashArray: #(4);
		edgesOn: pieBuilder labelElements.
	view addAll: lines.
	pieBuilder elements do: [ :e |
		| a b |
		e attributes
			at: #a put: (a := e alphaAngle);
			at: #b put: (b := e betaAngle).
		(b - a) < 4 ifTrue: [ | line |
			line := lines at: e index.
			line border: nil.
			line model noPaint.
			 ]
		 ].
	pieBuilder elements when: RSMouseClick do: [ animation toggle ].
	update := [ :t |
		pieBuilder elements do: [ :e | 
			| att a b ang ext x p1 p2 p3 line l |
			att := e attributes.
			a := att at: #a.
			b := att at: #b.
			e 
				alphaAngle: a + t;
				betaAngle: b + t.
			l := pieBuilder labelElements at: e index.
			ang := ((e alphaAngle + e betaAngle)/2) %360.
			ext := l extent x/2 @ 0.
			x := -250.
			(ang between: 90 and: 270) ifFalse: [ 
				ext := ext negated.
				x := x negated ].
			p1 := e centroid: 0.
			p2 := e centroid: 50.
			p3 := x @ p2 y.
			line := lines at: e index.
			line shape 
				controlPoints: { p1. p2. p3 }.
			l position: p3-ext.
			 ] ].
	update value: 0.
	animation := view newAnimation
		from: 0; 
		to: 360; repeat; 
		duration: 15 seconds;
		onStepDo: update.
]

{ #category : #hooks }
RSRotatedPieLabel >> pieBuilder [
	^ pieBuilder
]

{ #category : #hooks }
RSRotatedPieLabel >> pieBuilder: aBuilder [
	pieBuilder := aBuilder
]

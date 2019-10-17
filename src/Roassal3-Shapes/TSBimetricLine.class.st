"
I am a line with different sizes in each side.

Here is how to use it, from Roassal code
```
| view e1 e2 box l |
	view := RSView new.
	box := RSShapeBuilder box 
		size: 100;
		draggable.
	e1 := box element.
	e1 color: Color blue.
	e2 := box element.
	e2 translateTo: 400@0.
	l := RSSingleEdgeBuilder bimetricLine
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: e1;
		to: e2;
		edge.
	view addAll: { e1. e2. l}.
	view @ RSControlsView. 
	view open
```
"
Class {
	#name : #TSBimetricLine,
	#superclass : #TSSVGPathLine,
	#instVars : [
		'widthFrom',
		'widthTo'
	],
	#category : #'Roassal3-Shapes-Core'
}

{ #category : #initialization }
TSBimetricLine >> initialize [
	super initialize.
	widthFrom := widthTo := 0.
	self initializeSVG.
]

{ #category : #initialization }
TSBimetricLine >> initializeSVG [
	self svgPath: [ :from :to | 
		| e w1 w2 dist z |
		e := 0.001.
		w1 := widthTo max: e.
		w2 := widthFrom max: e.
		dist := from distanceTo: to.
		dist := dist max: e.
		z := (w1 + w2)*2.
		z > dist ifTrue: [ 
			w1 := w1 * dist / z.
			w2 := w2 * dist / z.
			 ].
		
		[ :builder | | first side |
			first := true.
			side := [ :vector :end :size |
				| left right u unit middle l r |
				u := vector normal.
				unit := vector / (vector r max: e).
				middle := end - (unit * size).
				left := (middle - (u * size)) asFloatPoint.
				l := (end - (u * size)) asFloatPoint.
				right := (middle + (u * size)) asFloatPoint.
				r := (end + (u * size)) asFloatPoint.
				first 
					ifTrue: [ builder moveTo: left ]
					ifFalse: [ builder lineTo: left ].
				builder
					curveVia: l to: end;
					curveVia: r to: right.
				 ].
			builder absolute.
			side value: to - from value: to value: w1 / 2.
			first := false.
			side value: from - to value: from value: w2 / 2.
			builder close.
			
			].
		].
]

{ #category : #accessing }
TSBimetricLine >> widthFrom [
	^ widthFrom
]

{ #category : #accessing }
TSBimetricLine >> widthFrom: aNumber [
	widthFrom := aNumber
]

{ #category : #accessing }
TSBimetricLine >> widthTo [
	^ widthTo
]

{ #category : #accessing }
TSBimetricLine >> widthTo: aNumber [
	widthTo := aNumber
]

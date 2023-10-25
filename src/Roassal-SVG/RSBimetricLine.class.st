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
	#name : 'RSBimetricLine',
	#superclass : 'RSSVGPathLine',
	#instVars : [
		'widthFrom',
		'widthTo'
	],
	#category : 'Roassal-SVG-Shapes',
	#package : 'Roassal-SVG',
	#tag : 'Shapes'
}

{ #category : 'accessing - computed' }
RSBimetricLine >> computeEncompassingRectangle [
	| p1 p2 b points |
	points := OrderedCollection new.
	p1 := startPoint.
	p2 := endPoint.
	b := RSBorder new.
	b width: self widthFrom.
	b expandPoint: p1 to: p2.
	b width: self widthTo.
	p2 := b expandPoint: p2 to: p1.
	border := b.
	b width: self widthFrom.
	self addTwoPointsBasedInWidthFrom: p1 to: p2 in: points.
	b width: self widthTo.
	self addTwoPointsBasedInWidthFrom: p2 to: p1 in: points.
	border := nil.
	^ Rectangle encompassing: points.
]

{ #category : 'initialization' }
RSBimetricLine >> initialize [
	super initialize.
	widthFrom := widthTo := 0.
	self initializeSVG
]

{ #category : 'initialization' }
RSBimetricLine >> initializeSVG [
	self
		svgPath: [ :aLine |
			| e w1 w2 dist z sourcePoint targetPoint |
			sourcePoint := aLine startPoint.
			targetPoint := aLine endPoint.
			e := 0.001.
			w1 := aLine widthTo max: e.
			w2 := aLine widthFrom max: e.
			dist := sourcePoint distanceTo: targetPoint.
			dist := dist max: e.
			z := (w1 + w2) * 2.
			z > dist
				ifTrue: [ w1 := w1 * dist / z.
					w2 := w2 * dist / z ].
			[ :builder |
			| first side |
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
				curveVia: r to: right ].
			builder absolute.
			side
				value: targetPoint - sourcePoint
				value: targetPoint
				value: w1 / 2.
			first := false.
			side
				value: sourcePoint - targetPoint
				value: sourcePoint
				value: w2 / 2.
			builder close ] ]
]

{ #category : 'accessing' }
RSBimetricLine >> widthFrom [
	^ widthFrom
]

{ #category : 'accessing' }
RSBimetricLine >> widthFrom: aNumber [
	widthFrom := aNumber
]

{ #category : 'accessing' }
RSBimetricLine >> widthTo [
	^ widthTo
]

{ #category : 'accessing' }
RSBimetricLine >> widthTo: aNumber [
	widthTo := aNumber
]

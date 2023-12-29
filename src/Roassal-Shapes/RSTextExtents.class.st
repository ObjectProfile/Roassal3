"
Extents for RSLabel
"
Class {
	#name : 'RSTextExtents',
	#superclass : 'RSObject',
	#instVars : [
		'width',
		'height',
		'x_advance',
		'y_advance',
		'x_bearing',
		'y_bearing'
	],
	#classVars : [
		'EmptyExtents'
	],
	#category : 'Roassal-Shapes-TextMetrics',
	#package : 'Roassal-Shapes',
	#tag : 'TextMetrics'
}

{ #category : 'requirements' }
RSTextExtents class >> empty [
	^ EmptyExtents ifNil: [ EmptyExtents := self new empty ]
]

{ #category : 'public' }
RSTextExtents >> empty [
	self
		width: 0;
		height: 0;
		x_advance: 0;
		y_advance: 0;
		x_bearing: 0;
		y_bearing: 0
]

{ #category : 'public' }
RSTextExtents >> from: ref [
	"ref is a CairoTextExtents"
	self
		width: ref width;
		height: ref height;
		x_advance: ref x_advance;
		y_advance: ref y_advance;
		x_bearing: ref x_bearing;
		y_bearing: ref y_bearing
]

{ #category : 'accessing' }
RSTextExtents >> height [
	^ height
]

{ #category : 'accessing' }
RSTextExtents >> height: aNumber [
	height := aNumber
]

{ #category : 'printing' }
RSTextExtents >> printOn: s [
	s << self className; << '('.
	#(x_bearing y_bearing width height x_advance y_advance) do: [ :sel |
		s << sel; << ':'; << String tab.
		(sel value: self) printOn: s.
		 ] separatedBy: [ s << String crlf ].
	s << ')'
]

{ #category : 'public' }
RSTextExtents >> translationPoint [
	| ybn |
	ybn := y_bearing negated.
	^ ((( width + x_bearing / -2) )  @ 0) + (0@((ybn/2)- ((height- ybn)/2)))
]

{ #category : 'accessing' }
RSTextExtents >> width [
	^ width
]

{ #category : 'accessing' }
RSTextExtents >> width: aNumber [
	width := aNumber
]

{ #category : 'accessing' }
RSTextExtents >> x_advance [
	^ x_advance
]

{ #category : 'accessing' }
RSTextExtents >> x_advance: aNumber [
	x_advance := aNumber
]

{ #category : 'accessing' }
RSTextExtents >> x_bearing [
	^ x_bearing
]

{ #category : 'accessing' }
RSTextExtents >> x_bearing: aNumber [
	x_bearing := aNumber
]

{ #category : 'accessing' }
RSTextExtents >> y_advance [
	^ y_advance
]

{ #category : 'accessing' }
RSTextExtents >> y_advance: aNumber [
	y_advance := aNumber
]

{ #category : 'accessing' }
RSTextExtents >> y_bearing [
	^ y_bearing
]

{ #category : 'accessing' }
RSTextExtents >> y_bearing: aNumber [
	y_bearing := aNumber
]

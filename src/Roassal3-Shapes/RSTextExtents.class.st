"
Extents for RSLabel
"
Class {
	#name : #RSTextExtents,
	#superclass : #RSObject,
	#instVars : [
		'width',
		'height',
		'x_advance',
		'y_advance',
		'x_bearing',
		'y_bearing'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #public }
RSTextExtents >> from: ref [ 
	"ref is a CairoTextExtents"
	self 
		width: ref width;
		height: ref height;
		x_advance: ref x_advance;
		y_advance: ref y_advance;
		x_bearing: ref x_bearing;
		y_bearing: ref y_bearing.

]

{ #category : #accessing }
RSTextExtents >> height [
	^ height
]

{ #category : #accessing }
RSTextExtents >> height: aNumber [
	height := aNumber
]

{ #category : #accessing }
RSTextExtents >> width [
	^ width
]

{ #category : #accessing }
RSTextExtents >> width: aNumber [
	width := aNumber
]

{ #category : #accessing }
RSTextExtents >> x_advance [
	^ x_advance
]

{ #category : #accessing }
RSTextExtents >> x_advance: aNumber [
	x_advance := aNumber
]

{ #category : #accessing }
RSTextExtents >> x_bearing [
	^ x_bearing
]

{ #category : #accessing }
RSTextExtents >> x_bearing: aNumber [
	x_bearing := aNumber
]

{ #category : #accessing }
RSTextExtents >> y_advance [
	^ y_advance
]

{ #category : #accessing }
RSTextExtents >> y_advance: aNumber [
	y_advance := aNumber
]

{ #category : #accessing }
RSTextExtents >> y_bearing [
	^ y_bearing
]

{ #category : #accessing }
RSTextExtents >> y_bearing: aNumber [
	y_bearing := aNumber
]

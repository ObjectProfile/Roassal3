"
TODO
"
Class {
	#name : #RSSVGPath,
	#superclass : #RSBoundingShape,
	#instVars : [
		'svgPath',
		'segments',
		'polygons'
	],
	#category : #'Roassal3-SVG-Shapes'
}

{ #category : #visiting }
RSSVGPath >> buildPathOn: visitor [
	visitor buildSVGPath: self.
]

{ #category : #private }
RSSVGPath >> centerSegment: segment absolute: absolute position: position [
	"maybe we can have an iterator with polymorphic objects"
	| key args |
	key := segment first.
	args := segment second.
	key = #absolute ifTrue: [ ^ true ].
	key = #relative ifTrue: [ ^ false ].
	(key = #ellipticalArc:xrot:large:sweep:to:relative:) ifTrue: [ 
		absolute ifTrue: [ 
			args at: 5 put: args fifth - position.
			args at: 6 put: false ].
		^ absolute ].
	key = #vLineTo: ifTrue: [ 
		absolute ifTrue: [ args at: 1 put: args first - position y ]. 
		^ absolute].
	key = #hLineTo: ifTrue: [ 
		absolute ifTrue: [ args at: 1 put: args first - position x ]. 
		^ absolute].
	absolute ifTrue: [ 
		args doWithIndex: [ :point :index | 
			args at: index put: point - position ] ].
	^ absolute
]

{ #category : #private }
RSSVGPath >> centerSegments [
	| rect absolute position |
	rect := self segmentsRectangle.
	position := rect floatCenter.
	absolute := true.
	segments do: [ :segment | 
		absolute := self 
			centerSegment: segment 
			absolute: absolute 
			position: position  ].
				
	polygons do: [ :polygon |
		polygon doWithIndex: [ :point :index |
			polygon at: index put: point - position ] ].
	rect := self segmentsRectangle.
	self position: position.
	baseRectangle := Rectangle floatCenter: 0@0 extent: rect extent.
]

{ #category : #private }
RSSVGPath >> computePolygons [
	| subPath absolute position point |
	polygons := OrderedCollection new.
	subPath := OrderedCollection new.
	absolute := true.
	position := 0@0.
	point := [:da | position := absolute 
		ifTrue:[ da ] 
		ifFalse: [ position + da ].
		subPath add: position ].
	segments do: [ :segment | | key args |
		key := segment first.
		args := segment second.
		key = #absolute ifTrue: [ absolute := true ].
		key = #relative ifTrue: [ absolute := false ].
		key = #moveTo: ifTrue: [ 
			subPath ifNotEmpty: [ 
				polygons add: subPath ]. 
			subPath:= OrderedCollection new.
			point value: args first ].
		key = #close ifTrue: [ 
			position := subPath first ].
		key = #curveVia:and:to: ifTrue: [ 
			point value: args third ].
		key = #curveVia:to: ifTrue: [ 
			point value: args second ].
		key = #lineTo: ifTrue: [ 
			point value: args first ].
		key = #reflectedCurveVia:to: ifTrue: [ 
			point value: args second ].
		key = #ellipticalArc:xrot:large:sweep:to:relative: ifTrue: [ 
			point value: args fifth ].
		key = #hLineTo: ifTrue: [
			position := absolute
				ifTrue: [ args first @ position y ]
				ifFalse: [ position + (args first @ 0) ].
			subPath add: position ].
		key = #vLineTo: ifTrue: [ 
			position := absolute
				ifTrue: [ position x @ args first ]
				ifFalse: [ position + (0 @ args first) ].
			subPath add: position ].
		].
	polygons add: subPath
	


]

{ #category : #private }
RSSVGPath >> computeSegments [
	| pathData | 
	pathData := ASPathConverter new stream: svgPath readStream.
	segments := pathData convertPathData.
]

{ #category : #accessing }
RSSVGPath >> extent: newExtent [
	| min max s extent |
	segments ifNil: [ ^ self ].
	extent := baseRectangle extent.
	extent = newExtent 
		ifTrue: [ ^ self ].
	min := self position - (extent / 2).
	max := self position + (extent / 2).
	s := newExtent / (max - min).
	segments do: [ :segment | | args |
		args := segment second.
		args doWithIndex: [ :point :index |
			args at: index put: (point isPoint
				ifTrue: [ point * s ]
				ifFalse: [ point * s x ] ) ] ].
	polygons do: [ :polygon|
		polygon doWithIndex: [ :point :index |
			polygon at: index put: point * s ]  ].
	super extent: newExtent.
]

{ #category : #testing }
RSSVGPath >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix rsInverseTransform: aPoint.
	
	^ (self baseRectangle containsPoint: invertedPoint)
		ifFalse: [ false ]
		ifTrue: [ | apt |
			apt := AthensPolygonTester new.
			polygons anySatisfy: [ :eachPolygon | 
				(apt polygon: eachPolygon) includesPoint: invertedPoint]]
]

{ #category : #accessing }
RSSVGPath >> segments [
	^ segments
]

{ #category : #private }
RSSVGPath >> segments: aCollection [
	segments := aCollection
]

{ #category : #private }
RSSVGPath >> segmentsRectangle [
	| allPoints |
	allPoints := polygons flatCollect: [:poly | poly ].
	^ Rectangle encompassing: allPoints
]

{ #category : #accessing }
RSSVGPath >> svgPath [ 
	^ svgPath
]

{ #category : #accessing }
RSSVGPath >> svgPath: aString [ 
	svgPath := aString.
	self computeSegments.
	self computePolygons.
	self centerSegments.
	self resetPath.
]

"
TODO
"
Class {
	#name : #TSSVGPath,
	#superclass : #TSBoundingShape,
	#instVars : [
		'svgPath',
		'segments',
		'polygons'
	],
	#category : #'Roassal3-Shapes'
}

{ #category : #visiting }
TSSVGPath >> buildPathOn: visitor [
	visitor buildSVGPath: self.
]

{ #category : #private }
TSSVGPath >> centerSegments [
	| rect absolute position |
	rect := self segmentsRectangle.
	position := rect rsCenter.
	absolute := true.
	segments do: [ :segment | 
		| key args |
		key := segment first.
		args := segment second.
		key = #absolute ifTrue: [ absolute := true ].
		key = #relative ifTrue: [ absolute := false ].
		absolute ifTrue: [ 
			args doWithIndex: [ :point :index | 
				point isPoint 
					ifTrue: [ args at: index put: point - position ]
					ifFalse: [ args at: index put: point - position x ] ] ] ].
				
	polygons do: [ :polygon |
		polygon doWithIndex: [ :point :index |
			polygon at: index put: point - position ] ].
	rect := self segmentsRectangle.
	self position: position.
	baseRectangle := Rectangle rsCenter: 0@0 extent: rect extent.
]

{ #category : #private }
TSSVGPath >> computePolygons [
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
			subPath ifNotEmpty: [ polygons add: subPath ]. 
			subPath:= OrderedCollection new.
			point value: args first ].
		key = #curveVia:and:to: ifTrue: [ 
			point value: args third ].
		key = #curveVia:to: ifTrue: [ 
			point value: args second ].
		key = #lineTo: ifTrue: [ 
			point value: args first ].
		key = #reflectedCurveVia:to: ifTrue: [ 
			point value: args second ].
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
TSSVGPath >> computeSegments [
	| pathData | 
	pathData := ASPathConverter new stream: svgPath readStream.
	segments := pathData convertPathData.
]

{ #category : #accessing }
TSSVGPath >> extent: newExtent [
	| min max s extent |
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

{ #category : #accessing }
TSSVGPath >> segments [
	^ segments
]

{ #category : #private }
TSSVGPath >> segmentsRectangle [
	| allPoints |
	allPoints := polygons flatCollect: [:poly | poly ].
	^ Rectangle encompassing: allPoints
]

{ #category : #accessing }
TSSVGPath >> svgPath [ 
	^ svgPath
]

{ #category : #accessing }
TSSVGPath >> svgPath: aString [ 
	svgPath := aString.
	self computeSegments.
	self computePolygons.
	self centerSegments.
	self resetPath.
]

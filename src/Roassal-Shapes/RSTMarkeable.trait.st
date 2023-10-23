"
I am a trait to create markers in some especific classes
"
Trait {
	#name : 'RSTMarkeable',
	#category : 'Roassal-Shapes-Traits',
	#package : 'Roassal-Shapes',
	#tag : 'Traits'
}

{ #category : 'testing' }
RSTMarkeable >> hasMarkers [
	| m |
	m := self privateMarkers.
	^ m notNil and: [
		m anySatisfy: [ :mar | mar notNil ].  ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> marker: aMarker [
	| m |
	m := aMarker asMarker.
	self
		markerStart: m;
		markerMid: m;
		markerEnd: m.
	^ m
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerEnd [
	^ self markers
		ifNil: [ nil ]
		ifNotNil: [ :m | m third ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerEnd: marker [
	| m |
	marker ifNil: [ ^ nil ].
	m := marker asMarker.
	self markers at: 3 put: m.
	^ m
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerMid [
	^ self markers
		ifNil: [ nil ]
		ifNotNil: [ :m | m second ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerMid: marker [
	| m |
	marker ifNil: [ ^ nil ].
	m := marker asMarker.
	self markers at: 2 put: m.
	^ m
]

{ #category : 'public' }
RSTMarkeable >> markerShapesInPositionDo: aBlock [
	| cp |
	cp := self controlPoints.
	self markerStart ifNotNil: [ :marker | marker withStart: cp do: aBlock ].
	self markerMid ifNotNil: [ :marker | marker withMid: cp do: aBlock ].
	self markerEnd ifNotNil: [ :marker | marker withEnd: cp do: aBlock ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerStart [
	^ self markers
		ifNil: [ nil ]
		ifNotNil: [ :m | m first ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerStart: marker [
	| m |
	marker ifNil: [ ^ nil ].
	m := marker asMarker.
	self markers at: 1 put: m.
	^ m
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markerStartEnd: aMarker [
	| m |
	m := aMarker asMarker.
	self
		markerStart: m;
		markerEnd: m.
	^ m
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markers [
	^ self privateMarkers
		ifNil: [ | array |
			array := Array new: 3.
			self privateMarkers: array.
			array ]
]

{ #category : 'accessing - markers' }
RSTMarkeable >> markersDo: block [
	self markers do: [ :m | m ifNotNil: block  ]
]

{ #category : 'testing' }
RSTMarkeable >> markersIncludesPoint: aPoint [
	self hasMarkers ifFalse: [ ^ false ].
	self markerShapesInPositionDo: [ :m |
		(m shape preciseIncludesPoint: aPoint)
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'accessing - markers' }
RSTMarkeable >> privateMarkers [
	^ self explicitRequirement
]

{ #category : 'accessing - markers' }
RSTMarkeable >> privateMarkers: array [
	 self explicitRequirement
]

{ #category : 'public' }
RSTMarkeable >> resetMarkers [
	self privateMarkers: nil
]

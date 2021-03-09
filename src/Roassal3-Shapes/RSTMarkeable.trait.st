"
I am a trait to create markers in some especific classes
"
Trait {
	#name : #RSTMarkeable,
	#category : #'Roassal3-Shapes-Traits'
}

{ #category : #testing }
RSTMarkeable >> hasMarkers [
	| m |
	m := self privateMarkers.
	^ m notNil and: [ 
		m anySatisfy: [ :mar | mar notNil ].  ]
]

{ #category : #'accessing - markers' }
RSTMarkeable >> marker: aMarker [
	| m |
	m := aMarker asMarker. 
	self 
		markerStart: m;
		markerMid: m;
		markerEnd: m.
	^ m
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerEnd [
	^ self markers third.
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerEnd: marker [
	| m| 
	m := marker asMarker.
	self markers at: 3 put: m.
	^ m
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerMid [
	^ self markers second.
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerMid: marker [
	| m | 
	m := marker asMarker.
	self markers at: 2 put: m.
	^ m
]

{ #category : #public }
RSTMarkeable >> markerShapesInPositionDo: aBlock [
	| cp |
	cp := self controlPoints.
	self markerStart ifNotNil: [ :marker | marker withStart: cp do: aBlock ].
	self markerMid ifNotNil: [ :marker | marker withMid: cp do: aBlock ].
	self markerEnd ifNotNil: [ :marker | marker withEnd: cp do: aBlock ].
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerStart [ 
	^ self markers first.
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerStart: marker [
	| m | 
	m := marker asMarker.
	self markers at: 1 put: m.
	^ m
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markerStartEnd: aMarker [
	| m |
	m := aMarker asMarker. 
	self 
		markerStart: m;
		markerEnd: m.
	^ m
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markers [
	^ self privateMarkers
]

{ #category : #'accessing - markers' }
RSTMarkeable >> markersDo: block [
	self markers do: [ :m | m ifNotNil: block  ].
]

{ #category : #testing }
RSTMarkeable >> markersIncludesPoint: aPoint [ 
	self hasMarkers ifFalse: [ ^ false ].
	self markerShapesInPositionDo: [ :m | 
		(m shape includesPoint: aPoint) 
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'accessing - markers' }
RSTMarkeable >> privateMarkers [
	^ self explicitRequirement
]

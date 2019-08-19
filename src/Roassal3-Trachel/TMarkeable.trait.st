"
I am a trait to create markers in some especific classes
"
Trait {
	#name : #TMarkeable,
	#category : #'Roassal3-Trachel-Shape'
}

{ #category : #'accessing - markers' }
TMarkeable >> marker: aMarker [
	| m |
	m := aMarker asMarker. 
	self 
		markerStart: m;
		markerMid: m;
		markerEnd: m.
	^ m
]

{ #category : #'accessing - markers' }
TMarkeable >> markerEnd [
	^ self markers third.
]

{ #category : #'accessing - markers' }
TMarkeable >> markerEnd: marker [
	| m| 
	m := marker asMarker.
	self markers at: 3 put: m.
	^ m
]

{ #category : #'accessing - markers' }
TMarkeable >> markerMid [
	^ self markers second.
]

{ #category : #'accessing - markers' }
TMarkeable >> markerMid: marker [
	| m| 
	m := marker asMarker.
	self markers at: 2 put: m.
	^ m
]

{ #category : #'accessing - markers' }
TMarkeable >> markerStart [ 
	^ self markers first.
]

{ #category : #'accessing - markers' }
TMarkeable >> markerStart: marker [
	| m| 
	m := marker asMarker.
	self markers at: 1 put: m.
	^ m
]

{ #category : #'accessing - markers' }
TMarkeable >> markerStartEnd: aMarker [
	| m |
	m := aMarker asMarker. 
	self 
		markerStart: m;
		markerEnd: m.
	^ m
]

{ #category : #'accessing - markers' }
TMarkeable >> markers [
	^ nil
]

{ #category : #'accessing - markers' }
TMarkeable >> markersDo: block [
	self markers do: [ :m | m ifNotNil: block  ].
]

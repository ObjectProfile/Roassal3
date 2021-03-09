"
TODO
"
Class {
	#name : #RSGraphVizLine,
	#superclass : #RSSVGPathLine,
	#category : #'Roassal3-GraphViz'
}

{ #category : #initialization }
RSGraphVizLine >> color [
	^ self border color
]

{ #category : #initialization }
RSGraphVizLine >> color: aColor [
	self strokeColor: aColor
]

{ #category : #accessing }
RSGraphVizLine >> controlPoints [ 
	^ self propertyAt: #points ifAbsent: [ super controlPoints ]
]

{ #category : #initialization }
RSGraphVizLine >> initialize [
	super initialize.
	self setSVGPath.
	
]

{ #category : #testing }
RSGraphVizLine >> intersects: aRectangle [
	^ true
]

{ #category : #initialization }
RSGraphVizLine >> manyPointsFor: edge [
	
	^ String streamContents: [ :s | 
		| addPoint points|
		addPoint:= [ :p |
			s << p x asString; space; << p y asString; space ].
		points := edge propertyAt: #points.
		points := points readStream.
		s << 'M'.
		addPoint value: points next.
		s << 'C'.
		[ points atEnd ] whileFalse: [ 
			addPoint value: points next
		 ]
	].
	
]

{ #category : #initialization }
RSGraphVizLine >> setSVGPath [
	self svgPath: [ :edge | 
		(edge hasProperty: #points) 
			ifTrue:  [ self manyPointsFor: edge ] 
			ifFalse: [ self twoPointsFor: edge ]
	 ].
	
]

{ #category : #initialization }
RSGraphVizLine >> twoPointsFor: edge [
	| pos1 pos2 |
	edge from ifNil: [ ^ 'M0 0 L100 100' ].
	pos1 := edge from position.
	pos2 := edge to position. 
	^ 'M {1} {2} L {3} {4}' format: { pos1 x. pos1 y. pos2 x. pos2 y  }. 

]

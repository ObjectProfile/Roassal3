"
TODO
"
Class {
	#name : #RSGraphvizLine,
	#superclass : #RSSVGPathLine,
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #initialization }
RSGraphvizLine >> color [
	^ self border color
]

{ #category : #initialization }
RSGraphvizLine >> color: aColor [
	self strokeColor: aColor
]

{ #category : #accessing }
RSGraphvizLine >> controlPoints [
	^ self propertyAt: #points ifAbsent: [ super controlPoints ]
]

{ #category : #initialization }
RSGraphvizLine >> initialize [
	super initialize.
	self setSVGPath
]

{ #category : #testing }
RSGraphvizLine >> intersects: aRectangle [
	^ true
]

{ #category : #initialization }
RSGraphvizLine >> manyPointsFor: edge [

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
	]
]

{ #category : #initialization }
RSGraphvizLine >> setSVGPath [
	self svgPath: [ :edge |
		(edge hasProperty: #points)
			ifTrue:  [ self manyPointsFor: edge ]
			ifFalse: [ self twoPointsFor: edge ]
	 ]
]

{ #category : #initialization }
RSGraphvizLine >> twoPointsFor: edge [
	| pos1 pos2 |
	edge from ifNil: [ ^ 'M0 0 L100 100' ].
	pos1 := edge from position.
	pos2 := edge to position.
	^ 'M {1} {2} L {3} {4}' format: { pos1 x. pos1 y. pos2 x. pos2 y  }.
]

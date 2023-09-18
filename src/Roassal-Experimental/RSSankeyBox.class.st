"
I represent boxes drawn in sankey charts
"
Class {
	#name : #RSSankeyBox,
	#superclass : #RSBox,
	#instVars : [
		'sourceLinks',
		'targetLinks',
		'y',
		'dy',
		'x',
		'value',
		'last'
	],
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #accessing }
RSSankeyBox >> center [

	^ self y + (self dy / 2)
]

{ #category : #computing }
RSSankeyBox >> computeLinesDepths [

	| sy ty |
	self sortLinks.
	sy := ty := 0.
	sourceLinks do: [ :line |
		line sy: sy.
		sy := sy + line dy ].
	targetLinks do: [ :line |
		line ty: ty.
		ty := ty + line dy ]
]

{ #category : #computing }
RSSankeyBox >> computeValue [

	self value:
		((self sumLinks: sourceLinks) max: (self sumLinks: targetLinks))
]

{ #category : #accessing }
RSSankeyBox >> dy [

	^ dy
]

{ #category : #accessing }
RSSankeyBox >> dy: anObject [

	dy := anObject
]

{ #category : #accessing }
RSSankeyBox >> last [

	^ last ifNil: [ false ]
]

{ #category : #accessing }
RSSankeyBox >> last: aBoolean [

	last := aBoolean
]

{ #category : #computing }
RSSankeyBox >> relaxLeftToRight: alpha [

	targetLinks ifNotEmpty: [
		| averageY |
		averageY := (targetLinks sum: [ :line | line weightedSource ])
		            / (targetLinks sum: [ :line | line value ]).
		self y: y + (alpha * (averageY - self center)) ]
]

{ #category : #computing }
RSSankeyBox >> relaxRightToLeft: alpha [

	sourceLinks ifNotEmpty: [
		| averageY |
		averageY := (sourceLinks sum: [ :line | line weightedTarget ])
		            / (sourceLinks sum: [ :line | line value ]).
		self y: y + (alpha * (averageY - self center)) ]
]

{ #category : #computing }
RSSankeyBox >> sortLinks [

	sourceLinks sort: [ :a1 :b1 | a1 to y < b1 to y ].
	targetLinks sort: [ :a :b | a from y < b from y ]
]

{ #category : #accessing }
RSSankeyBox >> sourceLinks [

	^ sourceLinks
]

{ #category : #accessing }
RSSankeyBox >> sourceLinks: aCollection [

	sourceLinks := aCollection
]

{ #category : #computing }
RSSankeyBox >> sumLinks: aCollectionOfLinks [

	^ aCollectionOfLinks
		  inject: 0
		  into: [ :sum :link | link value + sum ]
]

{ #category : #accessing }
RSSankeyBox >> targetLinks [

	^ targetLinks
]

{ #category : #accessing }
RSSankeyBox >> targetLinks: aCollection [

	targetLinks := aCollection
]

{ #category : #accessing }
RSSankeyBox >> value [

	^ value
]

{ #category : #accessing }
RSSankeyBox >> value: anObject [

	value := anObject
]

{ #category : #accessing }
RSSankeyBox >> x [

	^ x
]

{ #category : #accessing }
RSSankeyBox >> x: anObject [

	x := anObject
]

{ #category : #accessing }
RSSankeyBox >> y [

	^ y
]

{ #category : #accessing }
RSSankeyBox >> y: anObject [

	y := anObject
]

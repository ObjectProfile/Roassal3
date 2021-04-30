"
TODO
"
Class {
	#name : #RSSankeyLink,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to',
		'value'
	],
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #accessing }
RSSankeyLink >> from [

	^ from
]

{ #category : #accessing }
RSSankeyLink >> from: anObject [

	from := anObject
]

{ #category : #printing }
RSSankeyLink >> printOn: stream [
	stream
		<< from
		<< ' → '
		<< to.
]

{ #category : #accessing }
RSSankeyLink >> to [

	^ to
]

{ #category : #accessing }
RSSankeyLink >> to: anObject [

	to := anObject
]

{ #category : #accessing }
RSSankeyLink >> value [

	^ value
]

{ #category : #accessing }
RSSankeyLink >> value: anObject [

	value := anObject
]

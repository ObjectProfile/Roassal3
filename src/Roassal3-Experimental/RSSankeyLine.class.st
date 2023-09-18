"
I represent lines drawn in sankey charts, these lines have instance variables used by Sankey layout algorithmn
"
Class {
	#name : #RSSankeyLine,
	#superclass : #RSBezier,
	#instVars : [
		'sy',
		'dy',
		'ty',
		'value'
	],
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #accessing }
RSSankeyLine >> dy [

	^ dy
]

{ #category : #accessing }
RSSankeyLine >> dy: anObject [

	dy := anObject
]

{ #category : #accessing }
RSSankeyLine >> sy [

	^ sy
]

{ #category : #accessing }
RSSankeyLine >> sy: anObject [

	sy := anObject
]

{ #category : #accessing }
RSSankeyLine >> ty [

	^ ty
]

{ #category : #accessing }
RSSankeyLine >> ty: anObject [

	ty := anObject
]

{ #category : #accessing }
RSSankeyLine >> value [

	^ value
]

{ #category : #accessing }
RSSankeyLine >> value: anObject [

	value := anObject
]

{ #category : #computing }
RSSankeyLine >> weightedSource [

	^ self from center * self value
]

{ #category : #computing }
RSSankeyLine >> weightedTarget [

	^ self to center * self value
]

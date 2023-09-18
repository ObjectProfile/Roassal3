"
I represent links between sankey charts nodes
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

{ #category : #'instance creation' }
RSSankeyLink class >> on: anAssociation [

	^ self new
		  from: anAssociation key key;
		  to: anAssociation value;
		  value: anAssociation key value;
		  yourself
]

{ #category : #comparing }
RSSankeyLink >> = anObject [

	^ anObject class == self class and: [
		  anObject from = self from and: [
			  anObject to = self to and: [ anObject value = self value ] ] ]
]

{ #category : #accessing }
RSSankeyLink >> from [

	^ from
]

{ #category : #accessing }
RSSankeyLink >> from: anObject [

	from := anObject
]

{ #category : #comparing }
RSSankeyLink >> hash [

	^ self from hash bitXor: (self to hash bitXor: self value hash)
]

{ #category : #printing }
RSSankeyLink >> printOn: stream [
	stream
		<< from
		<< ' → '
		<< to
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

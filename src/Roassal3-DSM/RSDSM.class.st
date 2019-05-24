"
RTDSM build a Dependency Structural Matrix for a collection of objects and an arbitrary dependency function.

For example, inspect the following:
[[[ 
	| dsm |
	dsm := RTDSM new.
	dsm objects: TSShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	dsm build.
	^ dsm open
]]]
"
Class {
	#name : #RSDSM,
	#superclass : #RSAbstractDSM,
	#instVars : [
		'dependency'
	],
	#category : #'Roassal3-DSM'
}

{ #category : #examples }
RSDSM class >> example01 [
	<script: 'self example01 inspect'>
	| dsm |
	dsm := RSDSM new.
	dsm objects: RTShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	^ dsm
]

{ #category : #examples }
RSDSM class >> example02 [
	<script: 'self example02 inspect'>
	| dsm |
	dsm := RSDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	^ dsm
]

{ #category : #examples }
RSDSM class >> example03 [
	<script: 'self example03 inspect'>
	| values b |
	values := (Array
		with: (1 -> #(A B C))
		with: (2 -> #(A C))
		with: (3 -> #(B))
		with: (4 -> #())) asDictionary.

	b := RSDSM new.
	b objectsX: #(A B C).
	b objectsY: #(1 2 3 4).
	b dependency: [ :v | values at: v ].
	^ b
]

{ #category : #examples }
RSDSM class >> example04Authorship [
	<script: 'self example04Authorship inspect'>
	| classes classesToAuthors authors authorsToClasses b |
	classes := RTShape withAllSubclasses.
	classesToAuthors := (classes collect: [ :cls | cls -> ((cls methods collect: #author) asSet sortedAs: #yourself ) ]) asDictionary.
	authors := (classesToAuthors values flatCollect: #yourself )asSet sortedAs: #yourself.
	authorsToClasses := (authors collect: [ :anAuthor | anAuthor -> (classesToAuthors associations select: [ :as | as value includes: anAuthor ] thenCollect: #key) ] ) asDictionary.

	b := RSDSM new.
	b objectsX: classes.
	b objectsY: authors.
	b dependency: [ :author | authorsToClasses at: author ].
	^ b
]

{ #category : #accessing }
RSDSM >> dependency [
	^ dependency
]

{ #category : #accessing }
RSDSM >> dependency: aOneArgBlock [
	dependency := aOneArgBlock
]

{ #category : #initialization }
RSDSM >> initialize [
	"
	:: Void -> RTDSM
	"
	super initialize.
	dependency := #yourself.
	self shape
		color: [ :assoc | (self isAssocDependent: assoc) ifTrue: [ Color red ] ifFalse: [ 
				Color veryVeryLightGray ]  ]
		
]

{ #category : #testing }
RSDSM >> isAssocDependent: assoc [
	| v |
	v := dependency rsValue: assoc key.
	v = assoc value ifTrue: [ ^ true ].
	^ v isCollection
		ifTrue: [ v includes: assoc value ]
		ifFalse: [ false ]
]

"
A TSGroup represents collections of Roassal elements. A RTGroup is not designed to contain other things than Roassal elements. 
A TSGroup is polymorphic to RSElement. When an RSElement is expected, one can provide an TSGroup.
"
Class {
	#name : #RSGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'allMethods',
		'shapeFromModelCache'
	],
	#category : #'Roassal3-Core'
}

{ #category : #actions }
RSGroup >> @ int [
	self do: [ :e | e @ int ].
]

{ #category : #accessing }
RSGroup >> add: shape [
	self resetShapeFromModelCache.
	^ super add: shape
]

{ #category : #accessing }
RSGroup >> addAll: shapes [
	self resetShapeFromModelCache.
	^ super addAll: shapes
]

{ #category : #converting }
RSGroup >> asGroup [
	^ self
]

{ #category : #'as yet unclassified' }
RSGroup >> asShape [
	^ self asShapeFor: nil
]

{ #category : #accessing }
RSGroup >> encompassingRectangle [
	^ self
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #accessing }
RSGroup >> extent [
	^ self encompassingRectangle extent
]

{ #category : #accessing }
RSGroup >> height [ 
	^ self extent y
]

{ #category : #actions }
RSGroup >> pushBack [ 
	self do: #pushBack
]

{ #category : #actions }
RSGroup >> pushFront [
	self do: #pushFront
]

{ #category : #accessing }
RSGroup >> resetShapeFromModelCache [
	"Reset the cache"
	shapeFromModelCache := nil
]

{ #category : #accessing }
RSGroup >> shapeFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	
	| t key|
	self shapeFromModelCache at: anObject ifPresent: [ :v |
		v isCollection ifFalse: [ ^ v ] ].

	"We have this line because of a bug of the implementation of CompiledMethod>>#="
	t := (anObject class == CompiledMethod) 
				ifTrue: [ self detect: [ :el | el model == anObject ] ifNone: [ nil ] ]
				ifFalse: [ self detect: [ :el | el model = anObject ] ifNone: [ nil ] ].
	"We have this hack for nil objects because in visualWorks a dictionary cannot have nil as a key"
	key := anObject isNil ifTrue: [ 'KeyForNilObjects' ] ifFalse: [ anObject ].
	self shapeFromModelCache at: key put: t.
	^ t
]

{ #category : #accessing }
RSGroup >> shapeFromModelCache [
	"Define a cache for the element lookup from models"
	shapeFromModelCache ifNil: [ shapeFromModelCache := Dictionary new ].
	^ shapeFromModelCache
]

{ #category : #accessing }
RSGroup >> shapesFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"	

	| t key |
	self shapeFromModelCache at: anObject ifPresent: [ :v | v isCollection ifTrue: [ ^ v ] ].

	"We have this line because of a bug of the implementation of CompiledMethod>>#="
	t := (anObject class == CompiledMethod) 
				ifTrue: [ self select: [ :el | el model == anObject ] ]
				ifFalse: [ self select: [ :el | el model = anObject ] ].

	"We have this hack for nil objects because in visualWorks a dictionary cannot have nil as a key"
	key := anObject isNil ifTrue: [ 'KeyForNilObjects' ] ifFalse: [ anObject ].
	self shapeFromModelCache at: key put: t.
	^ t
]

{ #category : #accessing }
RSGroup >> shapesFromModels: objects [
	"Return elements that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	| answer t |
	self assert: [ objects isCollection ] description: 'Provide a set of shapes instead of one single shape'. 
	answer := RSGroup new.
	objects do: [ :o |
		t := self shapesFromModel: o.
		t notNil ifTrue: [ answer addAll: t ] ].
	^ answer
]

{ #category : #transforming }
RSGroup >> translateBy: delta [
	self do: [ :e | e translateBy: delta ]
]

{ #category : #transforming }
RSGroup >> translateTo: aPosition [
	| center |
	center := self encompassingRectangle rsCenter.
	self translateBy: aPosition - center
]

{ #category : #announcing }
RSGroup >> when: event do: block [
	self do: [ :element | element when: event do: block ]
]

{ #category : #accessing }
RSGroup >> width [ 
	^ self extent x
]

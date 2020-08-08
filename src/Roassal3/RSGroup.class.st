"
<keyClass>
A `RSGroup` represents a collection of Roassal shapes. As soon as one assume a collection contains graphical elements, then it is convenient to be able to perform some operations (e.g., getting the encompassing rectangle of the elements, transforming a collection into a composite shape). `RSGroup` is a subclass of `OrderedCollection`. A `RSGroup` is not designed to contain other things than Roassal shapes. 

*Responsibility*: handle a collection of graphical shapes in an intuitive and efficient way. A group is also responsible to retrieve shapes from a given model object.

*Collaborators*: `RSGroup` is a central class in Roassal. Shapes are held in instance of `RSGroup`.

*Variables*:
- `shapeFromModelCache`: a group of shapes must remember the model to speed up the retreival of shapes from a given object model.


*Example*:
```Smalltalk
shapes := (1 to: 20) collect: [ :value | 
	| g |
	g := RSGroup new.
	g add: (RSEllipse new size: 30 atRandom).
	g add: (RSLabel new text: value).
	g asShape ].

c := RSCanvas new.
c addAll: shapes.
RSFlowLayout on: shapes.
c @ RSCanvasController.
```

Layout may be applied on a group
```Smalltalk
shapes := (1 to: 20) collect: [ :value | 
	| g |
	g := RSGroup new.
	g add: (RSLabel new text: value).
	g add: (RSEllipse new size: 30 atRandom).
	RSVerticalLineLayout new center; gapSize: 0; on: g.
	g asShape ].

c := RSCanvas new.
c addAll: shapes.
RSFlowLayout on: shapes.
c @ RSCanvasController.
```

```Smalltalk
g := RSGroup new.
g add: (RSBox new model: 'hello').
g add: (RSEllipse new model: 'world').
g shapeFromModel: 'hello' ""=> a RSBox(hello))""
```

"
Class {
	#name : #RSGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'shapeFromModelCache'
	],
	#category : #'Roassal3-Core'
}

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

{ #category : #accessing }
RSGroup >> models: someModels [
	"Set the model of each shapes contained in the collection. The size of the group must be the same than the someModels collection"
	self assert: [ someModels isCollection ] description: 'Must provide a collection'.
	self assert: [ self size = someModels size ] description: 'The argument must of the same size then the group'.
	self with: someModels do: [ :s :m | s model: m ]
]

{ #category : #actions }
RSGroup >> pushBack [ 
	self do: [:each | each pushBack ]
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
	"Return a shape that corresponds to the object provided as parameter. If none is found, then return nil
	
-=-=-=-=-=-=-=-=-=
g := RSGroup new.
g add: (RSBox new model: 'hello').
g add: (RSEllipse new model: 'world').
g shapeFromModel: 'hello'
-=-=-=-=-=-=-=-=-=
=> a RSBox(hello))

	"

	| t |
	self shapeFromModelCache
		at: anObject
		ifPresent: [ :v | v isCollection ifFalse: [ ^ v ] ].

	"We have this line because of a bug of the implementation of CompiledMethod>>#="
	t := anObject class == CompiledMethod
		     ifTrue: [ 
		     self shapeFromModel: anObject using: [ :a :b | a == b ] ]
		     ifFalse: [ 
		     self shapeFromModel: anObject using: [ :a :b | a = b ] ].
	self shapeFromModelCache at: anObject put: t.
	^ t
]

{ #category : #accessing }
RSGroup >> shapeFromModel: anObject using: aBlock [
	self do: [ :aShape | 
		(aShape shapeFromModel: anObject using: aBlock) ifNotNil: [ :found | 
			^ found ] ].
	^ nil
]

{ #category : #accessing }
RSGroup >> shapeFromModelCache [
	"Define a cache for the element lookup from models"
	shapeFromModelCache ifNil: [ shapeFromModelCache := Dictionary new ].
	^ shapeFromModelCache
]

{ #category : #accessing }
RSGroup >> shapesFromModel: anObject [
	"Return a shape that corresponds to the object provided as parameter. If none is found, then return nil.

For example:
-=-=-=-=-=-=-=-=-=
g := RSGroup new.
g add: (RSBox new model: 'hello').
g add: (RSEllipse new model: 'world').
g shapesFromModel: 'hello' 
-=-=-=-=-=-=-=-=-=
=> a RSGroup(a RSBox(hello))
	"	

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
	center := self encompassingRectangle floatCenter.
	self translateBy: aPosition - center
]

{ #category : #converting }
RSGroup >> translucent [
	"Make all shapes in the group as translucent"
	self do: [ :s | s color: s color translucent ]
]

{ #category : #announcing }
RSGroup >> when: event do: block [
	self do: [ :element | element when: event do: block ]
]

{ #category : #accessing }
RSGroup >> width [ 
	^ self extent x
]

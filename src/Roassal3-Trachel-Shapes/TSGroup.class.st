"
A TSGroup represents collections of Roassal elements. A RTGroup is not designed to contain other things than Roassal elements. 
A TSGroup is polymorphic to RSElement. When an RSElement is expected, one can provide an RTGroup.
"
Class {
	#name : #TSGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'isFixed',
		'matrix',
		'elementFromModelCache'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #converting }
TSGroup >> @ int [
	self do: [ :e | e @ int ].
]

{ #category : #visiting }
TSGroup >> accept: visitor [
	visitor visitGroup: self.
]

{ #category : #accessing }
TSGroup >> add: element [
	self resetElementFromModelCache.
	^ super add: element
]

{ #category : #accessing }
TSGroup >> addAll: elements [
	self resetElementFromModelCache.
	^ super addAll: elements
]

{ #category : #adding }
TSGroup >> addedIn: canvas [
	self isFixed
		ifTrue: [ canvas addFixedShape: self ]
		ifFalse: [ canvas addBasicShape: self ].
]

{ #category : #accessing }
TSGroup >> edges [
	^ self select: [ :o | o class == RSEdge ]
]

{ #category : #accessing }
TSGroup >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	
	| t key|
	self elementFromModelCache at: anObject ifPresent: [ :v |
		v isCollection ifFalse: [ ^ v ] ].

	"We have this line because of a bug of the implementation of CompiledMethod>>#="
	t := (anObject class == CompiledMethod) 
				ifTrue: [ self detect: [ :el | el model == anObject ] ifNone: [ nil ] ]
				ifFalse: [ self detect: [ :el | el model = anObject ] ifNone: [ nil ] ].
	"We have this hack for nil objects because in visualWorks a dictionary cannot have nil as a key"
	key := anObject isNil ifTrue: [ 'KeyForNilObjects' ] ifFalse: [ anObject ].
	self elementFromModelCache at: key put: t.
	^ t
]

{ #category : #accessing }
TSGroup >> elementFromModelCache [
	"Define a cache for the element lookup from models"
	elementFromModelCache ifNil: [ elementFromModelCache := Dictionary new ].
	^ elementFromModelCache
]

{ #category : #accessing }
TSGroup >> elements [
	^ self select: [ :o | o class == RSElement ]
]

{ #category : #accessing }
TSGroup >> elementsFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"	

	| t key |
	self elementFromModelCache at: anObject ifPresent: [ :v | v isCollection ifTrue: [ ^ v ] ].

	"We have this line because of a bug of the implementation of CompiledMethod>>#="
	t := (anObject class == CompiledMethod) 
				ifTrue: [ self select: [ :el | el model == anObject ] ]
				ifFalse: [ self select: [ :el | el model = anObject ] ].

	"We have this hack for nil objects because in visualWorks a dictionary cannot have nil as a key"
	key := anObject isNil ifTrue: [ 'KeyForNilObjects' ] ifFalse: [ anObject ].
	self elementFromModelCache at: key put: t.
	^ t
]

{ #category : #accessing }
TSGroup >> elementsFromModels: objects [
	"Return elements that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	| answer t |
	self assert: [ objects isCollection ] description: 'Provide a set of elements instead of one single element'. 
	answer := TSGroup new.
	objects do: [ :o |
		t := self elementsFromModel: o.
		t notNil ifTrue: [ answer addAll: t ] ].
	^ answer
]

{ #category : #accessing }
TSGroup >> encompassingRectangle [
	^ self
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ 
			| rec |
			rec := Rectangle merging: (self collect: #encompassingRectangle).
			Rectangle center: self position extent: rec extent ]
]

{ #category : #accessing }
TSGroup >> extent [
	^ self encompassingRectangle extent
]

{ #category : #accessing }
TSGroup >> height [ 
	^ self extent y
]

{ #category : #testing }
TSGroup >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #accessing }
TSGroup >> isFixed [ 
	^ isFixed ifNil: [ isFixed := false ].
]

{ #category : #accessing }
TSGroup >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #matrix }
TSGroup >> matrix [
	^ matrix ifNil: [ matrix := AthensAffineTransform new ].
]

{ #category : #matrix }
TSGroup >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : #matrix }
TSGroup >> position [ 
	^ self matrix translation
]

{ #category : #matrix }
TSGroup >> position: aPoint [
	self matrix translation: aPoint
]

{ #category : #accessing }
TSGroup >> resetElementFromModelCache [
	"Reset the cache"
	elementFromModelCache := nil
]

{ #category : #matrix }
TSGroup >> translateTo: aPoint [
	self position: aPoint.
]

{ #category : #accessing }
TSGroup >> width [ 
	^ self extent x
]

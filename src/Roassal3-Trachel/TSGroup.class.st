"
A TSGroup represents collections of Roassal elements. A RTGroup is not designed to contain other things than Roassal elements. 
A TSGroup is polymorphic to RSElement. When an RSElement is expected, one can provide an TSGroup.
"
Class {
	#name : #TSGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'allMethods',
		'elementFromModelCache'
	],
	#category : #'Roassal3-Trachel-Shape'
}

{ #category : #converting }
TSGroup >> @ int [
	self do: [ :e | e @ int ].
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

{ #category : #converting }
TSGroup >> asElement [ 
	^ self asElementOn: nil
]

{ #category : #converting }
TSGroup >> asElementOn: model [
	^ RSComposite new 
		model: model;
		shape: TSComposite new;
		shapes: self.
]

{ #category : #converting }
TSGroup >> asGroup [
	^ self
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
			rec := Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #accessing }
TSGroup >> extent [
	^ self encompassingRectangle extent
]

{ #category : #accessing }
TSGroup >> height [ 
	^ self extent y
]

{ #category : #ui }
TSGroup >> paintOn: b [
	"b is a mondrian builder"
	| methodsToBeVisualized |
	methodsToBeVisualized := self, (self flatCollect: #allOutgoingCalls) asSet asArray.
	b shape 
		box if: #isTest fillColor: Color green.
	b nodes: methodsToBeVisualized.
	
	b shape line color: Color veryLightGray trans.
	b edges
		moveBehind;
		connectToAll: #outgoingCalls.
		
	b normalizer
		normalizeSize: #numberOfLinesOfCode;
		normalizeColor: [ :m | (m tests intersection: self) size ] using: { Color blue. Color red }.
	b layout tree.
]

{ #category : #actions }
TSGroup >> pushBack [ 
	self do: #pushBack
]

{ #category : #actions }
TSGroup >> pushFront [
	self do: #pushFront
]

{ #category : #accessing }
TSGroup >> resetElementFromModelCache [
	"Reset the cache"
	elementFromModelCache := nil
]

{ #category : #transforming }
TSGroup >> translateBy: delta [
	self do: [ :e | e translateBy: delta ]
]

{ #category : #transforming }
TSGroup >> translateTo: aPosition [
	| center |
	center := self encompassingRectangle rsCenter.
	self translateBy: aPosition - center
]

{ #category : #announcing }
TSGroup >> when: event do: block [
	self do: [ :element | element when: event do: block ]
]

{ #category : #accessing }
TSGroup >> width [ 
	^ self extent x
]

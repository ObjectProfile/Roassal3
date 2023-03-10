Extension { #name : #RSObjectWithProperty }

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> allSChildren [
	| allChildren index |
	index := 1.
	allChildren := OrderedCollection withAll: self schildren.
	[ index <= allChildren size ] whileTrue: [ 
		allChildren addAll: ((allChildren at: index) schildren ifNil: [#()]).
		index := index + 1 ].
	^ allChildren
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> isSLeaf [
	^ self schildren isEmpty
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> schildren [
	^ self propertyAt: #schildren
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> schildren: aGroupOfShapes [

	"children is used by tree builders usefull to relationate hierarchy visualizations"

	self propertyAt: #schildren put: aGroupOfShapes.
	aGroupOfShapes do: [ :s | s sparent: self ]
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> sparent [
	^ self propertyAt: #sparent
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> sparent: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #sparent put: anObject
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> withAllSChildren [
	^ self allSChildren
		add: self;
		yourself.
]

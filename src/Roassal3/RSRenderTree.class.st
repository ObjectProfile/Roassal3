"
An R-tree for roassal3
"
Class {
	#name : #RSRenderTree,
	#superclass : #Collection,
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSRenderTree >> add: newObject [ 
	root 
		ifNil: [ root := RSRNode new: newObject ]
		ifNotNil: [ root add: newObject ].
	^ newObject
]

{ #category : #enumerating }
RSRenderTree >> do: aBlock [ 
	root ifNotNil: [ root do: aBlock ]
]

{ #category : #accessing }
RSRenderTree >> height [
	^ root
	ifNil: [ 0 ]
	ifNotNil: [ root height ]
	
]

{ #category : #testing }
RSRenderTree >> isBalanced [
	^ root
		ifNil: [ true ]
		ifNotNil: [ root isBalanced ]
]

{ #category : #'finding/searching' }
RSRenderTree >> nodesIntersetcsRectangle: aRectangle [ 
	^ root ifNil: [ #() ]
		ifNotNil: [ | res |
			res := OrderedCollection new.
			root nodesIntersetcsRectangle: aRectangle list: res.
			res ]
]

{ #category : #'finding/searching' }
RSRenderTree >> nodesWithPoint: aPoint [ 
	^ root 
		ifNil: [ #() ]
		ifNotNil: [ | res |
			res := OrderedCollection new.
			root nodesWithPoint: aPoint list: res.
			res ].
]

{ #category : #accessing }
RSRenderTree >> rectangle [
	^ root 
		ifNil: [ 0@0 corner: 0@0 ]
		ifNotNil: [ root rectangle ]
]

{ #category : #removing }
RSRenderTree >> remove: oldObject ifAbsent: anExceptionBlock [ 
	^ root 
		ifNil: [ anExceptionBlock value ]
		ifNotNil: [ | removedObject |
			removedObject := root remove: oldObject.
			removedObject 
				ifNil: anExceptionBlock
				ifNotNil: [
					root isInvalid
						ifTrue: [ root := nil ]
					]
			].
	
]

{ #category : #accessing }
RSRenderTree >> root [
	^ root
]

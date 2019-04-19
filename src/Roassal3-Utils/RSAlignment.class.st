"
Define alignment of elements. 

For example, inspect the following:
-=-=-=
	objects := TSShape withAllSubclasses.
	v := RSView new.
	v showEncompassingRectangles.
	n := TSScale category20c.
	shape := RSShapeBuilder box color: n; size: [ : c | c numberOfMethods ].
	es := shape elementsOn: objects.
	v addAll: es.
	RSHorizontalLineLayout new gapSize: 0; on: es.
	RTAlignment new elements: es; bottom.
	v @ RSControlsView.
	v open
-=-=-=
"
Class {
	#name : #RSAlignment,
	#superclass : #RSAbstractElementHandling,
	#category : #'Roassal3-Utils-PositionAndResize'
}

{ #category : #public }
RSAlignment >> alignFromBottomUsing: anElement [
	"The argument anElement is a fix point. It does not move"
	| topY newY |
	topY := anElement encompassingRectangle bottomCenter y.
	elements do: [ :s |
		newY := topY - (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #public }
RSAlignment >> alignFromCenterUsing: anElement [
	| topX newX topY newY |
	
	topX := anElement encompassingRectangle center x.
	topY := anElement encompassingRectangle center y.	
	elements do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		newY := topY + (s encompassingRectangle height / 2).		
		s translateTo: newX @ newY
	]
]

{ #category : #public }
RSAlignment >> alignFromLeftUsing: anElement [
	| topX newX |
	topX := anElement encompassingRectangle topLeft x.
	elements do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RSAlignment >> alignFromRightUsing: anElement [
	| topX newX |
	topX := anElement encompassingRectangle topRight x.
	elements do: [ :s |
		newX := topX - (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RSAlignment >> alignFromTopUsing: anElement [
	| topY newY |
	topY := anElement encompassingRectangle topCenter y.
	elements do: [ :s |
		newY := topY + (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #public }
RSAlignment >> bottom [
	self hasElement ifFalse: [ ^ self ].
	self alignFromBottomUsing: self bottomMostElement 
]

{ #category : #'accessing - computed' }
RSAlignment >> bottomMostElement [
	fixedElement ifNotNil: [ ^ fixedElement ].
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle top <= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> center [
	self hasElement ifFalse: [ ^ self ].
	self alignFromCenterUsing: self centerMostElement
]

{ #category : #public }
RSAlignment >> centerMostElement [

	fixedElement ifNotNil: [ ^ fixedElement ].
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle center <= s encompassingRectangle center
					ifTrue: [ s ] ifFalse: [ maxS ] ]
]

{ #category : #testing }
RSAlignment >> hasElement [
	"Return true if some elements have been set"
	^ (elements isNil or: [ elements isEmpty ]) not
]

{ #category : #public }
RSAlignment >> left [
	self hasElement ifFalse: [ ^ self ].
	self alignFromLeftUsing: self leftMostElement 
]

{ #category : #'accessing - computed' }
RSAlignment >> leftMostElement [
	fixedElement ifNotNil: [ ^ fixedElement ].
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle left >= s encompassingRectangle left
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> right [
	self hasElement ifFalse: [ ^ self ].
	self alignFromRightUsing: self rightMostElement 
]

{ #category : #'accessing - computed' }
RSAlignment >> rightMostElement [
	fixedElement ifNotNil: [ ^ fixedElement ].
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle right <= s encompassingRectangle right
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> top [
	self hasElement ifFalse: [ ^ self ].
	self alignFromTopUsing: self topMostElement 
]

{ #category : #'accessing - computed' }
RSAlignment >> topMostElement [
	fixedElement ifNotNil: [ ^ fixedElement ].
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle top >= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

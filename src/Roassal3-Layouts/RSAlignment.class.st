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
	#category : #'Roassal3-Layouts-PositionAndResize'
}

{ #category : #public }
RSAlignment >> alignFromBottomUsing: aShape [
	"The argument aShape is a fix point. It does not move"
	| topY newY |
	topY := aShape encompassingRectangle bottomCenter y.
	shapes do: [ :s |
		newY := topY - (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #public }
RSAlignment >> alignFromCenterUsing: aShape [
	| topX newX topY newY |
	topX := aShape encompassingRectangle center x.
	topY := aShape encompassingRectangle center y.	
	shapes do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		newY := topY + (s encompassingRectangle height / 2).		
		s translateTo: newX @ newY
	]
]

{ #category : #public }
RSAlignment >> alignFromLeftUsing: aShape [
	| topX newX |
	topX := aShape encompassingRectangle topLeft x.
	shapes do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RSAlignment >> alignFromRightUsing: aShape [
	| topX newX |
	topX := aShape encompassingRectangle topRight x.
	shapes do: [ :s |
		newX := topX - (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RSAlignment >> alignFromTopUsing: aShape [
	| topY newY |
	topY := aShape encompassingRectangle topCenter y.
	shapes do: [ :s |
		newY := topY + (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #public }
RSAlignment >> bottom [
	self hasShape ifFalse: [ ^ self ].
	self alignFromBottomUsing: self bottomMostShape 
]

{ #category : #'accessing - computed' }
RSAlignment >> bottomMostShape [
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle top <= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> center [
	self hasShape ifFalse: [ ^ self ].
	self alignFromCenterUsing: self centerMostShape
]

{ #category : #public }
RSAlignment >> centerMostShape [
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle center <= s encompassingRectangle center
					ifTrue: [ s ] ifFalse: [ maxS ] ]
]

{ #category : #testing }
RSAlignment >> hasShape [
	"Return true if some shapes have been set"
	^ (shapes isNil or: [ shapes isEmpty ]) not
]

{ #category : #public }
RSAlignment >> left [
	self hasShape ifFalse: [ ^ self ].
	self alignFromLeftUsing: self leftMostShape 
]

{ #category : #'accessing - computed' }
RSAlignment >> leftMostShape [
	"Return the shape that is the located the most on the left hand side"
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle left >= s encompassingRectangle left
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> right [
	self hasShape ifFalse: [ ^ self ].
	self alignFromRightUsing: self rightMostShape 
]

{ #category : #'accessing - computed' }
RSAlignment >> rightMostShape [
	"Return the shape that is the located the most on the right hand side"
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle right <= s encompassingRectangle right
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> top [
	self hasShape ifFalse: [ ^ self ].
	self alignFromTopUsing: self topMostShape 
]

{ #category : #'accessing - computed' }
RSAlignment >> topMostShape [
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle top >= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

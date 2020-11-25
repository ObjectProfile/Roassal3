"
Define alignment of elements. 

For example, inspect the following:
-=-=-=
c := RSCanvas new.
es := (1 to: 5) collect: [ :v | RSBox new size: v * 5 ] as: RSGroup.
RSVerticalLineLayout on: es.
align := RSAlignment new.
align shapes: es.
align right.
c addAll: es.
c
-=-=-=
"
Class {
	#name : #RSAlignment,
	#superclass : #RSAbstractElementHandling,
	#category : #'Roassal3-Layouts-PositionAndResize'
}

{ #category : #alignment }
RSAlignment >> alignFromBottomUsing: aShape [
	"The argument aShape is a fix point. It does not move"
	| topY newY |
	topY := aShape encompassingRectangle bottomCenter y.
	shapes do: [ :s |
		newY := topY - (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #alignment }
RSAlignment >> alignFromCenterUsing: aShape [
	| topX |
	topX := aShape position x.
	shapes do: [ :s |
		s translateTo: topX @ s position y
	]
]

{ #category : #alignment }
RSAlignment >> alignFromLabelUsing: aRSLabel [
	| topY yb |
	topY := aRSLabel encompassingRectangle top.
	yb := aRSLabel textExtents y_bearing.
	shapes do: [ :s |	
		s translateTo: s position x @ (topY + (s extent y / 2.0) + s textExtents y_bearing-yb).
	]
]

{ #category : #alignment }
RSAlignment >> alignFromLeftUsing: aShape [
	| topX newX |
	topX := aShape encompassingRectangle topLeft x.
	shapes do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #alignment }
RSAlignment >> alignFromMiddleUsing: aShape [
	| midY |
	midY := aShape position y.	
	shapes do: [ :s |	
		s translateTo: s position x @ midY
	]
]

{ #category : #alignment }
RSAlignment >> alignFromRightUsing: aShape [
	| topX newX |
	topX := aShape encompassingRectangle topRight x.
	shapes do: [ :s |
		newX := topX - (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #alignment }
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
"
Align all the shapes on the bottoms of the shapes.

-=-=-=-=-=-=-=-=
c := RSCanvas new.
es := (1 to: 5) collect: [ :v | RSBox new color: Color gray trans; size: v * 5 ] as: RSGroup.
RSHorizontalLineLayout on: es.
align := RSAlignment new.
align shapes: es.
align bottom.
c addAll: es.
c
-=-=-=-=
"
	self hasShape ifFalse: [ ^ self ].
	self alignFromBottomUsing: self bottomMostShape 
]

{ #category : #'accessing - computed' }
RSAlignment >> bottomMostShape [
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle bottom <= s encompassingRectangle bottom
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #public }
RSAlignment >> center [
"
Center all the shapes along their X coordinate
-=-=-=-
c := RSCanvas new.
es := (1 to: 5) collect: [ :v | RSBox new color: Color gray trans; size: v * 5 ] as: RSGroup.
RSVerticalLineLayout on: es.
align := RSAlignment new.
align shapes: es.
align center.
c addAll: es.
c
-=-=-=-
"
	self hasShape ifFalse: [ ^ self ].
	self alignFromCenterUsing: self centerMostShape
]

{ #category : #'accessing - computed' }
RSAlignment >> centerMostShape [
	fixedShape ifNotNil: [ ^ fixedShape ].
	^ shapes inject: shapes first into: [ :maxS :s | 
			maxS encompassingRectangle floatCenter <= s encompassingRectangle floatCenter
					ifTrue: [ s ] ifFalse: [ maxS ] ]
]

{ #category : #testing }
RSAlignment >> hasShape [
	"Return true if some shapes have been set"
	^ (shapes isNil or: [ shapes isEmpty ]) not
]

{ #category : #public }
RSAlignment >> label [
	self hasShape ifFalse: [ ^ self ].
	self alignFromLabelUsing: self centerMostShape
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
RSAlignment >> middle [
"Center all the shapes along their Y coordinate

```Smalltalk
c := RSCanvas new.
es := (1 to: 5) collect: [ :v | RSBox new color: Color gray translucent; size: v * 5 ] as: RSGroup.
RSHorizontalLineLayout on: es.
align := RSAlignment new.
align shapes: es.
align middle.
c addAll: es.
c
```
"
	self hasShape ifFalse: [ ^ self ].
	self alignFromMiddleUsing: self centerMostShape
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

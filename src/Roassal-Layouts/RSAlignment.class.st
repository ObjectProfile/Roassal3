"
Define alignment of aligment for shapes. Note that some layouts like `RSVerticalLineLayout` or `RSHorizontalLineLayout` uses internally this class for aligment operations

Users should use `shapes` before any alignment operation.
```
align := RSAlignment new.
align shapes: someShapes.
align bottom.
```
# Operations
- vertical operations are `bottom`, `top`, `middle`, `label`.
	- `label` operation align labels based on its baseline.
	- for vertical operation `label` shapes should be a collection of `RSLabel`
- horizontal operations are `left`, `center`, `right`.
- none, you can apply none operation, to skip any alignment.
"
Class {
	#name : #RSAlignment,
	#superclass : #RSAbstractShapeHandling,
	#category : #'Roassal-Layouts-PositionAndResize'
}

{ #category : #examples }
RSAlignment class >> exampleAlignBottom [
	| canvas boxes |
	canvas := RSCanvas new.
	boxes := (1 to: 5) collect: [ :v | 
		RSBox new 
			color: Color gray translucent;
			size: v * 5 ] as: RSGroup.
	RSHorizontalLineLayout new alignBottom; on: boxes.
	"align := self new.
	align shapes: boxes.
	align bottom."
	canvas addAll: boxes.
	^ canvas open
]

{ #category : #examples }
RSAlignment class >> exampleAlignCenter [
	| canvas boxes |
	canvas := RSCanvas new.
	boxes := (1 to: 5) collect: [ :v | RSBox new size: v * 5 ] as: RSGroup.
	RSVerticalLineLayout new alignCenter; on: boxes.
	
	"align := self new.
	align shapes: boxes.
	align center."
	canvas addAll: boxes.
	^ canvas open
]

{ #category : #examples }
RSAlignment class >> exampleAlignLabel [
	| canvas labels |
	canvas := RSCanvas new.
	labels := (1 to: 5) collect: [ :v | 
		RSLabel new
			text: v;
			fontSize: v * 5 ] as: RSGroup.
	RSHorizontalLineLayout new alignLabel; on: labels.
	
	"align := self new.
	align shapes: labels.
	align label."
	canvas addAll: labels.
	"note that each label, have different encompassing rectangle"
	canvas showEncompassingRectangles.
	^ canvas open
]

{ #category : #examples }
RSAlignment class >> exampleAlignMiddle [
	| canvas boxes |
	canvas := RSCanvas new.
	boxes := (1 to: 5) collect: [ :v | 
		RSBox new 
			color: Color gray translucent;
			size: v * 5 ] as: RSGroup.
	RSHorizontalLineLayout new alignMiddle; on: boxes.
	"align := self new.
	align shapes: boxes.
	align middle."
	canvas addAll: boxes.
	^ canvas open
]

{ #category : #examples }
RSAlignment class >> exampleAlignRight [
	| canvas boxes |
	canvas := RSCanvas new.
	boxes := (1 to: 5) collect: [ :v | RSBox new size: v * 5 ] as: RSGroup.
	RSVerticalLineLayout new alignRight; on: boxes.
	
	"align := self new.
	align shapes: boxes.
	align right."
	canvas addAll: boxes.
	^ canvas open
]

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
	"Align all the shapes on the bottoms of the shapes"
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
	"Center all the shapes along their X coordinate"
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
	"Center all the shapes along their Y coordinate"
	self hasShape ifFalse: [ ^ self ].
	self alignFromMiddleUsing: self centerMostShape
]

{ #category : #public }
RSAlignment >> none [
	"just empty alignment, because sometimes, shapes are in the position"
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

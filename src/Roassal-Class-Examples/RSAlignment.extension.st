Extension { #name : 'RSAlignment' }

{ #category : '*Roassal-Class-Examples' }
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

{ #category : '*Roassal-Class-Examples' }
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

{ #category : '*Roassal-Class-Examples' }
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

{ #category : '*Roassal-Class-Examples' }
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

{ #category : '*Roassal-Class-Examples' }
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

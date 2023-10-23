Extension { #name : 'RTNode' }

{ #category : '*Roassal-Examples' }
RTNode >> bulkLoad: aCollection from: a to: b [
	"a and b are indeces, used to copy part of the boxes"
	b < a ifTrue: [ ^ self error: 'should not' ].
	a = b ifTrue: [
		contents := aCollection at: a.
		rectangle := contents encompassingRectangle.
	] ifFalse: [ | mid |
		rectangle := Rectangle merging: ((a to: b) collect: [:i |
			(aCollection at: i) encompassingRectangle ]).
		mid := (a+b/2) asInteger.
		left := self class new.
		left bulkLoad: aCollection from: a to: mid.
		right := self class new.
		right bulkLoad: aCollection from: mid + 1 to: b.
	]
]

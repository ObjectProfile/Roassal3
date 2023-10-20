Extension { #name : 'SequenceableCollection' }

{ #category : '*Roassal' }
SequenceableCollection >> argmax [
	"#(1 -3 5 1) argmax >>> 3"
	"#(1 1 1 1) argmax >>> 1"
	^ self indexOf: self max
]

{ #category : '*Roassal' }
SequenceableCollection >> max: aSelectorOrOneArgBlock [
	^ (self collect: aSelectorOrOneArgBlock) max
]

{ #category : '*Roassal' }
SequenceableCollection >> min: aSelectorOrOneArgBlock [
	^ (self collect: aSelectorOrOneArgBlock) min
]

{ #category : '*Roassal' }
SequenceableCollection >> reverseSortedAs: aSortBlockOrSymbol [
	"Answer a SortedCollection whose elements are the elements of the
	receiver. The sort order is defined by the argument, aSortBlock."

	| aSortedCollection aSortBlock |
	aSortedCollection := SortedCollection new: self size.
	aSortBlock :=
		aSortBlockOrSymbol isSymbol
			ifTrue: [ [:a :b | |t1 t2|
							t1 := (a perform: aSortBlockOrSymbol).
							t2 := (b perform: aSortBlockOrSymbol).
							((t1 isKindOf: Boolean) and: [t2 isKindOf: Boolean])
								ifTrue: [ t1 ]
								ifFalse: [ t1 > t2 ] ] ]
			ifFalse: [
				(aSortBlockOrSymbol numArgs = 1)
					ifTrue: [ [ :v1 :v2 | (aSortBlockOrSymbol value: v1) > (aSortBlockOrSymbol value: v2) ] ]
					ifFalse: [ aSortBlockOrSymbol ] ].
	aSortedCollection sortBlock: aSortBlock.
	aSortedCollection addAll: self.
	^ aSortedCollection
]

Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal-Layouts' }
SequenceableCollection >> rsSwapElement: u withElement: v [
	| index1 index2 |
	index1 := self indexOf: u.
	index2 := self indexOf: v.
	self at: index2 put: u.
	self at: index1 put: v
]

Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal3' }
SequenceableCollection >> asGroup [
	^ (RSGroup new: self size) addAll: self; yourself
]

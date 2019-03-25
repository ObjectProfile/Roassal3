Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal3' }
SequenceableCollection >> asGroup [
	^ (TSGroup new: self size) addAll: self; yourself
]

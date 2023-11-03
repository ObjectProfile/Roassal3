Extension { #name : 'Number' }

{ #category : '*Roassal3' }
Number >> bernstein: n choose: i [

	^ (n choose: i) * (self raisedTo: i) * (1 - self raisedTo: n - i)
]

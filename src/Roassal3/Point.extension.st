Extension { #name : #Point }

{ #category : #'*Roassal3' }
Point >> asAttachPoint [ 
	^ RSAttachPoint point on: self
]

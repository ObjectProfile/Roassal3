Extension { #name : #RSShape }

{ #category : #'*Roassal3-Bloc' }
RSShape >> asBlElement [

	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Bloc' }
RSShape >> blBorder [

	^ self border ifNotNil: [ :b | 
		  BlBorder paint: b paint width: b width ]
]

{ #category : #'*Roassal3-Bloc' }
RSShape >> blPaint [

	^ self paint ifNil: [ Color transparent ]
]

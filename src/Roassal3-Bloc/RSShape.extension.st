Extension { #name : #RSShape }

{ #category : #'*Roassal3-Bloc' }
RSShape >> asBlElement [

	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Bloc' }
RSShape >> blBackground [

	^ self paint ifNil: [ Color transparent ]
]

{ #category : #'*Roassal3-Bloc' }
RSShape >> blBorder [

	^ self border ifNotNil: [ :b | 
		  BlBorder paint: b paint width: b width ]
]

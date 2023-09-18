Extension { #name : #RSShape }

{ #category : #'*Roassal-Bloc' }
RSShape >> asBlElement [
	"Answer an instance of BlElement that represents this shape in a Bloc host. 
	The returned object needs to answer #roassalShape."

	^ self subclassResponsibility
]

{ #category : #'*Roassal-Bloc' }
RSShape >> blBorder [
	border ifNil: [ ^ nil ].
	^ border asBlBorder.
	
	 
]

{ #category : #'*Roassal-Bloc' }
RSShape >> blPaint [

	^ self paint ifNil: [ Color transparent ]
]

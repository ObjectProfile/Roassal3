Extension { #name : 'RSShape' }

{ #category : '*Roassal3-Bloc' }
RSShape >> asBlElement [
	"Answer an instance of BlElement that represents this shape in a Bloc host. 
	The returned object needs to answer #roassalShape."

	^ self subclassResponsibility
]

{ #category : '*Roassal3-Bloc' }
RSShape >> blBorder [
	border ifNil: [ ^ nil ].
	^ border asBlBorder.
	
	 
]

{ #category : '*Roassal3-Bloc' }
RSShape >> blPaint [

	^ self paint ifNil: [ Color transparent ]
]

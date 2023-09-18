Extension { #name : #RSCanvas }

{ #category : #'*Roassal-Bloc' }
RSCanvas >> host [

	^ host
]

{ #category : #'*Roassal-Bloc' }
RSCanvas >> updateBlElement: aRSCanvasElement [ 
	
	"TODO"
]

{ #category : #'*Roassal-Bloc' }
RSCanvas >> useBlocHost [

	host := RSBlocHost new
		        canvas: self;
		        yourself
]

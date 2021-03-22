Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Bloc' }
RSCanvas >> useBlocHost [

	host := RSBlocHost new
		        canvas: self;
		        yourself
]

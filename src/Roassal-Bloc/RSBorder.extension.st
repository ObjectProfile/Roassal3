Extension { #name : #RSBorder }

{ #category : #'*Roassal-Bloc' }
RSBorder >> asBlBorder [
	| builder |
	builder := BlBorder builder
		paint: paint;
		width: width;
		yourself.
	style ifNotNil: [ style blApplyOn: builder ].
	^ builder build.
]

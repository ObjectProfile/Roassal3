Extension { #name : #RSLabel }

{ #category : #'*Roassal3-Bloc' }
RSLabel >> asBlElement [

	^ BlTextElement new
		  text: self blRopedText;
		  background: Color transparent;
		  transformDo: [ :aBuilder | 
			  aBuilder transformation addTransformation:
					  ((BlMatrixTransformation matrix: self matrix asBlMatrix) 
						   origin: BlAffineTransformationCenterOrigin new).
			  aBuilder
				  centerOrigin;
				  translateBy: self textExtents translationPoint ];
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSLabel >> asBlGeometry [
	^ self shouldNotImplement
]

{ #category : #'*Roassal3-Bloc' }
RSLabel >> blRopedText [

	| result |
	result := self text asRopedText 
		foreground: self color;
		background: Color lightGray;
		fontSize: self fontSize;
		fontName: self fontName;
		yourself.
		
	self isBold ifTrue: [ 
		result bold ].
	self isItalic ifTrue: [ 
		result italic ].
	
	^ result
]

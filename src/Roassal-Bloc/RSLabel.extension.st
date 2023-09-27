Extension { #name : #RSLabel }

{ #category : #'*Roassal-Bloc' }
RSLabel >> asBlElement [

	^ (RSLabelElement newWith: self)
		  updateFromRoassalShape;
		  yourself
]

{ #category : #'*Roassal-Bloc' }
RSLabel >> asBlGeometry [

	^ self shouldNotImplement
]

{ #category : #'*Roassal-Bloc' }
RSLabel >> blRopedText [

	| result |
	result := self text asRopedText 
		foreground: self blPaint;
		fontSize: self fontSize;
		fontName: self fontName;
		yourself.
		
	self isBold ifTrue: [ result bold ].
	self isItalic ifTrue: [ result italic ].
	
	self isUnderlined ifTrue: [ 
		result underline.
		result underlineColor: self blPaint ].
	
	^ result
]

{ #category : #'*Roassal-Bloc' }
RSLabel >> updateBlElement: aShapeElement [

	aShapeElement
		text: self blRopedText;
		computeLayout; "Need to force extent calculation"
		transformation: self blTransformation
]

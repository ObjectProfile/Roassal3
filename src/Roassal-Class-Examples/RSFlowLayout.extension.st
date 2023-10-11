Extension { #name : #RSFlowLayout }

{ #category : #'*Roassal-Class-Examples' }
RSFlowLayout class >> exampleLabel [
	
	| words r wordShapes c |
	words := (String loremIpsum: 100) substrings.
	r := Random new.
	wordShapes := words collect: [ :w | 
		RSLabel new
			fontSize: (r nextInteger: 30);
			text: w ] as: RSGroup.

	c := RSCanvas new.
	c addAll: wordShapes.
	self new alignLabel; on: wordShapes.
	c @ RSCanvasController.
	^ c open
]

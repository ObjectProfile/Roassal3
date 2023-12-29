Extension { #name : #ASShape }

{ #category : #'*Roassal-SVG-Importer' }
ASShape >> asShape [
	| shape |
	self display = 'none' ifTrue: [ ^ nil ].
	
	shape := self roassalShape.
	self transform ifNotNil: [ :t | 
		shape matrix: (t multiplyBy: shape matrix).
	].
	
	self fill rsFill: shape with: self.
	self stroke rsStroke: shape with: self.
	^ shape
]

{ #category : #'*Roassal-SVG-Importer' }
ASShape >> roassalShape [
	^ self subclassResponsibility 
]

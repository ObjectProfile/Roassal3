Extension { #name : #ASShape }

{ #category : #'*Roassal3-SVG' }
ASShape >> asShape [
	| shape |
	self display = 'none' ifTrue: [ ^ nil ].
	shape := self roassalShape.
	self fill rsFill: shape with: self.
	self stroke rsStroke: shape with: self.
	^ shape
]

{ #category : #'*Roassal3-SVG' }
ASShape >> roassalShape [
	^ self subclassResponsibility 
]

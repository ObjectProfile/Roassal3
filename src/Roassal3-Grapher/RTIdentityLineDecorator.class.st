Class {
	#name : #RTIdentityLineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal3-Grapher-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTIdentityLineDecorator >> render [	 
	| min max |
	min := builder getPixelPositionOf: builder minX @ builder minY.
	max := builder getPixelPositionOf: builder maxX @ builder maxY.

	self lineFrom: min to: max
]

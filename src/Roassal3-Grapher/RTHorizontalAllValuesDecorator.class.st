Class {
	#name : #RTHorizontalAllValuesDecorator,
	#superclass : #RTAbstractHorizontalValuesDecorator,
	#category : #'Roassal3-Grapher-Builder-Grapher-Decorators'
}

{ #category : #rendering }
RTHorizontalAllValuesDecorator >> render [	
	self addAll: self datasetValuesX asSet. 
	super render.

]

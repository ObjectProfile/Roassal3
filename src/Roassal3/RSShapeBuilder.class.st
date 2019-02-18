"
I can create shapes for roassal based on a model
"
Class {
	#name : #RSShapeBuilder,
	#superclass : #RSAbstractModelBuilder,
	#category : #'Roassal3-Core'
}

{ #category : #'public - accessing' }
RSShapeBuilder >> elementOn: object index: index [
	| el geometry |
	el := self elementClass new.
	el
		model: object;
		index: index.
	geometry := self shapeClass new.
	self updateElement: el innerComponent: geometry.
	
	^ el
	
]

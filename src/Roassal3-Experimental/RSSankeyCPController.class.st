"
TODO
"
Class {
	#name : #RSSankeyCPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #hooks }
RSSankeyCPController >> controlPointsFor: aLine [
	| x1 x2 x3 x4 y1 y2 y3 y4 sy ty |
	
	(aLine hasProperty: #dy) ifFalse: [ ^ { 0@0. 0@0 } ].
	sy := aLine propertyAt: #sy ifAbsent: [0].
	ty := aLine propertyAt: #ty ifAbsent: [0].
	
	x1 := aLine from position x + (aLine from propertyAt: #dx ifAbsent: [0]).
	y1 := aLine from position y + sy
		+ ((aLine propertyAt: #dy ifAbsent: [0])/2)
		- ((aLine from propertyAt: #dy ifAbsent: [0])/2).
	x4 := aLine to position x.
	y4 := aLine to position y + ty 
		+ ((aLine propertyAt: #dy ifAbsent: [0])/2) 
		- ((aLine to propertyAt: #dy ifAbsent: [0])/2).
	
	x2 := x3 := (aLine from position x + aLine to position x) / 2.
	y2 := aLine from position y + (aLine propertyAt: #sy)
		+ ((aLine propertyAt: #dy)/2)
		- ((aLine from propertyAt: #dy)/ 2).
	y3 := aLine to position y + (aLine propertyAt: #ty) 
		+ ((aLine propertyAt: #dy)/2) 
		- ((aLine to propertyAt: #dy)/2).
	^ { x1@y1. x2 @ y2. x3 @ y3. x4@y4 }
]

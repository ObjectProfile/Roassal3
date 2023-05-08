"
I am the vertical tree layout algorithm described in the publication [Drawing non-layered tidy trees in linear time](https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923) by Atze van der Ploeg  ([GitHub companion repo](https://github.com/cwi-swat/non-layered-tidy-trees)).

I use the trait `RSTWalkBasedRegularTreeLayout` to get the main behavior and fullfil the explicit requirements to have a tree layout growing toward the vertical dimension.
"
Class {
	#name : #RSVanDerPloegTreeLayout,
	#superclass : #RSTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayout + RSTWalkBasedRegularTreeLayoutOnShapeProperties + RSTWalkBasedRegularVerticalTreeLayout',
	#classTraits : 'RSTWalkBasedRegularTreeLayout classTrait + RSTWalkBasedRegularTreeLayoutOnShapeProperties classTrait + RSTWalkBasedRegularVerticalTreeLayout classTrait',
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSVanDerPloegTreeLayout >> doInitialize: elements [

	super doInitialize: elements.

	root := self
		        initialize: elements
		        lines: self edges
		        ifMultipleRoots: [ :roots | RSComposite new ]
]

{ #category : #positioning }
RSVanDerPloegTreeLayout >> horizontalGapAmong: aShape and: anotherShape [

	^ self horizontalGap
]

{ #category : #'hook-private' }
RSVanDerPloegTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ self layout: root depth: aPoint y breadth: aPoint x
]

{ #category : #positioning }
RSVanDerPloegTreeLayout >> ongoing: aShape depth: aDepth breadth: aBreadth [

	
]

{ #category : #positioning }
RSVanDerPloegTreeLayout >> verticalGapAmongParent: aShapeParent andChild: aShape [

	^ self verticalGap
]

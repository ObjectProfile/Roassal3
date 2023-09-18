"
I am the vertical tree layout algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

I use the trait `RSTWalkBasedRegularTreeLayout` to get the main behavior and fullfil the explicit requirements to have a tree layout growing toward the vertical dimension.

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSVanDerPloegTreeLayout,
	#superclass : #RSTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayout + RSTWalkBasedRegularTreeLayoutOnShapeProperties + RSTWalkBasedRegularVerticalTreeLayout',
	#classTraits : 'RSTWalkBasedRegularTreeLayout classTrait + RSTWalkBasedRegularTreeLayoutOnShapeProperties classTrait + RSTWalkBasedRegularVerticalTreeLayout classTrait',
	#instVars : [
		'root'
	],
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #hook }
RSVanDerPloegTreeLayout >> doInitialize: elements [

	super doInitialize: elements.

	root := self initialize: elements lineEdges: self edges
]

{ #category : #'private - hook' }
RSVanDerPloegTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ self layout: root depth: aPoint y breadth: aPoint x
]

"
I am a refinement of the Walker algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSVanDerPloegTreeLayout,
	#superclass : #RSTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayout',
	#classTraits : 'RSTWalkBasedRegularTreeLayout classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> breadthGap [

	^ self horizontalGap
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> breadthMeasureOf: aShape [

	^ aShape width
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> depthGap [

	^ self verticalGap
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> depthMeasureOf: aShape [

	^ aShape height
]

{ #category : #hook }
RSVanDerPloegTreeLayout >> doInitialize: elements [

	super doInitialize: elements.

	self initialize: elements edges: self edges
]

{ #category : #'hook-private' }
RSVanDerPloegTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ self layout: rootNodes atPoint: aPoint
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> positionAtDepth: depth atBreadth: breadth [

	^ breadth @ depth
]

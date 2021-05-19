"
I am a refinement of the Walker algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSHorizontalVanDerPloegTreeLayout,
	#superclass : #RSHorizontalTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayout',
	#classTraits : 'RSTWalkBasedRegularTreeLayout classTrait',
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSHorizontalVanDerPloegTreeLayout >> breadthGap [

	^ self verticalGap
]

{ #category : #algorithm }
RSHorizontalVanDerPloegTreeLayout >> breadthMeasureOf: aShape [

	^ aShape height
]

{ #category : #algorithm }
RSHorizontalVanDerPloegTreeLayout >> depthGap [

	^ self horizontalGap
]

{ #category : #algorithm }
RSHorizontalVanDerPloegTreeLayout >> depthMeasureOf: aShape [

	^ aShape width
]

{ #category : #hook }
RSHorizontalVanDerPloegTreeLayout >> doInitialize: elements [

	super doInitialize: elements.

	root := self initialize: elements edges: self edges
]

{ #category : #hook }
RSHorizontalVanDerPloegTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ self layout: root atPoint: aPoint
]

{ #category : #algorithm }
RSHorizontalVanDerPloegTreeLayout >> positionAtDepth: depth atBreadth: breadth [

	^ depth @ breadth
]

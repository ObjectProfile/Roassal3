"
I am the vertical tree layout algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

I use the trait `RSTWalkBasedRegularTreeLayout` to get the main behavior and fullfil the explicit requirements to have a tree layout growing toward the vertical dimension.

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSVanDerPloegTreeLayout,
	#superclass : #RSTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeLayout',
	#classTraits : 'RSTWalkBasedRegularTreeLayout classTrait',
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> breadthGapAmong: aShapeParent and: aShape [

	^ [ self horizontalGap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ self horizontalGap ]
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> breadthMeasureOf: aShape [

	^ aShape width
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> depthGapAmong: aShapeParent and: aShape [

	^ [ self verticalGap value: aShapeParent value: aShape ]
		  onDNU: #value:value:
		  do: [ self verticalGap ]
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> depthMeasureOf: aShape [

	^ aShape height
]

{ #category : #hook }
RSVanDerPloegTreeLayout >> doInitialize: elements [

	super doInitialize: elements.

	root := self initialize: elements edges: self edges
]

{ #category : #'hook-private' }
RSVanDerPloegTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ self layout: root atPoint: aPoint
]

{ #category : #algorithm }
RSVanDerPloegTreeLayout >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ breadth @ depth
]

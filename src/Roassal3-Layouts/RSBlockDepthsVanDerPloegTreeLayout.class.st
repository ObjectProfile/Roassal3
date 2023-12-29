Class {
	#name : 'RSBlockDepthsVanDerPloegTreeLayout',
	#superclass : 'RSVanDerPloegTreeLayout',
	#traits : 'RSTWalkBasedRegularTreeGapsBlockDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsBlockDepth classTrait',
	#category : 'Roassal3-Layouts-Core',
	#package : 'Roassal3-Layouts',
	#tag : 'Core'
}

{ #category : 'positioning' }
RSBlockDepthsVanDerPloegTreeLayout >> verticalGapAmongParent: aShapeParent andChild: aShape [

	^ self
		  gapAmongParent: aShapeParent
		  andChild: aShape
		  default:
		  (super verticalGapAmongParent: aShapeParent andChild: aShape)
		  layout: self
]

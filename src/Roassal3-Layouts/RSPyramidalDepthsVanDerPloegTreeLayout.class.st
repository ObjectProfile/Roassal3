Class {
	#name : 'RSPyramidalDepthsVanDerPloegTreeLayout',
	#superclass : 'RSVanDerPloegTreeLayout',
	#traits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth classTrait',
	#category : 'Roassal3-Layouts-Core',
	#package : 'Roassal3-Layouts',
	#tag : 'Core'
}

{ #category : 'positioning' }
RSPyramidalDepthsVanDerPloegTreeLayout >> verticalGapAmongParent: aShapeParent andChild: aShape [

	^ self
		  gapAmongParent: aShapeParent
		  andChild: aShape
		  default:
		  (super verticalGapAmongParent: aShapeParent andChild: aShape)
		  layout: self
]
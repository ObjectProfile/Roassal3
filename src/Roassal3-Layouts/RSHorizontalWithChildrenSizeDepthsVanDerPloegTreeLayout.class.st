Class {
	#name : 'RSHorizontalWithChildrenSizeDepthsVanDerPloegTreeLayout',
	#superclass : 'RSHorizontalVanDerPloegTreeLayout',
	#traits : 'RSTWalkBasedRegularTreeGapsChildrenSizeDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsChildrenSizeDepth classTrait',
	#category : 'Roassal3-Layouts-Core',
	#package : 'Roassal3-Layouts',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSHorizontalWithChildrenSizeDepthsVanDerPloegTreeLayout >> horizontalGapAmongParent: aShapeParent andChild: aShape [

	^ self
		  gapAmongParent: aShapeParent
		  andChild: aShape
		  default:
		  (super horizontalGapAmongParent: aShapeParent andChild: aShape)
		  layout: self
]
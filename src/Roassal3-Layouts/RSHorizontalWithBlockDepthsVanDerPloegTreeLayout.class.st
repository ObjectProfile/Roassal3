Class {
	#name : #RSHorizontalWithBlockDepthsVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsBlockDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsBlockDepth classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSHorizontalWithBlockDepthsVanDerPloegTreeLayout >> horizontalGapAmongParent: aShapeParent andChild: aShape [

	^ self
		  gapAmongParent: aShapeParent
		  andChild: aShape
		  default:
		  (super horizontalGapAmongParent: aShapeParent andChild: aShape)
		  layout: self
]

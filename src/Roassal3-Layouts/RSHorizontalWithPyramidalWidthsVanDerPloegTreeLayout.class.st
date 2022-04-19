Class {
	#name : #RSHorizontalWithPyramidalWidthsVanDerPloegTreeLayout,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSHorizontalWithPyramidalWidthsVanDerPloegTreeLayout >> horizontalGapAmongParent: aShapeParent andChild: aShape [

	^ self
		  gapAmongParent: aShapeParent
		  andChild: aShape
		  default:
		  (super horizontalGapAmongParent: aShapeParent andChild: aShape)
		  layout: self
]

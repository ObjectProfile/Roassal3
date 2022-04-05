Class {
	#name : #RSHorizontalVanDerPloegTreeLayoutWithPyramidalDepthGaps,
	#superclass : #RSHorizontalVanDerPloegTreeLayout,
	#traits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth',
	#classTraits : 'RSTWalkBasedRegularTreeGapsPyramidalDepth classTrait',
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSHorizontalVanDerPloegTreeLayoutWithPyramidalDepthGaps >> horizontalGapAmongParent: aParent andChild: aChild [

	^ self
		  gapAmongParent: aParent
		  andChild: aChild
		  default:
		  (super horizontalGapAmongParent: aParent andChild: aChild)
]

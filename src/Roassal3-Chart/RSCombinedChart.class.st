Class {
	#name : #RSCombinedChart,
	#superclass : #RSCompositeChart,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #color }
RSCombinedChart >> defaultPlotColors [

	^ NSScale google20
]

{ #category : #initialization }
RSCombinedChart >> defaultStyler [

	^ RSChartStyler new
]

{ #category : #hooks }
RSCombinedChart >> renderIn: aCanvas [

	decorations, plots do: [ :element |
		element beforeRenderingIn: self.
		element renderIn: aCanvas ].
	shapes := decorations, plots
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

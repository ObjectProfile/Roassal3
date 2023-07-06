Class {
	#name : #RSCombinedChart,
	#superclass : #RSCompositeChart,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSCombinedChart >> add: aPlot [

	elements add: aPlot.
	aPlot decorations removeAll.
	aPlot chart: self.
	^ aPlot
]

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

	elements do: [ :element |
		element beforeRenderingIn: self.
		element renderIn: aCanvas ].
	shapes := elements
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

Class {
	#name : #RSCombinedChart,
	#superclass : #RSCompositeChart,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #hooks }
RSCombinedChart >> renderIn: aCanvas [

	elements do: [ :element |
		element beforeRenderingIn: self.
		element renderIn: aCanvas ].
	shapes := elements
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

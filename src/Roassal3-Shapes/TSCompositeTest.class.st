"
I am test class for composite shapes in roassal
"
Class {
	#name : #TSCompositeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
TSCompositeTest >> testPaddingOkay [
	"No error should be raised"
	
	TSComposite new
		shapes: (RSGroup new add: TSBox new; yourself);
		padding: 5.

	TSComposite new
		shapes: (RSGroup new add: TSBox new; add: TSBox new; yourself);
		padding: 5.
		
	TSComposite new
		shapes: (RSGroup new);
		padding: 5.
]

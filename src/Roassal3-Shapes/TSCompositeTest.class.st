"
I am test class for composite shapes in roassal
"
Class {
	#name : #TSCompositeTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
TSCompositeTest >> testPaddingOkay [
	"No error should be raised"
	
	TSComposite new
		shapes: (TSGroup new add: TSBox new; yourself);
		padding: 5.

	TSComposite new
		shapes: (TSGroup new add: TSBox new; add: TSBox new; yourself);
		padding: 5.
		
	TSComposite new
		shapes: (TSGroup new);
		padding: 5.
]

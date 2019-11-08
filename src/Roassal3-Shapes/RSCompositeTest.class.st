"
I am test class for composite shapes in roassal
"
Class {
	#name : #RSCompositeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSCompositeTest >> testPaddingOkay [
	"No error should be raised"
	
	RSComposite new
		shapes: (RSGroup new add: RSBox new; yourself);
		padding: 5.

	RSComposite new
		shapes: (RSGroup new add: RSBox new; add: RSBox new; yourself);
		padding: 5.
		
	RSComposite new
		shapes: (RSGroup new);
		padding: 5.
]

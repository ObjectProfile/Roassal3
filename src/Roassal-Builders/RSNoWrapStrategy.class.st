"
This does not apply a wrap in the text
"
Class {
	#name : #RSNoWrapStrategy,
	#superclass : #RSAbstractWrapStrategy,
	#category : #'Roassal3-Builders-Text'
}

{ #category : #initialization }
RSNoWrapStrategy >> initialize [
	"Subclasses should redefine this method to perform initializations on instance creation"
]

{ #category : #hooks }
RSNoWrapStrategy >> wrapTextFor: aString with: aRSMultilineLabelBuilder [
	^ aRSMultilineLabelBuilder basicShapeFor: aString
]

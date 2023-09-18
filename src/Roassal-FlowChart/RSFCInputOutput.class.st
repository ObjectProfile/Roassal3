Class {
	#name : #RSFCInputOutput,
	#superclass : #RSFCSymbol,
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCInputOutput >> accept: visitor [
	visitor visitInputOutput: self
]

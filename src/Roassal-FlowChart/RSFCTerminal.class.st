Class {
	#name : #RSFCTerminal,
	#superclass : #RSFCSymbol,
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCTerminal >> accept: visitor [
	visitor visitTerminal: self
]

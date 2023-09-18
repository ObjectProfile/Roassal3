Class {
	#name : #RSFCProcess,
	#superclass : #RSFCSymbol,
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCProcess >> accept: visitor [
	visitor visitProcess: self
]

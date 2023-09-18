Class {
	#name : #RSFCVisitor,
	#superclass : #Object,
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCVisitor >> visitDecision: decision [
]

{ #category : #visiting }
RSFCVisitor >> visitFlowchart: flowchart [
	flowchart elements do: [ :e | e accept: self ]
]

{ #category : #visiting }
RSFCVisitor >> visitFlowline: flowline [
]

{ #category : #visiting }
RSFCVisitor >> visitInputOutput: flowline [
]

{ #category : #visiting }
RSFCVisitor >> visitProcess: process [
]

{ #category : #visiting }
RSFCVisitor >> visitTerminal: terminal [
]

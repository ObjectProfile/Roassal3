Class {
	#name : #RSFCSymbol,
	#superclass : #RSObject,
	#instVars : [
		'label'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCSymbol >> accept: visitor [
	self subclassResponsibility
]

{ #category : #accessing }
RSFCSymbol >> label [
	^ label
]

{ #category : #accessing }
RSFCSymbol >> label: aString [
	label := aString
]

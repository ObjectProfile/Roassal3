"
Abstract descriptor for UML artifacts
"
Class {
	#name : #RSUMLAbstractModelDescriptor,
	#superclass : #RS3Object,
	#category : #'Roassal3-UML-Base'
}

{ #category : #testing }
RSUMLAbstractModelDescriptor class >> isAbstract [ 
	^self name = #RSUMLAbstractModelDescriptor 
]

{ #category : #public }
RSUMLAbstractModelDescriptor >> forPharo [

	self subclassResponsibility 
]

{ #category : #initialization }
RSUMLAbstractModelDescriptor >> initialize [
	super initialize.
	self forPharo.
]

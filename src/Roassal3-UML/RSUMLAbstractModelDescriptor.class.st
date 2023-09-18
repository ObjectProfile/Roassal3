"
Abstract descriptor for UML artifacts
"
Class {
	#name : #RSUMLAbstractModelDescriptor,
	#superclass : #RSObject,
	#category : #'Roassal3-UML-Descriptor'
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
	self forPharo
]

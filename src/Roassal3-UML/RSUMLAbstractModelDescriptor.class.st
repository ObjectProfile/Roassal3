"
Abstract descriptor for UML artifacts
"
Class {
	#name : 'RSUMLAbstractModelDescriptor',
	#superclass : 'RSObject',
	#category : 'Roassal3-UML-Descriptor',
	#package : 'Roassal3-UML',
	#tag : 'Descriptor'
}

{ #category : 'testing' }
RSUMLAbstractModelDescriptor class >> isAbstract [
	^self name = #RSUMLAbstractModelDescriptor
]

{ #category : 'public' }
RSUMLAbstractModelDescriptor >> forPharo [

	self subclassResponsibility
]

{ #category : 'initialization' }
RSUMLAbstractModelDescriptor >> initialize [
	super initialize.
	self forPharo
]

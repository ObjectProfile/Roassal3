"
A package descriptor
"
Class {
	#name : #RSUMLPackageDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'packagename'
	],
	#category : #'Roassal3-UML-Base'
}

{ #category : #public }
RSUMLPackageDescriptor >> forPharo [

	self
		packagename: #name
]

{ #category : #accessing }
RSUMLPackageDescriptor >> packagename [
	^ packagename
]

{ #category : #accessing }
RSUMLPackageDescriptor >> packagename: anObject [
	packagename := anObject
]

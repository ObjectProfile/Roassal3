"
A package descriptor
"
Class {
	#name : #RSUMLPackageDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'packagename',
		'classes',
		'classname'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #accessing }
RSUMLPackageDescriptor >> classes [
	^ classes
]

{ #category : #accessing }
RSUMLPackageDescriptor >> classes: anObject [
	classes := anObject
]

{ #category : #accessing }
RSUMLPackageDescriptor >> classname [
	^ classname
]

{ #category : #accessing }
RSUMLPackageDescriptor >> classname: anObject [
	classname := anObject
]

{ #category : #public }
RSUMLPackageDescriptor >> forPharo [
	self
		packagename: #name;
		classes: [:pkg| pkg definedClasses sorted: Behavior sortBlock ];
		classname: #name
]

{ #category : #accessing }
RSUMLPackageDescriptor >> packagename [
	^ packagename
]

{ #category : #accessing }
RSUMLPackageDescriptor >> packagename: anObject [
	packagename := anObject
]

"
I have information about how to accessing to one class in the Roassal Uml class builder
"
Class {
	#name : #RSUMLClassDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'instVars',
		'methods',
		'methodSelector',
		'instVarSelector',
		'classname',
		'superclass'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #accessing }
RSUMLClassDescriptor >> classname [
	^ classname
]

{ #category : #accessing }
RSUMLClassDescriptor >> classname: aSymbolOrBlock [
	"In classname N is because this method does not have relation with className method"
	classname := aSymbolOrBlock
]

{ #category : #public }
RSUMLClassDescriptor >> forPharo [
	self
		classname: #name;
		instVars: [:cls | cls instVarNames sorted ];
		methods: [ :cls | cls methods sorted: CompiledMethod sortBlock ];
		superclass: #superclass;
		methodSelector: #selector;
		instVarSelector: #yourself
		
]

{ #category : #accessing }
RSUMLClassDescriptor >> instVarSelector [
	^ instVarSelector
]

{ #category : #accessing }
RSUMLClassDescriptor >> instVarSelector: aSymbolOrBlock [
	instVarSelector := aSymbolOrBlock
]

{ #category : #accessing }
RSUMLClassDescriptor >> instVars [
	^ instVars
]

{ #category : #accessing }
RSUMLClassDescriptor >> instVars: aSymbolOrBlock [
	instVars := aSymbolOrBlock
]

{ #category : #accessing }
RSUMLClassDescriptor >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
RSUMLClassDescriptor >> methodSelector: aSymbolOrBlock [
	methodSelector := aSymbolOrBlock
]

{ #category : #accessing }
RSUMLClassDescriptor >> methods [
	^ methods
]

{ #category : #accessing }
RSUMLClassDescriptor >> methods: aSymbolOrBlock [
	methods := aSymbolOrBlock
]

{ #category : #accessing }
RSUMLClassDescriptor >> superclass [
	^ superclass
]

{ #category : #accessing }
RSUMLClassDescriptor >> superclass: aSymbolOrBlock [
	superclass := aSymbolOrBlock
]

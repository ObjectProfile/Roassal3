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
		'superclass',
		'methodsLimit',
		'aggregations',
		'compositions',
		'isAbstract'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #accessing }
RSUMLClassDescriptor >> aggregations [
	^ aggregations
]

{ #category : #accessing }
RSUMLClassDescriptor >> aggregations: aCollection [
	aggregations := aCollection
]

{ #category : #accessing }
RSUMLClassDescriptor >> classname [
	^ classname
]

{ #category : #accessing }
RSUMLClassDescriptor >> classname: aSymbolOrBlock [
	"In classname N is because this method does not have relation with className method"
	classname := aSymbolOrBlock
]

{ #category : #accessing }
RSUMLClassDescriptor >> compositions [
	^ compositions
]

{ #category : #accessing }
RSUMLClassDescriptor >> compositions: aCollection [
	compositions := aCollection
]

{ #category : #public }
RSUMLClassDescriptor >> forPharo [
	self
		classname: #name;
		instVars: [:cls | cls instVarNames sorted ];
		methods: [ :cls | cls methods sorted: CompiledMethod sortBlock ];
		isAbstract: #isAbstract;
		superclass: #superclass;
		methodSelector: #selector;
		instVarSelector: #yourself;
		methodsLimit: SmallInteger maxVal
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
RSUMLClassDescriptor >> isAbstract [
	^ isAbstract
]

{ #category : #accessing }
RSUMLClassDescriptor >> isAbstract: aBlockOrString [
	isAbstract := aBlockOrString
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
RSUMLClassDescriptor >> methodsLimit [
	^ methodsLimit
]

{ #category : #accessing }
RSUMLClassDescriptor >> methodsLimit: aNumber [
	self assert: aNumber >= 1 description: 'Cannot have a negative limit'.
	methodsLimit := aNumber
]

{ #category : #accessing }
RSUMLClassDescriptor >> superclass [
	^ superclass
]

{ #category : #accessing }
RSUMLClassDescriptor >> superclass: aSymbolOrBlock [
	superclass := aSymbolOrBlock
]

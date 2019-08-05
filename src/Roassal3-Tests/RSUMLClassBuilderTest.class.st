Class {
	#name : #RSUMLClassBuilderTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-UML'
}

{ #category : #tests }
RSUMLClassBuilderTest >> testBasic [
	| builder classes |
	classes := RSAttachPoint withAllSubclasses.
	builder := RSUMLClassBuilder new.
	builder classes: classes.
	builder build.
	self assert: builder elements size equals: classes size.
]

{ #category : #tests }
RSUMLClassBuilderTest >> testJustClassName [
	| builder element  |
	builder := RSUMLClassBuilder new.
	builder classes: {TSMouseMove}.
	builder build.
	element := builder elements first.
	self assert: element children size equals: 2.
	self assert: element shapes first class equals: TSBox.
	self assert: element shapes second class equals: TSLabel.
	
	builder := RSUMLClassBuilder new.
	builder classes: {TSMouseMove}.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	element := builder elements first.
	self assert: element children size equals: 3.
	self assert: element shapes first class equals: TSBox.
	self assert: element shapes second class equals: TSLabel.
	self assert: element shapes third class equals: TSBox.
]

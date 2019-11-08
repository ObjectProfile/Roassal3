Class {
	#name : #RSUMLClassBuilderTest,
	#superclass : #RSTest,
	#category : #'Roassal3-UML-Tests'
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
	builder classes: {RSMouseMove}.
	builder build.
	element := builder elements first.
	self assert: element children size equals: 2.
	self assert: element shapes first class equals: RSBox.
	self assert: element shapes second class equals: RSLabel.
	
	builder := RSUMLClassBuilder new.
	builder classes: {RSMouseMove}.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	element := builder elements first.
	self assert: element children size equals: 3.
	self assert: element shapes first class equals: RSBox.
	self assert: element shapes second class equals: RSLabel.
	self assert: element shapes third class equals: RSBox.
]

"
I have examples of how to manage the uml builder in different cases
"
Class {
	#name : #RSUmlExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-UML'
}

{ #category : #examples }
RSUmlExamples >> example01Basic [ 
	<script: 'self new example01Basic'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: Collection withAllSubclasses.
	builder build.
	builder open setLabel: 'Collection withAllSubclasses'.
	
]

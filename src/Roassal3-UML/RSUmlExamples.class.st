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
	builder classes: ByteSymbol withAllSubclasses.
	builder build.
	builder view when: TSExtentChangedEvent do: [ builder view zoomToFit ].
	builder open setLabel: 'Collection withAllSubclasses'.
	
]

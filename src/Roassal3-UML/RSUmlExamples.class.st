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
	builder classes: RSAttachPoint withAllSubclasses.
	builder build.
	builder view when: TSExtentChangedEvent do: [ builder view zoomToFit ].
	builder open
]

{ #category : #examples }
RSUmlExamples >> example02ClassDescriptor [
	<script: 'self new example02ClassDescriptor'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: TSAbstractLine withAllSubclasses.
	
	builder classDescriptor 
		methods: [ :cls | | methods |
			methods := cls methods sorted: [ :a :b |
				a selector < b selector ].
			methods copyFrom: 1
			to: (methods size min: 5 ) ].
		
	builder build.
	builder view when: TSExtentChangedEvent do: [ builder view zoomToFit ].
	builder open
]

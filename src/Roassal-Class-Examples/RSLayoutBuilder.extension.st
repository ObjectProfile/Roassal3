Extension { #name : #RSLayoutBuilder }

{ #category : #'*Roassal-Class-Examples' }
RSLayoutBuilder class >> exampleTidyTree [
	| canvas notConnected |
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	notConnected := {self. RSEvent. RSShape }.
	RSLayout 
		canvasExampleIn: canvas
		models: SequenceableCollection withAllSubclasses,
			Set withAllSubclasses, notConnected.
	self new tidyTree; on: canvas nodes.
	^ canvas open.
]

"
I am the top class for interactions in roassal.

You can add an interaction to an instance of RSElement or RSEdge or RSView with: 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
element addInteraction: RSDraggable.
edge addInteraction: (RSHighlightable new).
view @ RSDraggableView.
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

"
Class {
	#name : 'RSInteraction',
	#superclass : 'RSObject',
	#category : 'Roassal-Interaction-Core',
	#package : 'Roassal-Interaction',
	#tag : 'Core'
}

{ #category : 'examples' }
RSInteraction class >> canvasExample [
	| canvas |
	canvas := RSCanvas new.
	canvas background: 'veryVeryLightGray'.
	canvas originCenterMiddle.

	canvas add: (RSEllipse new
		position: 0@0;
		extent: 10@10;
		borderColor: 'black';
		model: 'origin';
		color: 'red';
		yourself).

	canvas add: (RSBox new
		position: 200@200;
		extent: 200@200;
		borderColor: 'black';
		model: 'white';
		fill: 255;
		yourself).

	canvas add: (RSBox new
		position: 200@200;
		extent: 100@100;
		borderColor: 'black';
		model: 'gray';
		fill: 100;
		yourself).
	canvas shapes @ RSPopup.
	^ canvas
]

{ #category : 'instance creation' }
RSInteraction class >> onShape: aShape [
	| inst |
	inst := self new.
	inst onShape: aShape.
	^ inst
]

{ #category : 'hooks' }
RSInteraction >> onShape: aShape [
	self subclassResponsibility
]

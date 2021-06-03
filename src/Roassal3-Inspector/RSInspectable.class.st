"
I allow to inspect another view or windows. It can be configurable to set the kind of view you want to inspect
"
Class {
	#name : #RSInspectable,
	#superclass : #RSInteraction,
	#instVars : [
		'highlightable',
		'inspectorWindow',
		'inspectShapeBlock',
		'selectedShape'
	],
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #hooks }
RSInspectable >> deselectIfNecessary [
	"Nothing to unselect"
	selectedShape ifNil: [ ^ self ].
	highlightable doUnhighlight: selectedShape
	
]

{ #category : #accessing }
RSInspectable >> highlightable [
	^ highlightable
]

{ #category : #accessing }
RSInspectable >> highlightable: anObject [
	highlightable := anObject
]

{ #category : #hooks }
RSInspectable >> initialize [
	super initialize.
	highlightable := RSHighlightableInteraction new.
]

{ #category : #accessing }
RSInspectable >> inspectElementBlock [
	^ inspectShapeBlock
]

{ #category : #hooks }
RSInspectable >> inspectShape: aShape [
	| oldInspectorWindow canvasMorph |
	self deselectIfNecessary.
	selectedShape := aShape.
	highlightable doHighlight: selectedShape.
	
	oldInspectorWindow := inspectorWindow.
	inspectorWindow := inspectShapeBlock rsValue: aShape model.
	inspectorWindow setLabel: aShape model asString.
	canvasMorph := aShape canvas morph.
	canvasMorph root activate.
	"If there is a previous inspector window, then we use the same position and extent"
	oldInspectorWindow ifNil: [ ^ self ].
	inspectorWindow 
		position: oldInspectorWindow position;
		extent: oldInspectorWindow extent.
	oldInspectorWindow delete.
	oldInspectorWindow := nil
	
	
]

{ #category : #accessing }
RSInspectable >> inspectShapeBlock: oneArgBlock [
	"The block should return a window"
	inspectShapeBlock := oneArgBlock
]

{ #category : #hooks }
RSInspectable >> onShape: aShape [
	aShape 
		when: RSMouseLeftClick
		do: [ :evt | self inspectShape: aShape ]
]

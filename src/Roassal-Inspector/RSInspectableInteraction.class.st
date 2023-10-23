"
I allow to inspect another view or windows. It can be configurable to set the kind of view you want to inspect
"
Class {
	#name : 'RSInspectableInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'highlightable',
		'inspectorWindow',
		'inspectShapeBlock',
		'selectedShape'
	],
	#category : 'Roassal-Inspector-Interactions',
	#package : 'Roassal-Inspector',
	#tag : 'Interactions'
}

{ #category : 'hooks' }
RSInspectableInteraction >> deselectIfNecessary [
	"Nothing to unselect"
	selectedShape ifNil: [ ^ self ].
	highlightable doUnhighlight: selectedShape
]

{ #category : 'accessing' }
RSInspectableInteraction >> highlightable [
	^ highlightable
]

{ #category : 'accessing' }
RSInspectableInteraction >> highlightable: anObject [
	highlightable := anObject
]

{ #category : 'initialization' }
RSInspectableInteraction >> initialize [
	super initialize.
	highlightable := RSHighlightable new
]

{ #category : 'accessing' }
RSInspectableInteraction >> inspectElementBlock [
	^ inspectShapeBlock
]

{ #category : 'hooks' }
RSInspectableInteraction >> inspectShape: aShape [
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

{ #category : 'accessing' }
RSInspectableInteraction >> inspectShapeBlock: oneArgBlock [
	"The block should return a window"
	inspectShapeBlock := oneArgBlock
]

{ #category : 'hooks' }
RSInspectableInteraction >> onShape: aShape [
	aShape
		when: RSMouseLeftClick
		do: [ :evt | self inspectShape: aShape ]
		for: self
]

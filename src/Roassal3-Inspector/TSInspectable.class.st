"
I allow to inspect another view or windows. It can be configurable to set the kind of view you want to inspect
"
Class {
	#name : #TSInspectable,
	#superclass : #TSInteraction,
	#instVars : [
		'selectedElement',
		'highlightable',
		'inspectorWindow',
		'inspectShapeBlock'
	],
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
TSInspectable >> deselectIfNecessary [
	"Nothing to unselect"
	selectedElement ifNil: [ ^ self ].
	
	highlightable doUnhighlightElement: selectedElement
	
	"Does not have a previous color"
	"(selectedElement attributes includesKey: #oldColor) ifFalse: [ ^ self ].

	selectedElement color: (selectedElement attributes at: #oldColor).
	selectedElement attributes removeKey: #oldColor"
]

{ #category : #accessing }
TSInspectable >> highlightable [
	^ highlightable
]

{ #category : #accessing }
TSInspectable >> highlightable: anObject [
	highlightable := anObject
]

{ #category : #hooks }
TSInspectable >> initialize [
	super initialize.
	highlightable := TSHighlightable new.
]

{ #category : #hooks }
TSInspectable >> inspectElement: anElement [
	| oldInspectorWindow viewMorph |
	self deselectIfNecessary.
	selectedElement := anElement.
	highlightable doHighlightElement: selectedElement.
	
	oldInspectorWindow := inspectorWindow.
	inspectorWindow := inspectShapeBlock rsValue: anElement model.
	inspectorWindow setLabel: anElement model asString.
	viewMorph := anElement view canvas morph.
	viewMorph root activate.
	"viewMorph takeKeyboardFocus."
	"If there is a previous inspector window, then we use the same position and extent"
	oldInspectorWindow ifNil: [ ^ self ].
	inspectorWindow 
		position: oldInspectorWindow position;
		extent: oldInspectorWindow extent.
	oldInspectorWindow delete.
	oldInspectorWindow := nil
	
	
]

{ #category : #accessing }
TSInspectable >> inspectElementBlock [
	^ inspectShapeBlock
]

{ #category : #accessing }
TSInspectable >> inspectShapeBlock: oneArgBlock [
	"The block should return a window"
	inspectShapeBlock := oneArgBlock
]

{ #category : #hooks }
TSInspectable >> onShape: aShape [
	
	aShape when: TSMouseLeftClick do: [ :evt | 
		self inspectElement: aShape ]
]

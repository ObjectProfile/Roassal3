"
I allow to inspect another view or windows. It can be configurable to set the kind of view you want to inspect
"
Class {
	#name : #RSInspectable,
	#superclass : #RSInteraction,
	#instVars : [
		'selectedElement',
		'highlightable',
		'inspectorWindow',
		'inspectElementBlock'
	],
	#category : #'Roassal3-Inspector'
}

{ #category : #hooks }
RSInspectable >> deselectIfNecessary [
	"Nothing to unselect"
	selectedElement ifNil: [ ^ self ].
	
	highlightable doUnhighlightElement: selectedElement
	
	"Does not have a previous color"
	"(selectedElement attributes includesKey: #oldColor) ifFalse: [ ^ self ].

	selectedElement color: (selectedElement attributes at: #oldColor).
	selectedElement attributes removeKey: #oldColor"
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
	highlightable := RSHighlightable new.
]

{ #category : #hooks }
RSInspectable >> inspectElement: anElement [
	| oldInspectorWindow viewMorph |
	self deselectIfNecessary.
	selectedElement := anElement.
	highlightable doHighlightElement: selectedElement.
	
	oldInspectorWindow := inspectorWindow.
	inspectorWindow := inspectElementBlock rsValue: anElement model.
	inspectorWindow setLabel: anElement model asString.
	viewMorph := anElement view canvas morph.
	viewMorph root activate.
	"viewMorph takeKeyboardFocus."
	"If there is a previous inspector window, then we use the same position and extent"
	oldInspectorWindow ifNil: [ ^ self ].
	inspectorWindow position: oldInspectorWindow position.
	inspectorWindow extent: oldInspectorWindow extent.
	oldInspectorWindow delete.
	oldInspectorWindow := nil
	
	
]

{ #category : #accessing }
RSInspectable >> inspectElementBlock [
	^ inspectElementBlock
]

{ #category : #accessing }
RSInspectable >> inspectElementBlock: oneArgBlock [
	"The block should return a window"
	inspectElementBlock := oneArgBlock
]

{ #category : #hooks }
RSInspectable >> onElement: anElement [
	
	anElement when: TSMouseLeftClick do: [ :evt | 
		self inspectElement: anElement ]
]

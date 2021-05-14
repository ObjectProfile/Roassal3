"
I am a basic Renderer for roassal3 presentation based on morphs
"
Class {
	#name : #GLMMorphicRoassal3Renderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'myMorph'
	],
	#category : #'Roassal3-Pharo8'
}

{ #category : #rendering }
GLMMorphicRoassal3Renderer >> render: aRoassalPresentation [
	aRoassalPresentation 
		setUpInteractions;
		when: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.

	myMorph :=aRoassalPresentation canvas createMorph.
	myMorph takeKeyboardFocus.
	aRoassalPresentation canvas when: RSMouseClick do: [ myMorph takeKeyboardFocus ].
	^ myMorph
]

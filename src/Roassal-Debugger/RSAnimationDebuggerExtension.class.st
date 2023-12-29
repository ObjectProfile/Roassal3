"
An experimental debugger for Roassal animations
"
Class {
	#name : #RSAnimationDebuggerExtension,
	#superclass : #SpPresenterWithModel,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'canvas',
		'debugger'
	],
	#category : #'Roassal-Debugger'
}

{ #category : #layout }
RSAnimationDebuggerExtension >> debuggerLayout [

	^ SpBoxLayout newVertical.
]

{ #category : #initialization }
RSAnimationDebuggerExtension >> updatePresenter [ 
	(debugger interruptedContext findContextSuchThat: [:ctx | ctx receiver isKindOf: RSAbstractAnimation]) ifNotNil: [ :ctx| 
		canvas := ctx receiver canvas. 
		canvas ifNotNil: [ 
			| canvasCopy |
			canvasCopy := RSCanvas new.
			canvasCopy color: canvas color.
			canvasCopy addAll: (canvas shapes collect: #copy).
			canvasCopy addAll: (canvas fixedShapes collect: #copy).
			self layout: (SpBoxLayout newTopToBottom 
				add: (SpMorphPresenter new
					morph: canvasCopy createMorph;
					yourself);
				yourself).
			 ].
		  ]
]

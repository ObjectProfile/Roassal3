"
An experimental debugger for roassal3 animations
"
Class {
	#name : #RSDebuggerExtension,
	#superclass : #SpPresenterWithModel,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'canvas',
		'debugger'
	],
	#category : #'Roassal3-Debugger'
}

{ #category : #specs }
RSDebuggerExtension class >> defaultSpec [ 
	^ SpBoxLayout newTopToBottom 
]

{ #category : #'as yet unclassified' }
RSDebuggerExtension class >> showInContext: aContext [

	^(aContext findContextSuchThat: [:ctx | ctx receiver isKindOf: RSAbstractAnimation]) notNil
]

{ #category : #'debugger extension' }
RSDebuggerExtension >> debuggerExtensionToolName [
	^'Roassal animation view'
]

{ #category : #'debugger extension' }
RSDebuggerExtension >> displayOrder [
	^ self class displayOrder
]

{ #category : #initialization }
RSDebuggerExtension >> setModelBeforeInitialization: aDebugger [
	debugger := aDebugger
]

{ #category : #initialization }
RSDebuggerExtension >> updatePresenter [ 
	(debugger interruptedContext findContextSuchThat: [:ctx | ctx receiver isKindOf: RSAbstractAnimation]) ifNotNil: [ :ctx| 
		canvas := ctx receiver canvas. 
		canvas ifNotNil: [ 
			| canvasCopy |
			canvasCopy := RSCanvas new.
			canvasCopy color: canvas color.
			canvasCopy addAll: (canvas shapes collect: #copy).
			canvasCopy addAll: (canvas fixedShapes collect: #copy).
			self layout: (SpBoxLayout newTopToBottom 
				add: (SpMorphPresenter  new
					morph: canvasCopy createMorph;
					yourself);
				yourself).
			 ].
		  ]
]

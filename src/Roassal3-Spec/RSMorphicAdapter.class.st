"
I am bridging RoassalPresenter and RTView
"
Class {
	#name : #RSMorphicAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #initialization }
RSMorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget trachelCanvas.
	view := canvas view.
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self basicApplyScript.
]

{ #category : #'scripting actions' }
RSMorphicAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #'scripting actions' }
RSMorphicAdapter >> basicApplyScript [
	self model script cull: view.
	self widgetDo: #startStepping.
	
	view when: TSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #factory }
RSMorphicAdapter >> buildWidget [
	^ RSView new canvas createMorph
]

{ #category : #'scripting actions' }
RSMorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp trachelCanvas.
	view := canvas view.
	widget canvas: canvas.
	canvas morph: widget.
]

{ #category : #initialization }
RSMorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

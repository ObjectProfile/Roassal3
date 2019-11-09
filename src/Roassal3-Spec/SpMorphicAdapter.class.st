"
I am bridging RoassalPresenter and RTView
"
Class {
	#name : #SpMorphicAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #initialization }
SpMorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget roassalCanvas.
	view := canvas view.
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self basicApplyScript.
]

{ #category : #'scripting actions' }
SpMorphicAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #'scripting actions' }
SpMorphicAdapter >> basicApplyScript [
	self model script value: view.
	self widgetDo: #startStepping.
	
	view when: RSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #factory }
SpMorphicAdapter >> buildWidget [
	^ RSView new canvas createMorph
]

{ #category : #'scripting actions' }
SpMorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp roassalCanvas.
	view := canvas view.
	widget canvas: canvas.
	canvas morph: widget.
]

{ #category : #initialization }
SpMorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

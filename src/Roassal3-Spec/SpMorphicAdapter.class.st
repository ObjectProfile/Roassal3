"
I am bridging RoassalPresenter and RTView
"
Class {
	#name : #SpMorphicAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #initialization }
SpMorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget roassalCanvas.
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
	self model script value: canvas.
	self model canvas: canvas.
	self widgetDo: #startStepping.
	canvas when: RSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #factory }
SpMorphicAdapter >> buildWidget [
	^ RSCanvas new createMorph
]

{ #category : #'scripting actions' }
SpMorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp roassalCanvas.
	widget canvas: canvas.
	canvas morph: widget.
]

{ #category : #initialization }
SpMorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

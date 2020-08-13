"
I am bridging RoassalPresenter and RTView
"
Class {
	#name : #SpRoassalMorphicAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #initialization }
SpRoassalMorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget roassalCanvas.
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self basicApplyScript.
]

{ #category : #'scripting actions' }
SpRoassalMorphicAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #'scripting actions' }
SpRoassalMorphicAdapter >> basicApplyScript [
	self model script value: canvas.
	self model canvas: canvas.
	self widgetDo: #startStepping.
	canvas when: RSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #factory }
SpRoassalMorphicAdapter >> buildWidget [
	^ RSCanvas new createMorph
]

{ #category : #'scripting actions' }
SpRoassalMorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp roassalCanvas.
	widget canvas: canvas.
	canvas morph: widget.
	canvas extent: widget extent.
]

{ #category : #initialization }
SpRoassalMorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

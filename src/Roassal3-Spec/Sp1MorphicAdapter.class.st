"
I am bridging RoassalPresenter and RSView
"
Class {
	#name : #Sp1MorphicAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #initialization }
Sp1MorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget trachelCanvas.
	view := canvas view.
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self basicApplyScript.
]

{ #category : #initialization }
Sp1MorphicAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #initialization }
Sp1MorphicAdapter >> basicApplyScript [
	self model script value: view.
	self widgetDo: #startStepping.
	
	view when: RSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #initialization }
Sp1MorphicAdapter >> buildWidget [
	^ RSView new canvas createMorph
]

{ #category : #initialization }
Sp1MorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp trachelCanvas.
	view := canvas view.
	widget canvas: canvas.
	canvas morph: widget.
]

{ #category : #initialization }
Sp1MorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

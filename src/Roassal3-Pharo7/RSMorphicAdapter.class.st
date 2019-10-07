"
I am bridging RoassalPresenter and RSView
"
Class {
	#name : #RSMorphicAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #'Roassal3-Pharo7'
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

{ #category : #initialization }
RSMorphicAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #initialization }
RSMorphicAdapter >> basicApplyScript [
	self model script value: view.
	self widgetDo: #startStepping.
	
	view when: TSAbstractMouseEvent do: [ widget takeKeyboardFocus].
]

{ #category : #initialization }
RSMorphicAdapter >> buildWidget [
	^ RSView new canvas createMorph
]

{ #category : #initialization }
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

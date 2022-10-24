"
I am bridging RoassalPresenter and RTView
"
Class {
	#name : #SpMorphicRoassalAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Spec-Morphic'
}

{ #category : #'class initialization' }
SpMorphicRoassalAdapter class >> initialize [ 

	"we need to reset the cached adapter bindigns"
	SpNullApplication reset
]

{ #category : #initialization }
SpMorphicRoassalAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget roassalCanvas.
	self model currentCanvas ifNotNil: [ :aCanvas |
		widget canvas: aCanvas.
		aCanvas 
			morph: widget;
			extent: widget extent.
		widget sessionChanged.
		canvas := aCanvas.
		 ].
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self basicApplyScript.
]

{ #category : #'scripting actions' }
SpMorphicRoassalAdapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #'scripting actions' }
SpMorphicRoassalAdapter >> basicApplyScript [
	self model script value: canvas.
	self model canvas: canvas.
	self widgetDo: #startStepping.
	canvas when: RSMouseClick send: #takeKeyboardFocus to: widget.
]

{ #category : #factory }
SpMorphicRoassalAdapter >> buildWidget [
	^ RSCanvas new createMorph
]

{ #category : #'scripting actions' }
SpMorphicRoassalAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp roassalCanvas.
	widget canvas: canvas.
	canvas morph: widget.
	canvas extent: widget extent.
]

{ #category : #initialization }
SpMorphicRoassalAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

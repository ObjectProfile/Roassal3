"
I am bridging RoassalPresenter and RSView
"
Class {
	#name : #Sp1MorphicAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Spec-Obsolete'
}

{ #category : #initialization }
Sp1MorphicAdapter >> adapt: aComposableModel [
	super adapt: aComposableModel.
	canvas := widget roassalCanvas.
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
	self model script value: canvas.
	self widgetDo: #startStepping.
	
	canvas when: RSMouseEnter do: [ widget takeKeyboardFocus].
]

{ #category : #initialization }
Sp1MorphicAdapter >> buildWidget [
	^ RSCanvas new createMorph
]

{ #category : #initialization }
Sp1MorphicAdapter >> freeCanvas [
	| temp |
	temp := self buildWidget.
	canvas := temp roassalCanvas.
	widget canvas: canvas.
	canvas morph: widget.
]

{ #category : #initialization }
Sp1MorphicAdapter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

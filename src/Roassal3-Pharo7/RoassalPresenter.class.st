"
I am a basic presenter for widgets in roassal with the Spec system
"
Class {
	#name : #RoassalPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'script'
	],
	#category : #'Roassal3-Pharo7'
}

{ #category : #specs }
RoassalPresenter class >> adapterName [
	^ #RSMorphicAdapter
]

{ #category : #specs }
RoassalPresenter class >> defaultSpec [
	<spec>
	
	^ #(RSMorphicAdapter
		adapt: #(model))
]

{ #category : #initialization }
RoassalPresenter >> initialize [
	super initialize.
	script := [ :v | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #initialization }
RoassalPresenter >> refresh [ 
	self changed: #applyScript with: #()
]

{ #category : #initialization }
RoassalPresenter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #initialization }
RoassalPresenter >> script [
	^ script value
]

{ #category : #initialization }
RoassalPresenter >> script: anObject [
	script value: anObject
]

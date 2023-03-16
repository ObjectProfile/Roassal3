"
I am a basic presenter for widgets in roassal with the Spec system
"
Class {
	#name : #Sp1RoassalPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'script'
	],
	#category : #'Roassal3-Spec-Obsolete'
}

{ #category : #specs }
Sp1RoassalPresenter class >> adapterName [
	^ #Sp1MorphicAdapter
]

{ #category : #specs }
Sp1RoassalPresenter class >> defaultSpec [
	<spec>
	
	^ #(#Sp1MorphicAdapter
		adapt: #(model))
]

{ #category : #initialization }
Sp1RoassalPresenter >> initialize [
	super initialize.
	script := [ :v | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #initialization }
Sp1RoassalPresenter >> refresh [ 
	self changed: #applyScript with: #()
]

{ #category : #initialization }
Sp1RoassalPresenter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #initialization }
Sp1RoassalPresenter >> script [
	^ script value
]

{ #category : #initialization }
Sp1RoassalPresenter >> script: anObject [
	script value: anObject
]

"
I am a basic presenter for widgets in roassal with the Spec system
"
Class {
	#name : #SpRoassalPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'script'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #specs }
SpRoassalPresenter class >> adapterName [
	^ #SpMorphicAdapter
]

{ #category : #specs }
SpRoassalPresenter class >> defaultSpec [
	<spec>
	
	^ #(#SpMorphicAdapter
		adapt: #(model))
]

{ #category : #'instance creation' }
SpRoassalPresenter class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
SpRoassalPresenter >> initialize [
	super initialize.
	script := [ :v | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #public }
SpRoassalPresenter >> refresh [ 
	self changed: #applyScript with: #()
]

{ #category : #dependencies }
SpRoassalPresenter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #accessing }
SpRoassalPresenter >> script [
	^ script value
]

{ #category : #accessing }
SpRoassalPresenter >> script: anObject [
	script value: anObject
]

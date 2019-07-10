"
I am a basic presenter for widgets in roassal with the Spec system
"
Class {
	#name : #RoassalPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'script'
	],
	#category : #'Roassal3-Spec-Core'
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

{ #category : #'instance creation' }
RoassalPresenter class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
RoassalPresenter >> initialize [
	super initialize.
	script := [ :v :canvas | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #public }
RoassalPresenter >> refresh [ 
	self changed: #applyScript with: #()
]

{ #category : #dependencies }
RoassalPresenter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #accessing }
RoassalPresenter >> script [
	^ script value
]

{ #category : #accessing }
RoassalPresenter >> script: anObject [
	script value: anObject
]

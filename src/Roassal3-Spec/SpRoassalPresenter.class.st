"
I am a basic presenter for widgets in roassal with the Spec system
"
Class {
	#name : #SpRoassalPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#script',
		'#currentCanvas'
	],
	#category : #'Roassal3-Spec-Core'
}

{ #category : #specs }
SpRoassalPresenter class >> adapterName [
	^ #RoassalAdapter
]

{ #category : #'instance creation' }
SpRoassalPresenter class >> on: anOwningPresenter withCanvas: aTrachelCanvas [

	^ self basicNew
		owner: anOwningPresenter;
		canvas: aTrachelCanvas;
		initialize;
		yourself
]

{ #category : #'instance creation' }
SpRoassalPresenter class >> open [
	<script>
	^ self new open
]

{ #category : #accessing }
SpRoassalPresenter >> canvas [
	^ currentCanvas ifNil: [ currentCanvas := RSCanvas new ]
]

{ #category : #accessing }
SpRoassalPresenter >> canvas: aRSCanvas [
	currentCanvas := aRSCanvas
]

{ #category : #accessing }
SpRoassalPresenter >> currentCanvas [
	^ currentCanvas
]

{ #category : #initialization }
SpRoassalPresenter >> initialize [
	super initialize.
	script := [ :aCanvas | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ]
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

{ #category : #accessing }
SpRoassalPresenter >> whenPresenterResized: aBlock [

	self announcer
		when: PresenterResized
		do: [ :ann | aBlock cull: ann extent ]
]

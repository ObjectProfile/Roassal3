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
	^ self new openWithSpec
]

{ #category : #accessing }
SpRoassalPresenter >> canvas [
	^ currentCanvas
]

{ #category : #accessing }
SpRoassalPresenter >> canvas: aRSCanvas [ 
	currentCanvas := aRSCanvas
]

{ #category : #initialization }
SpRoassalPresenter >> initialize [
	super initialize.
	script := [ :v | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #initialization }
SpRoassalPresenter >> initializePrivateHooks [

	currentCanvas ifNil: [ currentCanvas := RSCanvas new ].
	
	super initializePrivateHooks
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

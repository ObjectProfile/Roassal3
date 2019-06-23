Class {
	#name : #RoassalSpecTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Spec'
}

{ #category : #tests }
RoassalSpecTest >> testBasic [
	| spec value window |
	spec := RoassalPresenter new.
	self assert: spec class equals: RoassalPresenter.
	window := spec openWithSpec.
	value := 0.
	spec script: [ :view :canvas| view addShape: TSBox new. value := value + 1 ].
	self assert: value equals: 1.
	spec script: [ :view :canvas| view addShape: TSBox new. value := 0 ].
	self assert: value equals: 0.
	window delete.
]

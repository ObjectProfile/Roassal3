Class {
	#name : #RoassalSpecTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Spec-Tests'
}

{ #category : #tests }
RoassalSpecTest >> testBasic [
	| spec value window |
	"comment"
	spec := Smalltalk globals at: #SpRoassalPresenter 
		ifPresent: [:cls | cls new]
		ifAbsent: [^ self ].
	self assert: spec class equals: SpRoassalPresenter.
	window := spec open.
	value := 0.
	
	spec script: [ :view | view addShape: RSBox new. value := value + 1 ].
	self assert: value equals: 1.
	spec script: [ :view | view addShape: RSBox new. value := 0 ].
	self assert: value equals: 0.
	window close.
]

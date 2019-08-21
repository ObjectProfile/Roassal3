Class {
	#name : #RoassalSpecTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Spec-Tests'
}

{ #category : #tests }
RoassalSpecTest >> testBasic [
	| spec value window |
	"comment"
	spec := Smalltalk globals at: #RoassalPresenter 
		ifPresent: [:cls | cls new]
		ifAbsent: [^ self ].
	self assert: spec class equals: RoassalPresenter.
	window := spec openWithSpec.
	value := 0.
	
	spec script: [ :view | view addShape: TSBox new. value := value + 1 ].
	self assert: value equals: 1.
	spec script: [ :view | view addShape: TSBox new. value := 0 ].
	self assert: value equals: 0.
	window close.
]

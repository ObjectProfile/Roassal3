"
I have tests for RSView
"
Class {
	#name : #RSViewTest,
	#superclass : #TSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #running }
RSViewTest >> setUp [
	super setUp.
	view := RSView new.
]

{ #category : #tests }
RSViewTest >> testElementFromModel [

	| els |
	els := RSShapeBuilder box elementsOn: (1 to: 3).
	view addAll: els.

	self assert: (view elementFromModel: 1) == els first.
	self assert: (view elementFromModel: 2) == els second.
	self assert: (view elementFromModel: 3) == els third.
]

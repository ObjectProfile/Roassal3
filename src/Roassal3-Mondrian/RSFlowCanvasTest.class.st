Class {
	#name : #RSFlowCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'c',
		'shapes',
		'f'
	],
	#category : #'Roassal3-Mondrian-Flow'
}

{ #category : #running }
RSFlowCanvasTest >> setUp [
	super setUp.
	f := RSFlowCanvas new.
	f when: SmallInteger visualize: [ :canvas :number |
		shapes := RSCircle models: (1 to: number).
		canvas addAll: shapes.
		shapes @ RSLabeledInteraction @ RSPopup @ RSDraggableInteraction.
		RSNormalizer size
			shapes: shapes;
			normalize: #yourself.
		RSFlowLayout on: shapes.
		canvas @ RSCanvasController.
	].
	
]

{ #category : #tests }
RSFlowCanvasTest >> testBreadcrumbs [

	self assert: f breadcrumbs isEmpty.
	
	self assert: f canvas numberOfNodes equals: 1.
	f clickOnModel: 20.
	self assert: f breadcrumbs equals: { 20 }.
	self assert: f canvas numberOfNodes equals: 22.
]

{ #category : #tests }
RSFlowCanvasTest >> testNestedNodes [

	| nb box compo |
	nb := 0.
	
	c := RSCanvas new.
	box := RSBox model: 42.
	compo := RSComposite new.
	compo model: 'hello'.
	compo add: box.
	c add: compo.
	 
	f := RSFlowCanvas new.
	f setOnCanvas: c.
	f when: String visualize: [ :canvas :str | nb := nb + 1 ].
	f when: Object visualize: [ :canvas :str | nb := nb + 10 ].

	self assert: nb equals: 0.
	
	box announce: RSMouseClick.
	self assert: nb equals: 10.
]

{ #category : #tests }
RSFlowCanvasTest >> testSubtyping [

	| nb |
	nb := 0.
	f := RSFlowCanvas new.
	f when: String visualize: [ :canvas :str | nb := nb + 1 ].
	f when: Object visualize: [ :canvas :str | nb := nb + 10 ].

	self assert: nb equals: 0.

	f clickOnModel: Color.
	self assert: nb equals: 10.	
	
	f clickOnModel: 42.
	self assert: nb equals: 20.
	
	f clickOnModel: 'hello'.
	self assert: nb equals: 31.
]

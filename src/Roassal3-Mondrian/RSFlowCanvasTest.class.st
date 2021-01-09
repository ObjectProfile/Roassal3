Class {
	#name : #RSFlowCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'c',
		'shapes',
		'f'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #running }
RSFlowCanvasTest >> setUp [

	f := RSFlowCanvas new.
	f when: SmallInteger visualize: [ :canvas :number |
		shapes := RSCircle models: (1 to: number).
		canvas addAll: shapes.
		shapes @ RSLabeled @ RSPopup @ RSDraggable.
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
	
	self assert: f canvas numberOfNodes equals: 0.
	f clickOnModel: 20.
	self assert: f breadcrumbs equals: { 20 }.
	self assert: f canvas numberOfNodes equals: 20.
]

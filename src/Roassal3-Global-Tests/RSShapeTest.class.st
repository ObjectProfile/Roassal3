Class {
	#name : #RSShapeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Shapes'
}

{ #category : #tests }
RSShapeTest >> testHasModel [

	self deny: RSCircle new hasModel.
	self assert: (RSShape new model: 52) hasModel.
	self assert: (RSLine new model: 52) hasModel.
	self deny: RSLine new hasModel.
]

{ #category : #tests }
RSShapeTest >> testModels [

	| shapes |
	shapes := RSCircle models: (1 to: 10).
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asSet asArray equals: #(10)
]

{ #category : #tests }
RSShapeTest >> testModelsSize [

	| shapes |
	shapes := RSCircle models: (1 to: 10) size: #yourself.
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asArray equals: (1 to: 10) asArray.
	self assert: (shapes collect: #height) asArray equals: (1 to: 10) asArray
]

{ #category : #tests }
RSShapeTest >> testTranslateMiddleRightTo [

	| c center lbl |
	c := RSCanvas new.

	center := RSEllipse new size: 2; color: Color red.
	c add: center.
	center translateTo: 0 @ 0.

	lbl := RSLabel text: 'Middle right corner'.
	c add: lbl.
	lbl translateMiddleRightTo: 0 @ 0.
	
	self assert: (lbl position x < 0).
	self assert: (lbl position y = 0).
	
]

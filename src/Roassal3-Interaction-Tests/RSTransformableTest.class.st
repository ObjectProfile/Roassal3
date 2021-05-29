Class {
	#name : #RSTransformableTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
RSTransformableTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := (1 to: 5) 
		collect: [ :i | RSBox new size: 10; position: 10@10 * i]
		as: RSGroup.
	canvas addAll: shapes.
]

{ #category : #running }
RSTransformableTest >> testBasic [
	shapes @ RSTransformableInteraction.
	
]

{ #category : #running }
RSTransformableTest >> testBasic02 [
	| s interaction handles |
	interaction := RSTransformableInteraction new.
	shapes @ interaction .
	s := shapes first.
	s announce: RSMouseLeftClick new.
	self assert: canvas shapes size > shapes size.
	handles := canvas propertyAt: interaction key.
	self assert: handles notNil.
	self assert: handles isNotEmpty.
	
	canvas announce: RSMouseClick new.
	
	self assert: canvas shapes size equals: shapes size.
	handles := canvas propertyAt: interaction key.
	self assert: handles isNil.
	
	
	
]

{ #category : #running }
RSTransformableTest >> testCornerDirections [
	| interaction base new |
	interaction := RSTransformableInteraction new.
	base := 20@20 corner: 100@100.
	
	new := interaction bottomRight: 10@120 rectangle: base.
	self assert: new equals: 20@20 -> (10@120).
	
	new := interaction bottomCenter: 10@120 rectangle: base.
	self assert: new equals: 20@20 -> (100@120).
	
	new := interaction bottomLeft: 0@120 rectangle: base.
	self assert: new equals: 0@20 -> (100@120).
	
	new := interaction topLeft: 0@0 rectangle: base.
	self assert: new equals: 0@0 -> (100@100).
	
	new := interaction topCenter: 50@0 rectangle: base.
	self assert: new equals: 20@0 -> (100@100).
	
	new := interaction topRight: 120@0 rectangle: base.
	self assert: new equals: 20@0 -> (120@100).
	
	new := interaction leftCenter: 0@120 rectangle: base.
	self assert: new equals: 0@20 -> (100@100).
	
	new := interaction rightCenter: 120@120 rectangle: base.
	self assert: new equals: 20@20 -> (120@100).
]

{ #category : #running }
RSTransformableTest >> testDrag [
	| s interaction |
	interaction := RSTransformableInteraction new.
	shapes @ interaction .
	s := shapes first.
	s announce: RSMouseLeftClick new.
	self assert: (canvas propertyAt: interaction key) notNil.
	s announce: RSMouseDragStart new.
	self assert: (canvas propertyAt: interaction key) isNil.
	s announce: RSMouseDragEnd new.
	self assert: (canvas propertyAt: interaction key) notNil.
]

{ #category : #running }
RSTransformableTest >> testDrag2 [
	| s interaction |
	interaction := RSTransformableInteraction new.
	shapes @ interaction .
	s := shapes first.
	s announce: RSMouseDragStart new.
	self assert: (canvas propertyAt: interaction key) isNil.
	s announce: RSMouseDragEnd new.
	self assert: (canvas propertyAt: interaction key) isNil.
]

{ #category : #running }
RSTransformableTest >> testUpdateShape [
	| s interaction rect handles |
	interaction := RSTransformableInteraction new.
	shapes @ interaction .
	s := shapes first.
	s announce: RSMouseLeftClick new.
	rect := s encompassingRectangle.
	handles := (canvas propertyAt: interaction key).
	self assert: handles first class equals: RSPolygon.
	handles second 
		translateTo: 10@10.
	self deny: rect equals: s encompassingRectangle.
	
]

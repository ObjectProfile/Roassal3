Class {
	#name : 'RSCircleTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Shapes-Tests',
	#package : 'Roassal-Shapes-Tests'
}

{ #category : 'tests' }
RSCircleTest >> testBasic [

	self assert: (RSCircle new extent) equals: 10 @ 10
]

{ #category : 'tests' }
RSCircleTest >> testCenter [
	| center circle |
	center := 100 asPoint.
	circle := RSCircle new
		radius: 10;
		center: center;
		yourself.
	self assert: circle center equals: center
]

"
Similar like TreeMap, but with circles
"
Class {
	#name : #RSCircularTreeMap,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'shape'
	],
	#category : #'Roassal3-TreeMap'
}

{ #category : #initialization }
RSCircularTreeMap >> defaultShape [
	^ RSCircle new
		noPaint;
		withBorder;
		yourself
]

{ #category : #initialization }
RSCircularTreeMap >> initialize [
	super initialize.
	shape := self defaultShape
]

{ #category : #accessing }
RSCircularTreeMap >> shape [
	^ shape
]

{ #category : #hooks }
RSCircularTreeMap >> shapeFor: anObject [
	^ shape copy new
		model: anObject;
		yourself
]

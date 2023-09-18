"
TODO
"
Class {
	#name : #RSIdentityMatrix,
	#superclass : #RSObject,
	#instVars : [
		'rows'
	],
	#category : #'Roassal-Layouts-Util'
}

{ #category : #accessing }
RSIdentityMatrix >> at: u [
	| row |
	row := rows
		at: u
		ifAbsentPut: [IdentityDictionary new].
	^row keys
]

{ #category : #accessing }
RSIdentityMatrix >> at: u at: v [
	| row |
	row := rows
		at: u
		ifAbsentPut: [IdentityDictionary new].
	^row
		at: v
		ifAbsent: [false]
]

{ #category : #accessing }
RSIdentityMatrix >> at: u at: v put: aBoolean [
	| row |
	"u -> v"
	row := rows
		at: u
		ifAbsentPut: [IdentityDictionary new].
	row at: v put: aBoolean.	"v -> u"
	row := rows
		at: v
		ifAbsentPut: [IdentityDictionary new].
	row at: u put: aBoolean
]

{ #category : #initialization }
RSIdentityMatrix >> initialize [
	rows := IdentityDictionary new
]

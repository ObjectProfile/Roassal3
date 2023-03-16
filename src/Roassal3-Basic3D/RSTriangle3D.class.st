"
I am a basic triangle in 3d
"
Class {
	#name : #RSTriangle3D,
	#superclass : #Object,
	#instVars : [
		'v1',
		'v2',
		'v3',
		'color'
	],
	#category : #'Roassal3-Basic3D-Core'
}

{ #category : #actions }
RSTriangle3D >> addedIn: mesh [
	| i1 i2 i3 |
	i1 := mesh addVertex: v1.
	i2 := mesh addVertex: v2.
	i3 := mesh addVertex: v3.
	mesh addTriangle: { i1. i2. i3 } -> color
]

{ #category : #accessing }
RSTriangle3D >> color [
	^ color
]

{ #category : #accessing }
RSTriangle3D >> color: aColor [
	color := aColor
]

{ #category : #actions }
RSTriangle3D >> mult: array [
	v1 := self mult: v1 with: array.
	v2 := self mult: v2 with: array.
	v3 := self mult: v3 with: array
]

{ #category : #actions }
RSTriangle3D >> mult: vertex with: array [
	^ vertex collectWithIndex: [ :k :j |
		k * (array at: j) ]
]

{ #category : #accessing }
RSTriangle3D >> v1 [
	^ v1
]

{ #category : #accessing }
RSTriangle3D >> v1: a3dPoint [
	v1 := a3dPoint asOrderedCollection
]

{ #category : #accessing }
RSTriangle3D >> v2 [
	^ v2
]

{ #category : #accessing }
RSTriangle3D >> v2: a3dPoint [
	v2 := a3dPoint asOrderedCollection
]

{ #category : #accessing }
RSTriangle3D >> v3 [
	^ v3
]

{ #category : #accessing }
RSTriangle3D >> v3: a3dPoint [
	v3 := a3dPoint asOrderedCollection
]

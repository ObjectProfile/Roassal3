"
I am a basic data for this basic 3d
"
Class {
	#name : #RSData3D,
	#superclass : #Object,
	#instVars : [
		'extent',
		'tmat',
		'view',
		'meshes',
		'elements',
		'cubeShape'
	],
	#category : #'Roassal3-Basic3D-TODO'
}

{ #category : #accessing }
RSData3D >> cube [
	^ cubeShape
]

{ #category : #initialization }
RSData3D >> initialize [
	super initialize.
	cubeShape := RSMShape3D cube
]

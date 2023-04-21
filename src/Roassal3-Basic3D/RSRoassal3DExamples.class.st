"
I have basic examples of Roassal3d
"
Class {
	#name : #RSRoassal3DExamples,
	#superclass : #Object,
	#category : #'Roassal3-Basic3D-Examples'
}

{ #category : #examples }
RSRoassal3DExamples >> example01Ball [
	<script: 'self new example01Ball inspect'>
	| space mesh list |
	space := RSSpace3D new.
	mesh := RSMesh3D new.
	list := RSMesh3D tetrahedron.
	list := RSMesh3D inflate: list.
	list := RSMesh3D inflate: list.
	list := RSMesh3D inflate: list.
	mesh addAll: list.

	space add: mesh.
	space build.
	^ space
]

{ #category : #examples }
RSRoassal3DExamples >> example02Rect [
	<script: 'self new example02Rect inspect'>
	| space mesh |
	space := RSSpace3D new.
	mesh := RSMesh3D cubeWidth: 100 height: 20 depth: 200.
	space add: mesh.
	space build.
	"space canvas newAnimation
		duration: 20 seconds;
		from: 0;
		to: 360;
		onStepDo: [ :t |
			space meshes first matrix
				identity
				xrot: t degreesToRadians.
			space draw.
			space canvas zoomToFit.
			 ]."
	^ space
]

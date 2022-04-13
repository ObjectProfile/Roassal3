Class {
	#name : #RSUnaryLinspaceParameterization,
	#superclass : #RSLinspaceParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'accessing - structure variables' }
RSUnaryLinspaceParameterization >> samples: n [

	self from: 0 to: 1 samples: n
]

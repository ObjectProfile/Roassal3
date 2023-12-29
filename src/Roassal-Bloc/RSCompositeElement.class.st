"
I'm a Bloc element that is associated with a RSComposite.
"
Class {
	#name : #RSCompositeElement,
	#superclass : #RSShapeElement,
	#category : #'Roassal-Bloc-Elements'
}

{ #category : #adding }
RSCompositeElement >> addBlocToRoassalEventHandler: aHandler [

	super addBlocToRoassalEventHandler: aHandler.
	
	self allChildrenDepthFirstDo: [ :each |
		each addEventHandler: aHandler ]
]

{ #category : #refreshing }
RSCompositeElement >> updateFromRoassalShape [

	super updateFromRoassalShape.
	
	self childrenDo: [ :each | each updateFromRoassalShape ]
]

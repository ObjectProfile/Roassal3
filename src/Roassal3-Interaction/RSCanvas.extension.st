Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction [
	^ self propertyAt: RSCanvasController
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction: aCanvasController [
	self propertyAt: RSCanvasController put: aCanvasController
]

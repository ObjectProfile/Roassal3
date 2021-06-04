Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction [
	^ self propertyAt: RSCanvasControllerInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction: aCanvasController [
	self propertyAt: RSCanvasControllerInteraction put: aCanvasController
]

Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction [
	^ self propertyAt: RSCanvasController
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> controllerInteraction: aCanvasController [
	self propertyAt: RSCanvasController put: aCanvasController
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectedShapes [
	^ self propertyAt: #selectedShapes ifAbsent: [ #() ]
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectedShapes: aGroupOfShapes [
	self propertyAt: #selectedShapes put: aGroupOfShapes.
]

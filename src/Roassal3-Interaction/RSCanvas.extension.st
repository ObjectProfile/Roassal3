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
RSCanvas >> searchInteraction [
	
	^ self propertyAt: RSSearchInCanvasInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> searchInteraction: anRSSearchInCanvasInteraction [
	
	self propertyAt: RSSearchInCanvasInteraction put: anRSSearchInCanvasInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectedShapes [
	^ self propertyAt: #selectedShapes ifAbsent: [ #() ]
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectedShapes: aGroupOfShapes [
	self propertyAt: #selectedShapes put: aGroupOfShapes
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectionInteraction [
	
	^ self propertyAt: RSSelectionInCanvasInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> selectionInteraction: aRSSelectionInCanvasInteraction [

	self
		propertyAt: RSSelectionInCanvasInteraction
		put: aRSSelectionInCanvasInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> setSelectedShapes: aGroupOfShapes [

	self
		assert: self selectionInteraction notNil
		description:
		'This canvas has no selection interaction. RSSelectionInCanvasInteraction has to be added to canvas.'.
	self selectionInteraction setSelectedShapes: aGroupOfShapes on: self
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> shadowInteraction [
	^ self propertyAt: RSShadowInteraction
]

{ #category : #'*Roassal3-Interaction' }
RSCanvas >> shadowInteraction: aRSShadowInteraction [ 
	self propertyAt: RSShadowInteraction put: aRSShadowInteraction
]

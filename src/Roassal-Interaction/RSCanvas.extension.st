Extension { #name : 'RSCanvas' }

{ #category : '*Roassal-Interaction' }
RSCanvas >> controllerInteraction [
	^ self propertyAt: RSCanvasController
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> controllerInteraction: aCanvasController [
	self propertyAt: RSCanvasController put: aCanvasController
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> searchInteraction [

	^ self propertyAt: RSSearchInCanvasInteraction
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> searchInteraction: anRSSearchInCanvasInteraction [

	self propertyAt: RSSearchInCanvasInteraction put: anRSSearchInCanvasInteraction
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> selectedShapes [
	^ self propertyAt: #selectedShapes ifAbsent: [ #() ]
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> selectedShapes: aGroupOfShapes [
	self propertyAt: #selectedShapes put: aGroupOfShapes
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> selectionInteraction [

	^ self propertyAt: RSSelectionInCanvasInteraction
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> selectionInteraction: aRSSelectionInCanvasInteraction [

	self
		propertyAt: RSSelectionInCanvasInteraction
		put: aRSSelectionInCanvasInteraction
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> setSelectedShapes: aGroupOfShapes [

	self
		assert: self selectionInteraction notNil
		description:
		'This canvas has no selection interaction. RSSelectionInCanvasInteraction has to be added to canvas.'.
	self selectionInteraction setSelectedShapes: aGroupOfShapes on: self
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> shadowInteraction [
	^ self propertyAt: RSShadowInteraction
]

{ #category : '*Roassal-Interaction' }
RSCanvas >> shadowInteraction: aRSShadowInteraction [
	self propertyAt: RSShadowInteraction put: aRSShadowInteraction
]

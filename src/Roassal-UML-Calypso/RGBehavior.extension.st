Extension { #name : 'RGBehavior' }

{ #category : '*Roassal-UML-Calypso' }
RGBehavior >> buildUMLCanvasWithBrowserTool: tool [
	^ nil
]

{ #category : '*Roassal-UML-Calypso' }
RGBehavior >> isTestCase [
	^false
]

{ #category : '*Roassal-UML-Calypso' }
RGBehavior >> shouldUseUMLClassTab [
	^ true
]

{ #category : '*Roassal-UML-Calypso' }
RGBehavior >> withAllSuperAndSubclasses [
	"Answer the receiver's class hierarchy"

	^self allSuperclasses, self withAllSubclasses
]

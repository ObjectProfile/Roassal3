Extension { #name : #RGBehavior }

{ #category : #'*Roassal3-UML-Calypso' }
RGBehavior >> buildUMLCanvasWithBrowserTool: tool [
	^ nil
]

{ #category : #'*Roassal3-UML-Calypso' }
RGBehavior >> isTestCase [
	^false
]

{ #category : #'*Roassal3-UML-Calypso' }
RGBehavior >> shouldUseUMLClassTab [
	^ true
]

{ #category : #'*Roassal3-UML-Calypso' }
RGBehavior >> withAllSuperAndSubclasses [
	"Answer the receiver's class hierarchy"

	^self allSuperclasses, self withAllSubclasses
]

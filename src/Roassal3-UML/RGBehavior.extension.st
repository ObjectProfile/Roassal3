Extension { #name : #RGBehavior }

{ #category : #'*Roassal3-UML' }
RGBehavior >> buildUMLCanvasWithBrowserTool: tool [
	^ nil
]

{ #category : #'*Roassal3-UML' }
RGBehavior >> isTestCase [
	^false
]

{ #category : #'*Roassal3-UML' }
RGBehavior >> shouldUseUMLClassTab [
	^ true
]

{ #category : #'*Roassal3-UML' }
RGBehavior >> withAllSuperAndSubclasses [
	"Answer the receiver's class hierarchy"

	^self allSuperclasses, self withAllSubclasses
]

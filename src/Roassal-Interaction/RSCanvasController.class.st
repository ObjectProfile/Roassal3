"
I the main interaction that handles roassal3 general control about a canvas
I interact with the Abstract class `RSAbstractControlCanvasInteraction` and its subclasses.
- interactions: users can access and add new interactions. check also `defaultInteractions`
- configuration: a configurable object shared by the interaction to know configuration about the controller.

To use it just do
```
canvas @ RSCanvasController.
""canvas addInteraction: RSCanvasController""
```

or you can create an instance:
```
controller := RSCanvasController new.
controller noLegend.
canvas @ controller.
```
"
Class {
	#name : #RSCanvasController,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'interactions',
		'configuration'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'instance creation' }
RSCanvasController class >> simple [
	| inst |
	inst := self new.
	inst noLegend.
	inst zoomToFitInteraction
		noZoomToFitOnStart;
		noZoomToFitOnExtendChanged.
	inst removeInteractionIfPresent: RSZoomToFitCanvasInteraction.
	"this interaction works better when the visualization has already been created"
	inst addInteractionClass: RSKeepCanvasPositionCanvasInteraction.
	^ inst
]

{ #category : #accessing }
RSCanvasController >> addInteraction: anInteractionObject [
	interactions at: anInteractionObject class put: anInteractionObject.
	anInteractionObject configuration: configuration
]

{ #category : #accessing }
RSCanvasController >> addInteractionClass: anInteractionClass [
	"This method is commanded for public use."
	self addInteraction: anInteractionClass new
]

{ #category : #accessing }
RSCanvasController >> configuration [
	^ configuration
]

{ #category : #accessing }
RSCanvasController >> configuration: aRSControlLimits [
	configuration := aRSControlLimits.
	self interactions do: [ :i | i configuration: configuration ]
]

{ #category : #initialization }
RSCanvasController >> defaultInteractions [
	"create a subclass of RSCanvasController and define your own custom interactions for your canvas"

	^ {
		  RSDraggableCanvasInteraction.
		  RSKeyNavigationCanvasInteraction.
		  RSZoomToFitCanvasInteraction.
		  RSZoomableCanvasInteraction.
		  RSScrollBarsCanvasInteraction.
		  RSSelectionInCanvasInteraction.
		  RSSearchInCanvasInteraction }
]

{ #category : #accessing }
RSCanvasController >> draggableCanvasInteraction [
	^ interactions at: RSDraggableCanvasInteraction
]

{ #category : #initialization }
RSCanvasController >> initialize [
	super initialize.
	self interactionsFromArray: (self defaultInteractions collect: #new).
	self configuration: RSControlConfiguration new
]

{ #category : #accessing }
RSCanvasController >> interactions [
	^ interactions
]

{ #category : #accessing }
RSCanvasController >> interactions: aCollectionOfInteractions [
	interactions := aCollectionOfInteractions
]

{ #category : #accessing }
RSCanvasController >> interactionsFromArray: anArray [
	"{RSZoomableCanvasInteraction new. RSSearchInCanvasInteraction new}"
	| collection |
	collection := OrderedDictionary new.
	anArray do: [ :int |
		collection at: int class put: int ].
	self interactions: collection
]

{ #category : #accessing }
RSCanvasController >> keyNavigationInteraction [
	^ interactions at: RSKeyNavigationCanvasInteraction
]

{ #category : #configuration }
RSCanvasController >> noLegend [
	self configuration noLegend
]

{ #category : #hooks }
RSCanvasController >> onShape: aCanvas [
	aCanvas controllerInteraction ifNotNil: [ ^ self ].
	aCanvas controllerInteraction: self.
	self interactions do: [ :int | int onShape: aCanvas ].
	self renderLegendOn: aCanvas
]

{ #category : #accessing }
RSCanvasController >> removeInteractionIfPresent: anInteractionClass [
	interactions removeKey: anInteractionClass ifAbsent: [  ]
]

{ #category : #hooks }
RSCanvasController >> renderLegendOn: aCanvas [
	| lb |
	self shouldShowLegend ifFalse: [ ^ self ].
	lb := RSLegend new
		container: aCanvas;
		yourself.
	lb defaultTitle fontSize: 12.
	lb defaultLabel fontSize: 10.
	lb defaultBoldText fontSize: 10.
	lb legendDo: [ :l |
		l
			border: RSBorder new;
			color: (Color white alpha: 0.8);
			padding: 10.
		].
	lb title: 'Shortcuts'.
	self interactions do: [ :int | int renderLegendOn: lb ].
	lb onDemand.
	lb build
]

{ #category : #testing }
RSCanvasController >> shouldShowLegend [
	^ self configuration shouldShowLegend
]

{ #category : #configuration }
RSCanvasController >> withLegend [
	self configuration withLegend
]

{ #category : #accessing }
RSCanvasController >> withoutSelectionBox [

	self removeInteractionIfPresent: RSSelectionInCanvasInteraction
]

{ #category : #accessing }
RSCanvasController >> zoomToFitInteraction [
	^ interactions at: RSZoomToFitCanvasInteraction
]

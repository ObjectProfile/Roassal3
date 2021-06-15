"
I the main interaction that handles roassal3 general control about a view.
I interact with the Abstract class RSAbstractControlView. I creates instances of all subclasses of RSAbstractControlsView 
"
Class {
	#name : #RSCanvasController,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'interactions',
		'withLegend',
		'configuration'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSCanvasController >> addInteraction: anInteractionObject [

	self interactions: (self interactions, (Array with: anInteractionObject class -> anInteractionObject)).
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
	self interactions do: [ :i | i configuration: configuration ].
]

{ #category : #initialization }
RSCanvasController >> defaultInteractions [
	"create a subclass of RSControslView and define your own custom interactions for your canvas"
	^ { RSDraggableCanvasInteraction. RSKeyNavigationCanvasInteraction. RSZoomToFitCanvasInteraction. RSZoomableCanvasInteraction. RSScrollBarsCanvasInteraction . RSSearchInCanvasInteraction }
]

{ #category : #initialization }
RSCanvasController >> initialize [
	super initialize.
	self interactions: (self defaultInteractions collect: #new).
	self
		withLegend;
		configuration: RSControlConfiguration new.
]

{ #category : #accessing }
RSCanvasController >> interactions [
	^ interactions
]

{ #category : #accessing }
RSCanvasController >> interactions: aCollectionOfInteractions [
	interactions := OrderedDictionary new.
	aCollectionOfInteractions do: [ :int |
		interactions at: int class put: int ].
	
]

{ #category : #configuration }
RSCanvasController >> noLegend [
	withLegend := false
]

{ #category : #hooks }
RSCanvasController >> onShape: aCanvas [
	aCanvas controllerInteraction ifNotNil: [ ^ self ].
	aCanvas controllerInteraction: self.
	self interactions do: [ :int | int onShape: aCanvas ].
	self renderLegendOn: aCanvas.
	
]

{ #category : #hooks }
RSCanvasController >> renderLegendOn: aCanvas [
	| lb |
	self shouldShowLegend ifFalse: [ ^ self ].
	lb := RSLegendBuilder new 
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
	lb build.
]

{ #category : #testing }
RSCanvasController >> shouldShowLegend [
	^ withLegend
]

{ #category : #configuration }
RSCanvasController >> withLegend [
	withLegend := true
]

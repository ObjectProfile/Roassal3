"
I the main interaction that handles roassal3 general control about a view.
I interact with the Abstract class RSAbstractControlView. I creates instances of all subclasses of RSAbstractControlsView 
"
Class {
	#name : #TSControlsCanvas,
	#superclass : #TSAbstractCanvasInteraction,
	#instVars : [
		'interactions',
		'withLegend',
		'configuration'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
TSControlsCanvas >> configuration [
	^ configuration
]

{ #category : #accessing }
TSControlsCanvas >> configuration: aRSControlLimits [
	configuration := aRSControlLimits.
	self interactions do: [ :i | i configuration: configuration].
]

{ #category : #initialization }
TSControlsCanvas >> defaultInteractions [
	"create a subclass of RSControslView and define your own custom interactions for your views :V"
	^ { TSDraggableCanvas. TSKeyNavigationCanvas. TSZoomToFitCanvas. TSZoomableCanvas. TSScrollsCanvas }
]

{ #category : #initialization }
TSControlsCanvas >> initialize [
	super initialize.
	self interactions: (self defaultInteractions collect: #new).
	self
		withLegend;
		configuration: TSControlConfiguration new.
]

{ #category : #accessing }
TSControlsCanvas >> interactions [
	^ interactions
]

{ #category : #accessing }
TSControlsCanvas >> interactions: aCollectionOfInteractions [
	interactions := OrderedDictionary new.
	aCollectionOfInteractions do: [ :int |
		interactions at: int class put: int ].
	
]

{ #category : #configuration }
TSControlsCanvas >> noLegend [
	withLegend := false
]

{ #category : #hooks }
TSControlsCanvas >> onShape: aCanvas [
	self interactions do: [ :int | int onShape: aCanvas ].
	self renderLegendOn: aCanvas.
	
]

{ #category : #hooks }
TSControlsCanvas >> renderLegendOn: aCanvas [
	| lb |
	self shouldShowLegend ifFalse: [ ^ self ].
	"lb := TSLegend new 
		container: aCanvas;
		yourself.
	lb defaultTitle fontSize: 12.
	lb defaultLabel fontSize: 10.
	lb defaultBoldText fontSize: 10.
	lb shape
		border: TSBorder new;
		color: (Color white alpha: 0.8);
		padding: 10.
	lb title: 'Shortcuts'.
	self interactions do: [ :int | int renderOn: lb ].
	lb onDemand."
	"lb build."
]

{ #category : #testing }
TSControlsCanvas >> shouldShowLegend [
	^ withLegend
]

{ #category : #configuration }
TSControlsCanvas >> withLegend [
	withLegend := true
]

{ #category : #public }
TSControlsCanvas >> zoomToFit: aView [
	(self interactions at: TSZoomToFitCanvas) zoomToFit: aView
]

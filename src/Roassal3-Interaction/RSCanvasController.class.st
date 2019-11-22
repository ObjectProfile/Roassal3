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
RSCanvasController >> configuration [
	^ configuration
]

{ #category : #accessing }
RSCanvasController >> configuration: aRSControlLimits [
	configuration := aRSControlLimits.
	self interactions do: [ :i | i configuration: configuration].
]

{ #category : #initialization }
RSCanvasController >> defaultInteractions [
	"create a subclass of RSControslView and define your own custom interactions for your views :V"
	^ { RSDraggableCanvas. RSKeyNavigationCanvas. RSZoomToFitCanvas. RSZoomableCanvas. RSScrollsCanvas }
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
	self interactions do: [ :int | int onShape: aCanvas ].
	self renderLegendOn: aCanvas.
	
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
	lb leyendDo: [ :l |
		l 
			border: RSBorder new;
			color: (Color white alpha: 0.8);
			padding: 10.
		].
	lb title: 'Shortcuts'.
	self interactions do: [ :int | int renderOn: lb ].
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

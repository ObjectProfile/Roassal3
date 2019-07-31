"
I the main interaction that handles roassal3 general control about a view.
I interact with the Abstract class RSAbstractControlView. I creates instances of all subclasses of RSAbstractControlsView 
"
Class {
	#name : #RSControlsView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'interactions',
		'withLegend',
		'configuration'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSControlsView >> configuration [
	^ configuration
]

{ #category : #accessing }
RSControlsView >> configuration: aRSControlLimits [
	configuration := aRSControlLimits.
	self interactions do: [ :i | i configuration: configuration].
]

{ #category : #initialization }
RSControlsView >> defaultInteractions [
	"create a subclass of RSControslView and define your own custom interactions for your views :V"
	^ { RSDraggableView. RSKeyNavigationView. RSZoomToFitView. RSZoomableView. RSScrollsView }
]

{ #category : #initialization }
RSControlsView >> initialize [
	super initialize.
	self interactions: (self defaultInteractions collect: #new).
	self
		withLegend;
		configuration: RSControlConfiguration new.
]

{ #category : #accessing }
RSControlsView >> interactions [
	^ interactions
]

{ #category : #accessing }
RSControlsView >> interactions: aCollectionOfInteractions [
	interactions := OrderedDictionary new.
	aCollectionOfInteractions do: [ :int |
		interactions at: int class put: int ].
	
]

{ #category : #configuration }
RSControlsView >> noLegend [
	withLegend := false
]

{ #category : #hooks }
RSControlsView >> onElement: aView [
	self interactions do: [ :int | int onElement: aView ].
	self renderLegendOn: aView.
	
]

{ #category : #hooks }
RSControlsView >> renderLegendOn: aView [
	| lb |
	self shouldShowLegend ifFalse: [ ^ self ].
	lb := RSLegendBuilder new 
		view: aView;
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
	lb onDemand.
	lb build.
]

{ #category : #testing }
RSControlsView >> shouldShowLegend [
	^ withLegend
]

{ #category : #configuration }
RSControlsView >> withLegend [
	withLegend := true
]

{ #category : #public }
RSControlsView >> zoomToFit: aView [
	(self interactions: RSZoomToFitView) zoomToFit: aView
]

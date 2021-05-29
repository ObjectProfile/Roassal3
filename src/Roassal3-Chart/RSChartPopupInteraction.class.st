"
Specific popup, used by RSPopupDecoration
"
Class {
	#name : #RSChartPopupInteraction,
	#superclass : #RSPopupInteraction,
	#instVars : [
		'chart',
		'chartPopupBuilder',
		'markersPopupBuilder'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSChartPopupInteraction >> chart [
	^ chart
]

{ #category : #accessing }
RSChartPopupInteraction >> chart: aRSChart [
	chart := aRSChart
]

{ #category : #accessing }
RSChartPopupInteraction >> chartPopupBuilder [
	^ chartPopupBuilder
]

{ #category : #accessing }
RSChartPopupInteraction >> chartPopupBuilder: aShapeBuilder [
	chartPopupBuilder := aShapeBuilder
]

{ #category : #initialization }
RSChartPopupInteraction >> initialize [
	super initialize.
	"this composite is created once when the mouse enter into the box shape"
	self shapeBuilder: [ :obj | RSComposite new ].
	
]

{ #category : #accessing }
RSChartPopupInteraction >> markersPopupBuilder [
	^ markersPopupBuilder
]

{ #category : #accessing }
RSChartPopupInteraction >> markersPopupBuilder: aRSAbstractChartPopupBuilder [
	markersPopupBuilder := aRSAbstractChartPopupBuilder
]

{ #category : #hooks }
RSChartPopupInteraction >> releasePopup: popup [
	popup remove.
	chart container propertyAt: #popupMarkers ifPresent: [ :old | old remove ].
]

{ #category : #hooks }
RSChartPopupInteraction >> translatePopup: popup event: evt [
	self 
		updatePopup: popup event: evt;
		updateMarkers: evt.
	super translatePopup: popup event: evt
]

{ #category : #hooks }
RSChartPopupInteraction >> updateMarkers: evt [

	| markers key container builder |
	builder := self markersPopupBuilder.
	builder position: evt position.
	markers := builder shapeFor: self chart.
	container := self chart container.
	key := #popupMarkers.
	container propertyAt: key ifPresent: [ :old | old remove ].
	container addShape: markers.
	container propertyAt: key put: markers.
	^ builder
]

{ #category : #hooks }
RSChartPopupInteraction >> updatePopup: popup event: evt [
	"we recreate the popup content each time, since the popup should show the nodes change"
	| builder |
	popup children do: #remove. "we recreate the popup content each time, since the popup should show the nodes change"
	builder := self chartPopupBuilder.
	builder position: evt position.
	popup addShape: (builder shapeFor: self chart).
	popup adjustToChildren.
	
]

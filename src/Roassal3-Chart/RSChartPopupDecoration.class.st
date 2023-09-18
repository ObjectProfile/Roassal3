"
Specific popup, used by RSPopupDecoration
"
Class {
	#name : #RSChartPopupDecoration,
	#superclass : #RSPopup,
	#instVars : [
		'chart',
		'chartPopupBuilder',
		'markersPopupBuilder'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSChartPopupDecoration >> chart [
	^ chart
]

{ #category : #accessing }
RSChartPopupDecoration >> chart: aRSChart [
	chart := aRSChart
]

{ #category : #accessing }
RSChartPopupDecoration >> chartPopupBuilder [
	^ chartPopupBuilder
]

{ #category : #accessing }
RSChartPopupDecoration >> chartPopupBuilder: aShapeBuilder [
	chartPopupBuilder := aShapeBuilder
]

{ #category : #initialization }
RSChartPopupDecoration >> initialize [
	super initialize.
	"this composite is created once when the mouse enter into the box shape"
	self shapeBuilder: [ :obj | RSComposite new ]
]

{ #category : #accessing }
RSChartPopupDecoration >> markersPopupBuilder [
	^ markersPopupBuilder
]

{ #category : #accessing }
RSChartPopupDecoration >> markersPopupBuilder: aRSAbstractChartPopupBuilder [
	markersPopupBuilder := aRSAbstractChartPopupBuilder
]

{ #category : #hooks }
RSChartPopupDecoration >> releasePopup: popup [
	popup remove.
	chart container propertyAt: #popupMarkers ifPresent: [ :old | old remove ]
]

{ #category : #hooks }
RSChartPopupDecoration >> translatePopup: popup event: evt [
	self
		updatePopup: popup event: evt;
		updateMarkers: evt.
	super translatePopup: popup event: evt
]

{ #category : #hooks }
RSChartPopupDecoration >> updateMarkers: evt [
	| markers key container builder |
	builder := self markersPopupBuilder.
	builder position: evt position.
	markers := builder shapeFor: self chart.
	container := self chart container canvas.
	key := #popupMarkers.
	container propertyAt: key ifPresent: [ :old | old remove ].
	container addShape: markers.
	container propertyAt: key put: markers.
	^ builder
]

{ #category : #hooks }
RSChartPopupDecoration >> updatePopup: popup event: evt [
	"we recreate the popup content each time, since the popup should show the nodes change"
	| builder rect |
	popup children do: #remove. "we recreate the popup content each time, since the popup should show the nodes change"
	builder := self chartPopupBuilder.
	rect := evt shape globalEncompassingRectangle.
	builder position: evt position - rect origin.

	popup addShape: (builder shapeFor: self chart).
	popup adjustToChildren
]

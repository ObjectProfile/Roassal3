"
Specific popup, used by RSPopupDecoration
"
Class {
	#name : #RSPopupChart,
	#superclass : #RSPopup,
	#instVars : [
		'chart',
		'chartPopupBuilder',
		'markersPopupBuilder'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSPopupChart >> chart [
	^ chart
]

{ #category : #accessing }
RSPopupChart >> chart: aRSChart [
	chart := aRSChart
]

{ #category : #accessing }
RSPopupChart >> chartPopupBuilder [
	^ chartPopupBuilder
]

{ #category : #accessing }
RSPopupChart >> chartPopupBuilder: aShapeBuilder [
	chartPopupBuilder := aShapeBuilder
]

{ #category : #initialization }
RSPopupChart >> initialize [
	super initialize.
	"this composite is created once when the mouse enter into the box shape"
	self shapeBuilder: [ :obj | RSComposite new ].
	
]

{ #category : #accessing }
RSPopupChart >> markersPopupBuilder [
	^ markersPopupBuilder
]

{ #category : #accessing }
RSPopupChart >> markersPopupBuilder: aRSAbstractChartPopupBuilder [
	markersPopupBuilder := aRSAbstractChartPopupBuilder
]

{ #category : #hooks }
RSPopupChart >> releasePopup: popup [
	popup remove.
	chart container propertyAt: #popupMarkers ifPresent: [ :old | old remove ].
]

{ #category : #hooks }
RSPopupChart >> translatePopup: popup event: evt [
	self 
		updatePopup: popup event: evt;
		updateMarkers: evt.
	super translatePopup: popup event: evt
]

{ #category : #hooks }
RSPopupChart >> updateMarkers: evt [

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
RSPopupChart >> updatePopup: popup event: evt [
	"we recreate the popup content each time, since the popup should show the nodes change"
	| builder |
	popup children do: #remove. "we recreate the popup content each time, since the popup should show the nodes change"
	builder := self chartPopupBuilder.
	builder position: evt position.
	popup addShape: (builder shapeFor: self chart).
	popup adjustToChildren.
	
]

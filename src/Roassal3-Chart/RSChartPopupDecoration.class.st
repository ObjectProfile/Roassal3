"
I am a popup decoration for instances of line Plots in RSChart by default but you can customize this popup decoration with differents shapebuilders, or popups
"
Class {
	#name : #RSChartPopupDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'popup'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSChartPopupDecoration >> chartPopupBuilder [
	^ self popup chartPopupBuilder
]

{ #category : #accessing }
RSChartPopupDecoration >> chartPopupBuilder: aRSAbstractChartPopupBuilder [
	self popup chartPopupBuilder: aRSAbstractChartPopupBuilder
]

{ #category : #initialization }
RSChartPopupDecoration >> initialize [
	super initialize.
	popup := RSPopupChart new
		chartPopupBuilder: RSSimpleChartPopupBuilder new;
		markersPopupBuilder: RSSimpleMarkerPopup new;
		yourself.
]

{ #category : #accessing }
RSChartPopupDecoration >> popup [
	^ popup
]

{ #category : #accessing }
RSChartPopupDecoration >> popup: aRSPopup [
	popup := aRSPopup
]

{ #category : #rendering }
RSChartPopupDecoration >> renderIn: canvas [
	| box |
	box := chart decorations first shape.
	popup chart: chart.
	box addInteraction: popup.
]

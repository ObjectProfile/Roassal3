"
This class is to create maps directly with the correct interactions
"
Class {
	#name : #RSOSMBuilder,
	#superclass : #RSBuilder,
	#instVars : [
		'osm'
	],
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #'accessing - defaults' }
RSOSMBuilder >> defaultContainer [
	| canvas |
	
	canvas := RSCanvas new.
	canvas 
		@ RSDraggableCanvasInteraction new noLimits;
		@ RSZoomableCanvasInteraction new noLimits.
	canvas camera scale: 0.05.
	^ canvas.
]

{ #category : #public }
RSOSMBuilder >> downloadCityCoordinatesFor: aCityName [
	<script: '(self new downloadCityCoordinatesFor: ''Tarija'') inspect ' >
	"This is just and example and it contains a limit of 50000 calls. Probably you will need pro account"
	^ ((ZnClient new
		url: 'https://api.api-ninjas.com/v1/geocoding';
		queryAt: 'city' put: aCityName trimBoth;
		headerAt: 'X-Api-Key' put: 'AtPcEacVJYoUiSG4DoH/FQ==qjcfdi3znB8pg4eS';
		contentReader: [ :entity | STONJSON fromString: entity contents ];
		get) first)
		in: [ :city | (city at: 'latitude') asNumber @ (city at: 'longitude') asNumber ]
]

{ #category : #public }
RSOSMBuilder >> latLogToRoassalCoordinates: aPoint [
	^ (self lonToRoassal: aPoint y) @ (self latToRoassal: aPoint x).
]

{ #category : #public }
RSOSMBuilder >> latLong: aPoint [
	| canvas location camera |
	"location in latitud and longitud"
	location := self latLogToRoassalCoordinates: aPoint.
	canvas := self container.
	camera := canvas camera.
	canvas morph ifNil:[canvas createMorph drawOnMockCanvas ].
	camera 
		scale: 1.5;"<-- Magic number"
		translateTo: 0@0.
	camera translateTo: ((camera fromSpaceToPixel: location) - (camera originMode gapDistance: camera)) negated.

	canvas signalUpdate
	

]

{ #category : #public }
RSOSMBuilder >> latToRoassal: lat [
	| l cls |
	cls := osm class.
	l := ((lat min: cls maxLatitude) max: cls minLatitude) degreesToRadians.
	^ (Float pi / 4 + (l / 2)) tan ln * cls earthR negated
]

{ #category : #public }
RSOSMBuilder >> lonToRoassal: lon [
	^ osm equatorLength * (lon asFloat / 360)
]

{ #category : #public }
RSOSMBuilder >> moveToCity: aCityName [
	self latLong: (self downloadCityCoordinatesFor: aCityName)
	
]

{ #category : #rendering }
RSOSMBuilder >> renderIn: aCanvas [
	osm := RSOSMShape new.
	shapes := { osm }.
	aCanvas add: osm
]

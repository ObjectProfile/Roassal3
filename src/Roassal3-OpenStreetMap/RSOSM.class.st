"
I am the basic shape that renders the map
"
Class {
	#name : #RSOSM,
	#superclass : #RSShape,
	#instVars : [
		'tiles',
		'emptyTile',
		'semaphore',
		'osmZoomLevel',
		'ratio'
	],
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #public }
RSOSM class >> earthR [
	"Earth R in km."

	^ 6378.1370
]

{ #category : #public }
RSOSM class >> equatorLength [
	"Equator length  in km. self earthR * 2* Float pi"

	^ 40075.016685578485
]

{ #category : #adding }
RSOSM >> accept: aVisitor [
	aVisitor visitOSM: self
]

{ #category : #accessing }
RSOSM >> computeEncompassingRectangle [
	| canvas |
	canvas := self canvas.
	canvas ifNil: [ ^ 0@0 corner: 0@0 ].
	^ canvas visibleRectangle
]

{ #category : #private }
RSOSM >> computeOsmZoomLevel [
	"The osm zoom level."

	^ (((self pixelLength * self canvas camera scale) ln / 2 ln) rounded max: 0) min: 18
]

{ #category : #defaults }
RSOSM >> defaultEmptyTile [
	^ ((StringMorph contents: 'Loading...') center: 127 @ 127)
				imageFormForRectangle: (0 @ 0 extent: 256 @ 256)
]

{ #category : #accessing }
RSOSM >> emptyTile [
	^ emptyTile
]

{ #category : #accessing }
RSOSM >> emptyTile: aMorph [
	emptyTile := aMorph
]

{ #category : #'accessing - computed' }
RSOSM >> end [
	^ self fromOurSpaceToTile: self encompassingRectangle bottomRight
]

{ #category : #accessing }
RSOSM >> equatorLength [
	"Equator length  in km. self earthR * 2* Float pi"
	^ self class equatorLength * self ratio
]

{ #category : #'accessing - computed' }
RSOSM >> fromCameraSpaceToOurSpace: aPoint [
	"To convert our boundaries from the camera space into our space (0@0 at center, no zoom)."

	^ self canvas camera fromSpaceToPixel: aPoint
]

{ #category : #'accessing - computed' }
RSOSM >> fromOSMSpaceToOurSpace: aPoint [
	"Convert a point in OSM space (zoom level) into our space."

	^ self fromCameraSpaceToOurSpace: aPoint * self equatorLength / (2 raisedTo: osmZoomLevel) / 256 - (self equatorLength / 2)
]

{ #category : #'accessing - computed' }
RSOSM >> fromOurSpaceToCameraSpace: aPoint [
	"To convert our boundaries into the camera space."

	^ self canvas camera fromPixelToSpace: aPoint
]

{ #category : #'accessing - computed' }
RSOSM >> fromOurSpaceToTile: aPoint [
	"Convert our boundaries into the osm space (as set by the zoom level)."

	^ ((self fromOurSpaceToCameraSpace: aPoint) + (self equatorLength / 2))
		// (self equatorLength / (2 raisedTo: osmZoomLevel))
]

{ #category : #accessing }
RSOSM >> futures [

	^ futures
]

{ #category : #accessing }
RSOSM >> futures: anObject [

	futures := anObject
]

{ #category : #initialization }
RSOSM >> initialize [
	super initialize.
	tiles := Dictionary new.
	futures := Dictionary new.
	emptyTile := self defaultEmptyTile.
	semaphore := Semaphore forMutualExclusion
]

{ #category : #private }
RSOSM >> inspectorShadowFor: padding color: aColor [
	"a map does not contains a shadow"
	^ self shouldNotImplement
]

{ #category : #testing }
RSOSM >> intersects: aRectangle [
	"probably this will change with the RTree"
	^ self shouldNotImplement
]

{ #category : #accessing }
RSOSM >> osmZoomLevel [
	^ osmZoomLevel
]

{ #category : #accessing }
RSOSM >> pixelLength [
	"Pixel length at equator at highest zoom factor. "

	^ self class equatorLength * self ratio / 256
]

{ #category : #accessing }
RSOSM >> ratio [
	^ ratio ifNil: [ ratio := 1.0 ]
]

{ #category : #'accessing - computed' }
RSOSM >> remainderZoom: z [
	"Remainder zoom to apply on the display."

	^ self pixelLength * self canvas camera scale * (256 / 255) asFloat / (2 raisedTo: z)
]

{ #category : #adding }
RSOSM >> renderOn: aCanvas [
]

{ #category : #accessing }
RSOSM >> semaphore [
	^ semaphore
]

{ #category : #'accessing - computed' }
RSOSM >> start [
	^ self fromOurSpaceToTile: self encompassingRectangle topLeft
]

{ #category : #accessing }
RSOSM >> tiles [
	^ tiles
]

{ #category : #accessing }
RSOSM >> tiles: aDictionary [
	tiles := aDictionary
]

{ #category : #private }
RSOSM >> updateOsmZoomLevel [
	"Get the osm zoom level. Do something if we need to change the zoom level, like flushing the tile cache."

	osmZoomLevel := self computeOsmZoomLevel
]

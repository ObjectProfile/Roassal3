"
I am the basic shape that renders the map, based on code of Roassal2 using the API provided by

https://a.tile.openstreetmap.org
"
Class {
	#name : 'RSOSMShape',
	#superclass : 'RSShape',
	#instVars : [
		'tiles',
		'emptyTile',
		'semaphore',
		'osmZoomLevel',
		'ratio',
		'futures',
		'cacheSize'
	],
	#category : 'Roassal3-OpenStreetMap',
	#package : 'Roassal3-OpenStreetMap'
}

{ #category : 'public' }
RSOSMShape class >> earthR [
	"Earth R in km."

	^ 6378.1370
]

{ #category : 'public' }
RSOSMShape class >> equatorLength [
	"Equator length  in km. self earthR * 2* Float pi"

	^ 40075.016685578485
]

{ #category : 'public' }
RSOSMShape class >> maxLatitude [
	^85.05112877980659
]

{ #category : 'public' }
RSOSMShape class >> minLatitude [
	^-85.05112877980659
]

{ #category : 'adding' }
RSOSMShape >> accept: aVisitor [
	aVisitor visitOSM: self
]

{ #category : 'accessing' }
RSOSMShape >> cacheSize [
	^ cacheSize
]

{ #category : 'accessing' }
RSOSMShape >> cacheSize: aNumber [
	"a cache size for number of tiles"
	cacheSize := aNumber
]

{ #category : 'accessing' }
RSOSMShape >> computeEncompassingRectangle [
	| canvas |
	canvas := self canvas.
	canvas ifNil: [ ^ 0@0 corner: 0@0 ].
	^ canvas visibleRectangle
]

{ #category : 'private' }
RSOSMShape >> computeOsmZoomLevel [
	"The osm zoom level."

	^ (((self pixelLength * self canvas camera scale) ln / 2 ln) rounded max: 0) min: 18
]

{ #category : 'defaults' }
RSOSMShape >> defaultCacheSize [
	^ 100
]

{ #category : 'defaults' }
RSOSMShape >> defaultEmptyTile [
	^ ((StringMorph contents: 'Loading...') center: 127 @ 127)
				imageFormForRectangle: (0 @ 0 extent: 256 @ 256)
]

{ #category : 'accessing' }
RSOSMShape >> emptyTile [
	^ emptyTile
]

{ #category : 'accessing' }
RSOSMShape >> emptyTile: aMorph [
	emptyTile := aMorph
]

{ #category : 'accessing - computed' }
RSOSMShape >> end [
	^ (self fromOurSpaceToTile: self transformedRectangle bottomRight)
]

{ #category : 'accessing' }
RSOSMShape >> equatorLength [
	"Equator length  in km. self earthR * 2* Float pi"
	^ self class equatorLength * self ratio
]

{ #category : 'accessing - computed' }
RSOSMShape >> fromCameraSpaceToOurSpace: aPoint [
	"To convert our boundaries from the camera space into our space (0@0 at center, no zoom)."

	^ self canvas camera fromSpaceToPixel: aPoint
]

{ #category : 'accessing - computed' }
RSOSMShape >> fromOSMSpaceToOurSpace: aPoint [
	"Convert a point in OSM space (zoom level) into our space."

	^ self fromCameraSpaceToOurSpace: aPoint * self equatorLength / (2 raisedTo: osmZoomLevel) / 256 - (self equatorLength / 2)
]

{ #category : 'accessing - computed' }
RSOSMShape >> fromOurSpaceToCameraSpace: aPoint [
	"To convert our boundaries into the camera space."
	| camera |
	camera := self canvas camera.
	^ (camera matrix inverseTransform: aPoint+ (camera originMode gapToCenter: camera) )
]

{ #category : 'accessing - computed' }
RSOSMShape >> fromOurSpaceToTile: aPoint [
	"Convert our boundaries into the osm space (as set by the zoom level)."

	^ ((self fromOurSpaceToCameraSpace: aPoint) + (self equatorLength / 2))
		// (self equatorLength / (2 raisedTo: osmZoomLevel))
]

{ #category : 'accessing' }
RSOSMShape >> futures [
	^ futures
]

{ #category : 'accessing' }
RSOSMShape >> futures: anObject [

	futures := anObject
]

{ #category : 'initialization' }
RSOSMShape >> initialize [
	super initialize.
	tiles := Dictionary new.
	futures := Dictionary new.
	emptyTile := self defaultEmptyTile.
	semaphore := Semaphore forMutualExclusion.
	self cacheSize: self defaultCacheSize.
	
]

{ #category : 'private' }
RSOSMShape >> inspectorShadowFor: padding color: aColor [
	"a map does not contains a shadow"
	^ self shouldNotImplement
]

{ #category : 'testing' }
RSOSMShape >> intersects: aRectangle [
	"probably this will change with the RTree"
	^ self shouldNotImplement
]

{ #category : 'accessing' }
RSOSMShape >> osmZoomLevel [
	^ osmZoomLevel
]

{ #category : 'accessing' }
RSOSMShape >> pixelLength [
	"Pixel length at equator at highest zoom factor. "

	^ self class equatorLength * self ratio / 256
]

{ #category : 'accessing' }
RSOSMShape >> ratio [
	^ ratio ifNil: [ ratio := 1.0 ]
]

{ #category : 'accessing - computed' }
RSOSMShape >> remainderZoom: z [
	"Remainder zoom to apply on the display."

	^ self pixelLength * self canvas camera scale * (256 / 255) asFloat / (2 raisedTo: z)
]

{ #category : 'adding' }
RSOSMShape >> renderOn: aCanvas [
]

{ #category : 'accessing' }
RSOSMShape >> semaphore [
	^ semaphore
]

{ #category : 'accessing - computed' }
RSOSMShape >> start [
	^ self fromOurSpaceToTile: self transformedRectangle topLeft
]

{ #category : 'accessing' }
RSOSMShape >> tiles [
	^ tiles
]

{ #category : 'accessing' }
RSOSMShape >> tiles: aDictionary [
	tiles := aDictionary
]

{ #category : 'accessing - computed' }
RSOSMShape >> transformedRectangle [
	| aPoint |
	aPoint := parent extent.
	^ aPoint / -2.0 extent: aPoint
]

{ #category : 'private' }
RSOSMShape >> updateOsmZoomLevel [
	"Get the osm zoom level. Do something if we need to change the zoom level, like flushing the tile cache."

	osmZoomLevel := self computeOsmZoomLevel
]

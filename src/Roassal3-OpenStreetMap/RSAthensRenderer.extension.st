Extension { #name : #RSAthensRenderer }

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> downloadTile: osm key: key [
	[
	|aTile |
	Processor yield.
	aTile := [
			ZnEasy getPng: ('https://a.tile.openstreetmap.org' asZnUrl
				addPathSegment: key third printString;
				addPathSegment: key first printString;
				addPathSegment: key second printString , '.png')
		] on: Error do: [ :ex | ].
	osm semaphore critical: [ osm tiles at: key put: aTile ].
	osm signalUpdate.
	] fork
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> drawTile: aPoint with: tiles shape: osm [
	"Draw a single tile at the right position."
	| key |
	key := {aPoint x. aPoint y. osm osmZoomLevel}.
	(osm tiles
		at: key
		ifAbsent: [ self getTileAt: aPoint with: osm key: key ])
		ifNotNil: [ :aTile |
			athensCanvas pathTransform restoreAfter: [
				| paint |
				athensCanvas pathTransform
					translateBy: (osm fromOSMSpaceToOurSpace: aPoint * 256);
					scaleBy: (osm remainderZoom: osm osmZoomLevel ).
				athensCanvas setShape: aTile boundingBox.
				paint := athensCanvas
					cacheAt: aTile
					ifAbsentPut: [ aTile asAthensPaintOn: athensCanvas ].
				athensCanvas setPaint: paint.
				athensCanvas draw.
				tiles at: key put: aTile
				 ] ]
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> getTileAt: aPoint with: osm key: key [
	"A point has to be xTile @ yTile, integers between 0 and 2^osmZoomLevel - 1"
	| level |
	level := 2 raisedTo: osm osmZoomLevel.
	(aPoint x < 0
		or: [ (aPoint x >= level)
		or: [ aPoint y < 0
		or: [ aPoint y >= level ] ] ]) ifTrue: [ ^ nil ].
	osm tiles
		at: key
		put: osm class emptyTile.
	self downloadTile: osm key: key.
	^ osm class emptyTile
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> visitOSM: osm [
	| newTiles |
	newTiles := Dictionary new.
	osm updateOsmZoomLevel.
	osm semaphore critical: [
		athensCanvas pathTransform restoreAfter: [
			| canvas |
			canvas := osm canvas.
			athensCanvas pathTransform
				translateBy: canvas camera position;
				scaleBy: 1 / canvas camera scale.
			athensCanvas
				clipBy: osm encompassingRectangle
				during: [
					| start end |
					start := osm start.
					end := osm end.
					start x to: end x do: [ :xi |
						start y to: end y do: [ :yi |
							self drawTile: xi@yi with: newTiles shape: osm ] ]
					 ].
			osm tiles: newTiles.
		].
	]
]

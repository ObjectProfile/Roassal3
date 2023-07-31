Extension { #name : #RSAthensRenderer }

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> createFuture: osm key: key [
	^ [ self downloadTile: osm key: key ] future
		onSuccessDo: [ :tile | 
			osm semaphore critical: [ osm tiles at: key put: tile ].
			osm signalUpdate ];
		yourself
	
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> downloadTile: osm key: key [
	^ ZnEasy getPng: ('https://a.tile.openstreetmap.org' asZnUrl
		addPathSegment: key third printString;
		addPathSegment: key first printString;
		addPathSegment: key second printString , '.png')
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> drawTile: tupleOfThree with: tiles shape: osm [
	"Draw a single tile at the right position."
	| aPoint |
	aPoint := tupleOfThree first @ tupleOfThree second.
	(osm tiles
		at: tupleOfThree
		ifAbsent: [ self getTileAt: aPoint with: osm key: tupleOfThree ])
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
				tiles at: tupleOfThree put: aTile
			] 
		]
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> getTileAt: aPoint with: osm key: key [
	"A point has to be xTile @ yTile, integers between 0 and 2^osmZoomLevel - 1"
	| level future |
	level := 2 raisedTo: osm osmZoomLevel.
	(aPoint x < 0
		or: [ (aPoint x >= level)
		or: [ aPoint y < 0
		or: [ aPoint y >= level ] ] ]) ifTrue: [ ^ nil ].
	osm tiles
		at: key
		put: osm emptyTile.
	future := self createFuture: osm key: key.
	osm futures at: key put: future.
	^ osm emptyTile
]

{ #category : #'*Roassal3-OpenStreetMap' }
RSAthensRenderer >> visitOSM: osm [
	| newTiles |
	newTiles := Dictionary new.
	osm updateOsmZoomLevel.
	athensCanvas pathTransform restoreAfter: [
		athensCanvas
			clipBy: osm encompassingRectangle
			during: [
				| start end allKeys zoomLevel|
				start := osm start.
				end := osm end.
				"start traceCr.
				end traceCr."
				
				zoomLevel := osm osmZoomLevel.
				
				allKeys := (start x to: end x) flatCollect: [ :xi | 
					(start y to: end y) collect: [ :yi | {xi. yi. zoomLevel} ] ].
				
				osm semaphore critical: [ | futures keysOutOfBox |
					futures := osm futures.
					futures keys copy do: [ :key | | aFuture |
						aFuture := futures at: key.
						aFuture isFinished ifTrue: [ futures removeKey: key ].
						 ].
					keysOutOfBox := futures keys difference: allKeys.
					keysOutOfBox do: [ :key | 
						(futures at: key) cancelIfNotStarted.
						futures removeKey: key. ].
					"futures size traceCr.
					'' traceCr."
					"TODO optimaze when the canvas is really big.
					Should we keep a cache of visited sites? what size"
					allKeys do: [ :key | self drawTile: key with: newTiles shape: osm ].
					osm tiles: newTiles.
				].
			]
	]
]

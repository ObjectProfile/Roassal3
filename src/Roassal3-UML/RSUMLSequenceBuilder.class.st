"
I am a builder to create UML sequence diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLSequenceBuilder,
	#superclass : #RSUMLAbstractBuilder,
	#instVars : [
		'messagesSends',
		'previousMessagesSends',
		'previousHeaders',
		'greatestCommonIndex',
		'receiverArgumentsShape',
		'headerShape',
		'objectsSeenSoFar'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #building }
RSUMLSequenceBuilder >> build [

	self modelDescriptor
		umlBuilder: self;
		messagesSends: messagesSends;
		objectsSeenSoFar: objectsSeenSoFar;
		refresh.

	^ super build
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> endShapeWithX: x andY: y [

	^ RSBox new
		  noPaint;
		  color: Color transparent;
		  extent: 0 @ 0;
		  position: x @ y;
		  yourself
]

{ #category : #accessing }
RSUMLSequenceBuilder >> headerShape: aBlock [

	headerShape := aBlock
]

{ #category : #shapes }
RSUMLSequenceBuilder >> headerShapeOf: anObject [

	^ headerShape value: anObject
]

{ #category : #initialization }
RSUMLSequenceBuilder >> initialize [

	super initialize.

	self
		modelDescriptor: RSUMLSequenceDescriptor new;
		renderer: RSBasicUMLSequenceRenderer new;
		previousHeaders: OrderedCollection new;
		previousMessagesSends: OrderedCollection new;
		headerShape: [ :anObject | 
			| split camelShapes |
			split := anObject class name splitOn: ' class'.

			camelShapes := split first splitCamelCase collect: [ :each | 
					               (self labelShapeOfString: each)
						               bold;
						               yourself ].

			split size = 2 ifTrue: [ 
				camelShapes add: ((self labelShapeOfString: '(class)')
						 italic;
						 yourself) ].

			RSVerticalLineLayout new
				alignCenter;
				verticalGap: 0;
				on: camelShapes.

			RSComposite new
				shapes: camelShapes;
				when: RSMouseLeftClick do: [ anObject class browse ];
				padded: Float goldenPlatinumRatio withBoxDo: [ :box | 
					box borderDo: [ :border | box color: border color translucent ] ] ];
		receiverArgumentsShape: [ :anObject | 
			RSLabel new
				model: anObject;
				text: (anObject isBlock
						 ifTrue: [ '[ ... ]' ]
						 ifFalse: [ anObject asString ]);
				useDefaultCodeFont;
				when: RSMouseLeftClick do: [ :ev | anObject inspect ];
				padded: Float goldenPlatinumRatio withBoxDo: [ :box | 
					box
						withBorder;
						color: box borderColor lighter lighter lighter translucent ] ]
]

{ #category : #shapes }
RSUMLSequenceBuilder >> labelShapeOfString: aString [

	^ RSLabel new
		  useDefaultCodeFont;
		  text: aString;
		  yourself
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> lifeLines: selfLines [

	| lb yStart yEnd descriptor commonIndex transparentHeaders minTopHeader lifelines selfMessageSends |
	descriptor := self modelDescriptor.
	selfMessageSends := descriptor selfMessageSends.

	lb := RSLineBuilder line
		      dashArray: { 
				      Float silverRatio.
				      Float goldenPlatinumRatio };
		      withBorderAttachPoint;
		      yourself.

	yStart := descriptor yStart.
	yEnd := descriptor yEnd.

	commonIndex := previousHeaders greatestCommonIndex:
		               descriptor columns.

	transparentHeaders := OrderedCollection new.
	minTopHeader := nil.

	lifelines := descriptor columnsWithIndexCollect: [ :each :index | 
		             | endShape x headerShape isShared yHeader |
		             x := descriptor xOfColumn: index.

		             headerShape := descriptor headerOf: each.

		             isShared := index <= commonIndex.

		             isShared ifTrue: [ 
			             headerShape := RSBox new
				                            extent: headerShape extent x @ 0;
				                            color: Color transparent;
				                            yourself.

			             transparentHeaders add: index ].

		             yHeader := yStart - (headerShape height / 2)
		                        - descriptor yStart.

		             headerShape position: x @ yHeader.

		             minTopHeader := self
			                             shapeOrNil: minTopHeader
			                             shape: headerShape
			                             min: [ :aShape | 
			                             aShape encompassingRectangle top ].

		             endShape := self
			                         endShapeWithX: x
			                         andY:
			                         (descriptor
				                          yEndOfHeader: each
				                          ifAbsent: [ yEnd ]).

		             self
			             lifeLines: selfLines
			             selfMessageSends:
			             (selfMessageSends at: each ifAbsent: [ {  } ])
			             lineBuilder: lb
			             descriptor: descriptor
			             startShape: headerShape
			             endShape: endShape.

		             { 
			             headerShape.
			             endShape } ].

	transparentHeaders do: [ :each | 
		| y anArray |
		anArray := lifelines at: each.
		y := minTopHeader position y - minTopHeader height.
		anArray first position: anArray first position x @ y ].

	^ lifelines
		  collect: [ :anArray | 
			  RSComposite new
				  shapes: anArray;
				  yourself ]
		  as: RSGroup
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> lifeLines: selfLines selfMessageSends: selfSends lineBuilder: lb descriptor: descriptor startShape: startShape endShape: endShape [

	selfSends
		ifEmpty: [ selfLines add: (lb edgeFrom: startShape to: endShape) ]
		ifNotEmpty: [ :associations | "The first segment."
			selfLines add: (lb
					 edgeFrom: startShape
					 to: (descriptor startCircleOf: associations first)).

			associations overlappingPairsDo: [ :anAssoc :anotherAssoc | 
				selfLines add: (lb
						 edgeFrom: (descriptor endCircleOf: anAssoc)
						 to: (descriptor startCircleOf: anotherAssoc)) ].

			"The last segment."
			selfLines add:
				(lb
					 edgeFrom: (descriptor endCircleOf: associations last)
					 to: endShape) ]
]

{ #category : #accessing }
RSUMLSequenceBuilder >> messagesSends: aCollection [

	messagesSends := aCollection
]

{ #category : #accessing }
RSUMLSequenceBuilder >> objects [

	^ messagesSends
]

{ #category : #accessing }
RSUMLSequenceBuilder >> objectsSeenSoFar: aDictionary [

	objectsSeenSoFar := aDictionary
]

{ #category : #accessing }
RSUMLSequenceBuilder >> previousHeaders: anObject [

	previousHeaders := anObject
]

{ #category : #accessing }
RSUMLSequenceBuilder >> previousMessagesSends: anObject [

	previousMessagesSends := anObject
]

{ #category : #accessing }
RSUMLSequenceBuilder >> receiverArgumentsShape: anObject [

	receiverArgumentsShape := anObject
]

{ #category : #accessing }
RSUMLSequenceBuilder >> receiverArgumentsShapeOf: anObject [

	^ receiverArgumentsShape value: anObject
]

{ #category : #hooks }
RSUMLSequenceBuilder >> shapeFor: anObject index: anIndex [

	^ anIndex <= greatestCommonIndex
		  ifTrue: [ 
			  RSComposite new
				  shapes: {  };
				  extent: 0 @ 0;
				  yourself ]
		  ifFalse: [ super shapeFor: anObject index: anIndex ]
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> shapeOrNil: minTopHeader shape: headerShape min: aBlock [

	^ minTopHeader ifNil: [ headerShape ] ifNotNil: [ 
		  | headerTop minTop |
		  headerTop := aBlock value: headerShape.
		  minTop := aBlock value: minTopHeader.

		  headerTop < minTop
			  ifTrue: [ headerShape ]
			  ifFalse: [ minTopHeader ] ]
]

{ #category : #hooks }
RSUMLSequenceBuilder >> shapesFor: aCollection [

	greatestCommonIndex := previousMessagesSends greatestCommonIndex:
		                       messagesSends.

	^ greatestCommonIndex = messagesSends size
		  ifTrue: [ RSGroup new ]
		  ifFalse: [ 
			  | selfLines |
			  selfLines := OrderedCollection new.
			  (self lifeLines: selfLines)
				  addAll: (super shapesFor: aCollection);
				  addAll: selfLines;
				  yourself ]
]

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
		'objectsSeenSoFar',
		'levels',
		'edges'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #building }
RSUMLSequenceBuilder >> build [

	self modelDescriptor
		messagesSends: messagesSends;
		receiverArgumentsShape: receiverArgumentsShape;
		objectsSeenSoFar: objectsSeenSoFar;
		refresh.

	^ super build
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> greatest: aCollection commonIndex: anotherCollection [

	  | index stop |
	  stop := false.
	  index := 1.

	  [ 
	  stop or: [ 
		  index > aCollection size or: [ index > anotherCollection size ] ] ] 
		  whileFalse: [ 
			  (aCollection at: index) 
			  == (anotherCollection at: index) 
				  ifTrue: [ index := index + 1 ]
				  ifFalse: [ stop := true ] ].

	  ^ index - 1
]

{ #category : #initialization }
RSUMLSequenceBuilder >> initialize [

	super initialize.

	edges := IdentityDictionary new.

	self
		modelDescriptor: RSUMLSequenceDescriptor new;
		renderer: RSBasicUMLSequenceRenderer new;
		receiverArgumentsShape: [ :anObject | 
			| label |
			label := RSLabel new
				         model: anObject;
				         text: (anObject isBlock
						          ifTrue: [ '[ ... ]' ]
						          ifFalse: [ anObject ]);
				         yourself.

			RSComposite new
				shapes:
					{ ((label boxedWithPad: Float goldenPlatinumRatio) yourself: [ 
							 :aBoxed | 
							 aBoxed shapes first color:
									 aBoxed shapes first borderColor lighter lighter lighter ]) };
				when: RSMouseLeftClick do: [ :ev | anObject inspect ];
				yourself ]
]

{ #category : #accessing }
RSUMLSequenceBuilder >> levels: anObject [

	levels := anObject
]

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> lifeLines: selfLines [

	| lb yStart yEnd descriptor commonIndex transparentHeaders minTopHeader lifelines selfMessageSends |
	descriptor := self modelDescriptor.
	selfMessageSends := descriptor selfMessageSends.

	lb := RSLineBuilder line
		      dashArray: { 1. Float goldenPlatinumRatio  };
		      withBorderAttachPoint;
		      yourself.

	yStart := descriptor yStart.
	yEnd := descriptor yEnd.

	commonIndex := self
		               greatest: previousHeaders
		               commonIndex: descriptor columns.

	transparentHeaders := OrderedCollection new.
	minTopHeader := nil.

	lifelines := descriptor columnsWithIndexCollect: [ :each :index | 
		             | end x headerShape isShared |
		             x := descriptor xOfColumn: index.

		             headerShape := descriptor headerOf: each.

		             isShared := index <= commonIndex.

		             isShared ifTrue: [ 
			             headerShape := RSBox new
				                            extent: headerShape extent x @ 0;
				                            color: Color transparent;
				                            yourself.

			             transparentHeaders add: index ].

		             headerShape position:
			             x
			             @
			             (yStart - (headerShape height / 2)
			              - (descriptor radius * 4)).

		             minTopHeader := minTopHeader
			                             ifNil: [ headerShape ]
			                             ifNotNil: [ 
				                             | headerTop minTop |
				                             headerTop := headerShape
					                                          encompassingRectangle
					                                          top.

				                             minTop := minTopHeader
					                                       encompassingRectangle top.

				                             headerTop < minTop
					                             ifTrue: [ headerShape ]
					                             ifFalse: [ minTopHeader ] ].

		             end := RSBox new
			                    noPaint;
			                    extent: 0 @ 0;
			                    yourself: [ :b | 
				                    | y |
				                    self assert: b height isZero.
				                    y := descriptor
					                         yEndOfHeader: each
					                         ifAbsent: [ yEnd ].
				                    b position: x @ y ].

		             (selfMessageSends at: each ifAbsent: [ {  } ]) 
			             ifNotEmpty: [ :associations | 
				             associations withIndexDo: [ :anAssoc :i | "

					             associations overlappingPairsDo: [ 
						             :anAssoc 
						             :anotherAssoc | 
						             aStream nextPut: ((lb
								               edgeFrom:
									               ((edges at: anAssoc) propertyAt:
											                #UMLSequenceDiagramCircles) value
								               to:
									               ((edges at: anotherAssoc) propertyAt:
											                #UMLSequenceDiagramCircles) key)
								              dotted;
								              yourself) ].
"" aStream nextPut: ((lb
							               edgeFrom:
								               ((edges at: associations last) propertyAt:
										                #UMLSequenceDiagramCircles) value
							               to: end)
							              dotted;
							              yourself)"
					             anAssoc value
						             ifMessageSend: [ 
							             | returnSend |
							             returnSend := associations at:
								                           associations size - i + 1.

							             self assert: returnSend value key == anAssoc value.

							             selfLines add: (lb
									              edgeFrom: (descriptor endCircleOf: anAssoc)
									              to: (descriptor startCircleOf: returnSend)) ]
						             ifReturnMessageSend: [  ] ] ].

		             Array streamContents: [ :aStream | 
			             aStream
				             nextPut: headerShape;
				             nextPut: end.

			             aStream nextPut: (lb edgeFrom: headerShape to: end) ] ].

	transparentHeaders do: [ :each | 
		| y anArray |
		anArray := lifelines at: each.
		y := minTopHeader position y - minTopHeader height.
		anArray first position: anArray first position x @ y ].

	^ RSGroup new
		  addAll: (lifelines collect: [ :anArray | 
					   RSComposite new
						   shapes: anArray;
						   yourself ]);
		  "addAll: selfLines;"
		  yourself
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

{ #category : #hooks }
RSUMLSequenceBuilder >> shapeFor: anObject index: anIndex [

	^ anIndex <= greatestCommonIndex
		  ifTrue: [ 
			  RSComposite new
				  shapes: {  };
				  extent: 0 @ 0;
				  yourself ]
		  ifFalse: [ 
			  | aShape |
			  aShape := super shapeFor: anObject index: anIndex.

			  edges at: anObject put: aShape.

			  aShape ]
]

{ #category : #hooks }
RSUMLSequenceBuilder >> shapesFor: aCollection [

	greatestCommonIndex := self
		                       greatest: previousMessagesSends
		                       commonIndex: messagesSends.

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

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
		'objectsSeenSoFar'
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

	self
		modelDescriptor: RSUMLSequenceDescriptor new;
		renderer: RSBasicUMLSequenceRenderer new;
		receiverArgumentsShape: [ :anObject | 
			| label box |
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

{ #category : #'as yet unclassified' }
RSUMLSequenceBuilder >> lifeLines [

	| lb yStart yEnd descriptor commonIndex transparentHeaders minTopHeader lifelines |
	lb := RSLineBuilder line
		      withBorderAttachPoint;
		      yourself.

	descriptor := self modelDescriptor.

	yStart := descriptor yStart.
	yEnd := descriptor yEnd.

	commonIndex := self
		               greatest: previousHeaders
		               commonIndex: descriptor columns.

	transparentHeaders := OrderedCollection new.
	minTopHeader := nil.

	lifelines := descriptor columnsWithIndexCollect: [ :each :index | 
		             | end edge x headerShape isShared |
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


		             edge := (lb edgeFrom: headerShape to: end)
			                     dotted;
			                     yourself.

		             { 
			             headerShape.
			             end.
			             edge } ].

	transparentHeaders do: [ :each | 
		| y shape |
		shape := lifelines at: each.
		y := minTopHeader position y - minTopHeader height.
		shape first position: shape first position x @ y ].

	^ lifelines collect: [ :each | 
		  RSComposite new
			  shapes: each;
			  yourself ]
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
		  ifFalse: [ super shapeFor: anObject index: anIndex ]
]

{ #category : #hooks }
RSUMLSequenceBuilder >> shapesFor: aCollection [

	greatestCommonIndex := self
		                       greatest: previousMessagesSends
		                       commonIndex: messagesSends.

	^ greatestCommonIndex = messagesSends size
		  ifTrue: [ RSGroup new ]
		  ifFalse: [ 
			  (self lifeLines as: RSGroup)
				  addAll: (super shapesFor: aCollection);
				  yourself ]
]

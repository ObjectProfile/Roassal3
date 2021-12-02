"
A sequence descriptor
"
Class {
	#name : #RSUMLSequenceDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'messagesSends',
		'maxHeight',
		'columns',
		'indexes',
		'labels',
		'headers',
		'widths',
		'maxLabelHeight',
		'orderedHeaders',
		'circles',
		'receiverArgumentsShape',
		'objectsSeenSoFar',
		'lastSends',
		'returnShapes'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #shapes }
RSUMLSequenceDescriptor >> circleShapesOf: anAssociation messageSend: aMessageSend [

	| xStart yStart xEnd startCircle endCircle clientShape composite startShapes radius |
	xStart := self xStartOf: anAssociation.
	xEnd := self xEndOf: anAssociation.
	yStart := self yStartOf: anAssociation.

	clientShape := self
		               nicknameOf: anAssociation value client
		               ifAbsent: [ Error signal ].

	radius := clientShape width / 2.

	startCircle := RSCircle new
		               model: anAssociation;
		               radius: radius;
		               withBorder;
		               sameColorAsBorderColor;
		               when: RSMouseLeftClick do: [ 
			               (anAssociation value client class lookupSelector:
					                anAssociation value callerSelector) ifNotNil: [ 
					               :cm | cm browse ] ];
		               yourself.

	startShapes := aMessageSend
		               ifSelfSend: [ 
			               radius := 0.
			               Array with: startCircle ]
		               ifNotSelfSend: [ 
			               xStart < xEnd
				               ifTrue: [ 
				               Array with: clientShape with: startCircle ]
				               ifFalse: [ 
					               radius := radius negated.
					               Array with: startCircle with: clientShape ] ].

	RSHorizontalLineLayout new
		horizontalGap: 0;
		alignMiddle;
		on: startShapes.

	composite := RSComposite new
		             shapes: startShapes;
		             padding: Float platinumRatio;
		             position: xStart - radius @ yStart;
		             yourself.

	endCircle := RSCircle new
		             position: xEnd @ yStart;
		             noPaint;
		             yourself.

	^ { 
		  composite.
		  endCircle }
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> circleShapesOf: anAssociation returnMessageSend: aMessageSend [

	^ aMessageSend
		  ifSelfSend: [ 
			  | pair startCircle |
			  pair := self
				          circleShapesOf: anAssociation
				          messageSend: aMessageSend key.

			  startCircle := pair second.
			  startCircle position: startCircle position
				  + ((self selectorLabelOf: anAssociation) encompassingRectangle right @ 0).

			  pair ]
		  ifNotSelfSend: [ 
			  | xStart yStart xEnd startCircle endCircle |
			  xStart := self xStartOf: anAssociation.
			  xEnd := self xEndOf: anAssociation.
			  yStart := self yStartOf: anAssociation.

			  startCircle := RSCircle new
				                 position: xStart @ yStart;
				                 noPaint;
				                 yourself.

			  endCircle := RSCircle new
				               position: xEnd @ yStart;
				               noPaint;
				               yourself.

			  { 
				  startCircle.
				  endCircle } ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> columnIndex: anIndex anotherColumnIndex: anotherIndex width: wrtWidth [

	| i j width |
	i := anIndex min: anotherIndex.
	j := anIndex max: anotherIndex.

	i = j ifTrue: [ j := j + 1 ].

	width := 0.
	i to: j - 1 do: [ :each | 
		| w |
		w := widths at: each ifAbsentPut: [ 
			     | nextHeader |
			     nextHeader := orderedHeaders at: each + 1 ifAbsent: [ nil ].
			     self
				     widthsAmongHeader: (orderedHeaders at: each)
				     andHeader: nextHeader ].
		width := width + w ].

	width < wrtWidth ifTrue: [ 
		| w |
		w := wrtWidth - width / (j - i).
		i to: j - 1 do: [ :each | 
		widths at: each put: (widths at: each) + w ] ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> columnIndexOf: anObject [

	^ columns at: anObject ifAbsentPut: [ 
		  | h |
		  objectsSeenSoFar
			  at: anObject
			  ifAbsentPut: [ objectsSeenSoFar size + 1 ].

		  h := headers at: anObject put: (self headerShapeOf: anObject).

		  orderedHeaders add: h.

		  columns size + 1 ]
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> columns [

	^ self columnsWithIndexCollect: [ :each :index | each ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> columnsWithIndexCollect: aBlock [

	| array |
	array := Array new: columns size.
	columns keysAndValuesDo: [ :anObject :index | 
		array at: index put: (aBlock value: anObject value: index) ].
	^ array
]

{ #category : #API }
RSUMLSequenceDescriptor >> createCircles [

	messagesSends do: [ :anAssoc | 
		| circleShapes |
		circleShapes := anAssoc value
			                dispatchCircleShapesOf: anAssoc
			                onSequenceDescritor: self.

		circles at: anAssoc put: circleShapes first -> circleShapes second ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> cumulateWidths [

	| cumulatedWidth |
	cumulatedWidth := 0.
	1 to: widths size do: [ :i | 
		| w |
		w := (widths at: i) ifNil: [ 
			     | missingWidth nextHeader |
			     nextHeader := orderedHeaders at: i + 1 ifAbsent: [ nil ].
			     missingWidth := self
				                     widthsAmongHeader: (orderedHeaders at: i)
				                     andHeader: nextHeader.
			     widths at: i put: missingWidth ].

		w := w * Float goldenRatio.

		widths at: i put: cumulatedWidth.

		cumulatedWidth := cumulatedWidth + w ].

	widths add: cumulatedWidth
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> durationLabelOf: anAssociation [

	^ (labels at: anAssociation) value
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> durationShapeOfMessageSend: aMessageSend timespan: aTimespan selectorShape: aShape [

	^ RSLabel new
		  when: RSMouseClick do: [ aTimespan inspect ];
		  text: aTimespan duration asStringScaledUptoHours;
		  italic;
		  yourself: [ :l | l fontSize: l fontSize * Float silverRatio ]
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> durationShapeOfReturnMessageSend: aMessageSend timespan: aTimespan selectorShape: aShape [

	^ RSComposite new
		  shapes: {  };
		  extent: 0 @ 0;
		  yourself
]

{ #category : #API }
RSUMLSequenceDescriptor >> endCircleOf: anAssociation [

	^ (circles at: anAssociation) value
]

{ #category : #public }
RSUMLSequenceDescriptor >> forPharo [

	"Set values to be used later"

	
]

{ #category : #API }
RSUMLSequenceDescriptor >> headerOf: anObject [

	^ headers at: anObject
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> headerShapeOf: anObject [

	| split composite shapes box nicknameShape |
	split := anObject class name splitOn: ' class'.

	shapes := split first splitCamelCase collect: [ :each | 
		          (self labelShapeOfString: each)
			          bold;
			          yourself ].

	split size = 2 ifTrue: [ 
		shapes add: ((self labelShapeOfString: '(class)')
				 italic;
				 yourself) ].

	RSVerticalLineLayout new
		alignCenter;
		verticalGap: 0;
		on: shapes.

	composite := RSComposite new
		             shapes: shapes;
		             paddedWithGoldenRatio.

	box := RSBox new
		       color: Color veryVeryLightGray translucent;
		       cornerRadius: Float platinumRatio;
		       extent: composite extent;
		       yourself.

	RSLocation new
		inner;
		center;
		stick: composite on: box.

	box := RSComposite new
		       when: RSMouseLeftClick do: [ anObject class browse ];
		       shapes: (Array with: box with: composite);
		       yourself.

	nicknameShape := self nicknameOf: anObject ifAbsent: [ Error signal ].

	RSLocation new
		below;
		stick: nicknameShape on: box.

	^ RSComposite new
		  shapes: (Array with: box with: nicknameShape);
		  yourself
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> labelShapeOfString: aString [

	^ RSLabel new
		  fontName: 'Source Code Pro';
		  text: aString;
		  yourself
]

{ #category : #API }
RSUMLSequenceDescriptor >> maxHeight: aNumber [

	maxHeight := aNumber * Float goldenRatio
]

{ #category : #API }
RSUMLSequenceDescriptor >> messagesSends: anObject [

	messagesSends := anObject
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> nicknameOf: anObject ifAbsent: aBlock [

	^ objectsSeenSoFar
		  at: anObject
		  ifPresent: [ :index | 
			  | nicknameShape |
			  nicknameShape := RSLabel new
				                   text: index asStringaz asUppercase;
				                   boxedWithPad: Float goldenPlatinumRatio.

			  nicknameShape
				  when: RSMouseLeftClick do: [ :ev | anObject inspect ];
				  yourself ]
		  ifAbsent: aBlock
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> objectsSeenSoFar: aDictionary [

	objectsSeenSoFar := aDictionary
]

{ #category : #API }
RSUMLSequenceDescriptor >> radius [

	  ^ maxLabelHeight / 2 * Float silverRatio
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> receiverArgumentsShape: aBlock [

	receiverArgumentsShape := aBlock
]

{ #category : #API }
RSUMLSequenceDescriptor >> refresh [

	| maxHeightSeenSoFar |
	orderedHeaders := OrderedCollection new.
	headers := IdentityDictionary new.
	circles := IdentityDictionary new.
	labels := IdentityDictionary new.
	columns := IdentityDictionary new.
	indexes := IdentityDictionary new.
	lastSends := IdentityDictionary new.
	returnShapes := IdentityDictionary new.
	widths := OrderedCollection new.

	maxLabelHeight := 0.
	maxHeightSeenSoFar := 0.

	messagesSends withIndexDo: [ :anAssoc :index | 
		| selectorLabel durationLabel fullMessageSend columnIndexOfClient columnIndexOfReceiver client receiver |
		indexes at: anAssoc put: index.

		fullMessageSend := anAssoc value.
		client := fullMessageSend client.
		receiver := fullMessageSend receiver.

		fullMessageSend recordReturnSend: anAssoc inDictionary: lastSends.

		columnIndexOfClient := self columnIndexOf: client.
		columnIndexOfReceiver := self columnIndexOf: receiver.

		selectorLabel := fullMessageSend 
			                 dispatchSelectorShapeOnSequenceDescritor: self.

		durationLabel := fullMessageSend
			                 dispatchTimespan: anAssoc key
			                 selectorShape: selectorLabel
			                 onSequenceDescritor: self.

		self
			columnIndex: columnIndexOfClient
			anotherColumnIndex: columnIndexOfReceiver
			width: (selectorLabel width max: durationLabel width).

		maxLabelHeight := maxLabelHeight max: selectorLabel height.

		maxHeightSeenSoFar := maxHeightSeenSoFar max:
			                      selectorLabel height + durationLabel height.

		labels at: anAssoc put: selectorLabel -> durationLabel ].

	"Final adjustments."
	self
		maxHeight: maxHeightSeenSoFar;
		cumulateWidths;
		createCircles
]

{ #category : #API }
RSUMLSequenceDescriptor >> selectorLabelOf: anAssociation [

	^ (labels at: anAssociation) key
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> selectorShapeOfMessageSend: aMessageSend [

	| split shapes aligningShapes keywords receiverShape |
	"Get the keywords of the selector."
	split := aMessageSend selector splitOn: $:.

	"In case there is at least one $:, then get rid of *last* empty string."
	split size > 1 ifTrue: [ 
		split := split allButLast collect: [ :each | each , ':' ] ].

	receiverShape := aMessageSend receiver in: [ :recv | 
		                 self
			                 nicknameOf: recv
			                 ifAbsent: [ receiverArgumentsShape value: recv ] ].

	aligningShapes := OrderedCollection new.

	keywords := split withIndexCollect: [ :each :index | 
		            | label argument argumentShape |
		            label := (self labelShapeOfString: each)
			                     bold;
			                     yourself.

		            argument := aMessageSend arguments
			                        at: index
			                        ifAbsent: [ nil ].

		            argumentShape := argument
			                             ifNil: [ 
				                             RSComposite new
					                             shapes: {  };
					                             extent: receiverShape extent;
					                             yourself ]
			                             ifNotNil: [ 
				                             self
					                             nicknameOf: argument
					                             ifAbsent: [ 
					                             receiverArgumentsShape value:
						                             argument ] ].

		            RSLocation new
			            outer;
			            left;
			            offset: Float platinumRatio negated @ 0;
			            stick: label on: argumentShape.


		            aligningShapes add: argumentShape.

		            label -> argumentShape ].

	RSVerticalLineLayout new
		alignLeft;
		verticalGap: 0;
		on: aligningShapes.

	shapes := { 
		          receiverShape.
		          (RSComposite new
			           shapes: (keywords collect: [ :anAssoc | 
						            RSComposite new
							            shapes:
								            (Array with: anAssoc key with: anAssoc value);
							            yourself ]);
			           yourself) }.

	RSHorizontalLineLayout new in: [ :layout | 
		keywords size = 1
			ifTrue: [ layout alignMiddle ]
			ifFalse: [ layout alignTop ].

		layout
			horizontalGap: Float platinumRatio;
			on: shapes ].

	^ RSComposite new
		  when: RSMouseLeftClick do: [ 
			  (aMessageSend receiver class lookupSelector:
					   aMessageSend selector) ifNotNil: [ :cm | cm browse ] ];
		  shapes: shapes;
		  yourself
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> selectorShapeOfReturnMessageSend: aMessageSend [

	| return shape |
	return := aMessageSend return.

	shape := self
		         nicknameOf: return
		         ifAbsent: [ receiverArgumentsShape value: return ].

	returnShapes at: return put: shape.

	^ shape
]

{ #category : #API }
RSUMLSequenceDescriptor >> startCircleOf: anAssociation [

	^ (circles at: anAssociation) key
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> widthsAmongHeader: anHeader andHeader: anotherHeader [

	^ anHeader width / 2
	  + (anotherHeader ifNil: [ 0 ] ifNotNil: [ :r | r width / 2 ])
]

{ #category : #API }
RSUMLSequenceDescriptor >> xEndOf: anObject [

	^ self xOfColumn: (columns at: anObject value receiver)
]

{ #category : #API }
RSUMLSequenceDescriptor >> xOfColumn: aColumnIndex [

	^ widths at: aColumnIndex
]

{ #category : #API }
RSUMLSequenceDescriptor >> xStartOf: anObject [

	^ self xOfColumn: (columns at: anObject value client)
]

{ #category : #API }
RSUMLSequenceDescriptor >> yEnd [

	^ self yStartOf: messagesSends last
]

{ #category : #'as yet unclassified' }
RSUMLSequenceDescriptor >> yEndOfHeader: anObject ifAbsent: aBlock [

	^ lastSends
		  at: anObject
		  ifPresent: [ :anAssoc | self yStartOf: anAssoc ]
		  ifAbsent: aBlock
]

{ #category : #API }
RSUMLSequenceDescriptor >> yStart [

	^ self yStartOf: messagesSends first
]

{ #category : #API }
RSUMLSequenceDescriptor >> yStartOf: anAssociation [

	  ^ (indexes at: anAssociation) * maxHeight
]

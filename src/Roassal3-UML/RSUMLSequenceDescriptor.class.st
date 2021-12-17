"
A sequence descriptor
"
Class {
	#name : #RSUMLSequenceDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'messagesSends',
		'indexes',
		'labels',
		'headers',
		'widths',
		'circles',
		'receiverArgumentsShape',
		'objectsSeenSoFar',
		'lastSends',
		'selfMessageSends',
		'levels',
		'heights'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #shapes }
RSUMLSequenceDescriptor >> circleShapesOf: timedMessageSend messageSend: aMessageSend [

	| xStart yStart xEnd startCircle endCircle clientShape composite startShapes radius |
	xStart := self xStartOf: timedMessageSend.

	xEnd := timedMessageSend messageSend
		        ifSelfSend: [ :messageSend | 
			        | width |
			        width := (levels at: messageSend) third.
			        xStart + width ]
		        ifNotSelfSend: [ self xEndOf: timedMessageSend ].

	yStart := self yStartOf: timedMessageSend.

	clientShape := self
		               nicknameOf: timedMessageSend messageSend client
		               ifAbsent: [ Error signal ].

	radius := (clientShape encompassingRectangle area / Float pi) sqrt.

	startCircle := RSCircle new
		               model: timedMessageSend;
		               radius: radius;
		               withBorder;
		               sameColorAsBorderColor;
		               when: RSMouseLeftClick do: [ 
			               (timedMessageSend messageSend client class 
				                lookupSelector:
					                timedMessageSend messageSend callerSelector) 
				               ifNotNil: [ :cm | cm browse ] ];
		               yourself.

	startShapes := aMessageSend
		               ifSelfSend: [ 
			               radius := 0.
			               Array with: startCircle ]
		               ifNotSelfSend: [ 
			               radius := clientShape width / 2.
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
		             position: xStart - radius @ yStart;
		             yourself.

	endCircle := RSCircle new
		             position: xEnd @ yStart;
		             noPaint;
		             yourself.

	^ composite -> endCircle
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> circleShapesOf: timedMessageSend returnMessageSend: aMessageSend [

	| xStart yStart xEnd startCircle endCircle |
	xStart := self xStartOf: timedMessageSend.

	xEnd := timedMessageSend messageSend
		        ifSelfSend: [ :messageSend | 
			        | width |
			        width := (levels at: messageSend) third.
			        xStart - width ]
		        ifNotSelfSend: [ self xEndOf: timedMessageSend ].

	yStart := self yStartOf: timedMessageSend.

	startCircle := RSCircle new
		               position: xStart @ yStart;
		               noPaint;
		               yourself.

	endCircle := RSCircle new
		             position: xEnd @ yStart;
		             noPaint;
		             yourself.

	^ startCircle -> endCircle
]

{ #category : #API }
RSUMLSequenceDescriptor >> columnIndexOf: anObject [

	^ (headers at: anObject) value
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> columns [

	^ self columnsWithIndexCollect: [ :each :index | each ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> columnsWithIndexCollect: aBlock [

	| array |
	array := Array new: headers size.
	headers keysAndValuesDo: [ :anObject :anAssoc | 
		| index |
		index := anAssoc value.
		array at: index put: (aBlock value: anObject value: index) ].
	^ array
]

{ #category : #API }
RSUMLSequenceDescriptor >> createCircles [

	messagesSends do: [ :timedMessageSend | 
		circles at: timedMessageSend put: (timedMessageSend messageSend
				 dispatchCircleShapesOf: timedMessageSend
				 onSequenceDescritor: self) ]
]

{ #category : #API }
RSUMLSequenceDescriptor >> cumulateHeights [

	heights := Array new: indexes size.

	indexes keysAndValuesDo: [ :aMessageSend :anAssociation | 
		heights at: anAssociation key put: anAssociation value ].

	heights := heights scan: [ :acc :each | acc + each ] init: 0
]

{ #category : #API }
RSUMLSequenceDescriptor >> cumulateWidths [

	| cumulateWidths |
	widths := IdentityDictionary new.

	levels keysAndValuesDo: [ :aMessageSend :anArray | 
		| width client indent |
		client := aMessageSend client.

		width := widths at: client ifAbsent: [ 
			         | clientHeader receiverHeader |
			         clientHeader := (headers at: client) key.
			         receiverHeader := (headers at: aMessageSend receiver) key.
			         clientHeader width + receiverHeader width / 2 ].

		indent := self currentIndentOfLink: anArray first.
		width := width max: indent + anArray third
			         + (aMessageSend ifSelfSend: [ 0 ] ifNotSelfSend: [ 0 ]).

		widths at: client put: width ].

	cumulateWidths := Array new: headers size.

	headers keysAndValuesDo: [ :anObject :anAssoc | 
		cumulateWidths at: anAssoc value put: (widths at: anObject) ].

	widths := cumulateWidths scan: [ :acc :each | acc + each ] init: 0
]

{ #category : #API }
RSUMLSequenceDescriptor >> currentIndentOfLink: aLink [

	| link indent |
	link := aLink.

	indent := 0.
	link do: [ :anArray | indent := indent + anArray third ].

	^ indent
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
		  fontSizeSilverRatio;
		  padded: Float goldenPlatinumRatio
		  withBoxDo: [ :box | box color: Color transparent ]
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
RSUMLSequenceDescriptor >> headerIfAbsentCreateAt: anObject [

	| anAssoc |
	anAssoc := headers at: anObject ifAbsentPut: [ 
		           | headerShape index |
		           headerShape := self headerShapeOf: anObject.
		           index := headers size + 1.
		           headerShape -> index ].

	^ anAssoc key
]

{ #category : #API }
RSUMLSequenceDescriptor >> headerOf: anObject [

	^ (headers at: anObject) key
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> headerShapeOf: anObject [

	| split composite shapes nicknameShape |
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
		             when: RSMouseLeftClick do: [ anObject class browse ];
		             padded: Float goldenPlatinumRatio
		             withBoxDo: [ :box | 
			             box borderDo: [ :border | 
					             box color: border color translucent ] ].

	nicknameShape := self nicknameOf: anObject ifAbsent: [ Error signal ].

	RSLocation new
		below;
		stick: nicknameShape on: composite.

	^ RSComposite new
		  model: anObject;
		  shapes: (Array with: composite with: nicknameShape);
		  yourself
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> labelShapeOfString: aString [

	^ RSLabel new
		  useDefaultCodeFont;
		  text: aString;
		  yourself
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
				                   useDefaultCodeFont;
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
RSUMLSequenceDescriptor >> orderedHeaders [

	| orderedHeaders |
	orderedHeaders := Array new: headers size.

	headers valuesDo: [ :anAssoc | 
		orderedHeaders at: anAssoc value put: anAssoc key ].

	^ orderedHeaders
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> receiverArgumentsShape: aBlock [

	receiverArgumentsShape := aBlock
]

{ #category : #API }
RSUMLSequenceDescriptor >> refresh [

	| indentations refMessageSends |
	headers := IdentityDictionary new.
	circles := IdentityDictionary new.
	labels := IdentityDictionary new.
	indexes := IdentityDictionary new.
	levels := IdentityDictionary new.
	lastSends := IdentityDictionary new.
	selfMessageSends := IdentityDictionary new.
	indentations := IdentityDictionary new.
	refMessageSends := IdentityDictionary new.

	messagesSends withIndexDo: [ :timedMessageSend :index | 
		| selectorShape durationShape fullMessageSend client receiver width height levelArray clientLink receiverLink |
		"Unpack the message send, heavily referred in what follows."
		fullMessageSend := timedMessageSend messageSend.

		refMessageSends at: fullMessageSend put: timedMessageSend.

		"Dispatch instead of #ifMessageSend:ifReturnMessageSend:, 
		 to record the 'last' send for the pair (client, receiver)."
		fullMessageSend
			recordReturnSend: timedMessageSend
			inDictionary: lastSends.

		"Bind client and receiver."
		client := fullMessageSend client.
		receiver := fullMessageSend receiver.

		"Stick an alias."
		objectsSeenSoFar
			ifAbsentPutOrderAt: client;
			ifAbsentPutOrderAt: receiver.

		self
			headerIfAbsentCreateAt: client;
			headerIfAbsentCreateAt: receiver.

		selectorShape := fullMessageSend 
			                 dispatchSelectorShapeOnSequenceDescritor: self.

		durationShape := fullMessageSend
			                 dispatchTimespan: timedMessageSend timespan
			                 selectorShape: selectorShape
			                 onSequenceDescritor: self.

		"Get the current indentation for `client`."
		clientLink := indentations at: client ifAbsent: [ nil ].
		receiverLink := indentations at: receiver ifAbsent: [ nil ].

		"Golden proportion for the width."
		width := (selectorShape width max: durationShape width)
		         * Float goldenRatio.

		levelArray := levels at: timedMessageSend messageSend put: { 
				              clientLink.
				              receiverLink.
				              width }.

		"Record the `index` of the current send, it is computed in #withIndexDo: then save it."
		height := selectorShape height + durationShape height.

		fullMessageSend ifMessageSend: [  ] ifReturnMessageSend: [ 
			| sendArray refDurationShape |
			sendArray := levels at: fullMessageSend key.

			sendArray at: 3 update: [ :currentWidth | currentWidth max: width ].

			refDurationShape := self durationLabelOf:
				                    (refMessageSends at: fullMessageSend key).

			height := height + refDurationShape height ].

		indexes at: timedMessageSend put: index -> height.

		"For each `client` we record the self sends that occur to be connected by life lines."
		fullMessageSend
			ifSelfSend: [ "Save the current message send in the sequence for `client`."
				selfMessageSends
					at: client
					inOrderedCollectionAdd: timedMessageSend.

				"Push or pop according to send or return."
				indentations at: client put: (fullMessageSend
						 ifMessageSend: [ levelArray ~~> clientLink ]
						 ifReturnMessageSend: [ clientLink nextLink ]) ]
			ifNotSelfSend: [  ].

		labels at: timedMessageSend put: selectorShape -> durationShape ].

	"Final adjustments."
	self
		cumulateHeights;
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
			            offset: Float goldenPlatinumRatio negated @ 0;
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
			horizontalGap: Float goldenPlatinumRatio;
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

	^ shape
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> selfMessageSends [

	^ selfMessageSends
]

{ #category : #API }
RSUMLSequenceDescriptor >> startCircleOf: anAssociation [

	^ (circles at: anAssociation) key
]

{ #category : #API }
RSUMLSequenceDescriptor >> xEndOf: timedMessageSend [

	| indent |
	indent := self currentIndentOfLink:
		          (levels at: timedMessageSend messageSend) second.

	^ (self xOfColumn:
		   (headers at: timedMessageSend messageSend receiver) value)
	  + indent
]

{ #category : #API }
RSUMLSequenceDescriptor >> xOfColumn: aColumnIndex [

	^ widths at: aColumnIndex
]

{ #category : #API }
RSUMLSequenceDescriptor >> xStartOf: timedMessageSend [

	| indent |
	indent := self currentIndentOfLink:
		          (levels at: timedMessageSend messageSend) first.
		
	^ (self xOfColumn:
		   (headers at: timedMessageSend messageSend client) value) + indent
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

	^ heights at: (indexes at: anAssociation) key + 1
]

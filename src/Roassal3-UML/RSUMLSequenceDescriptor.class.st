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
		'objectsSeenSoFar',
		'lastSends',
		'selfMessageSends',
		'levels',
		'heights',
		'umlBuilder'
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
			               RSGroup with: startCircle ]
		               ifNotSelfSend: [ 
			               radius := clientShape width / 2.
			               xStart < xEnd
				               ifTrue: [ 
				               RSGroup with: clientShape with: startCircle ]
				               ifFalse: [ 
					               radius := radius negated.
					               RSGroup with: startCircle with: clientShape ] ].

	RSHorizontalLineLayout new
		horizontalGap: 0;
		alignMiddle;
		on: startShapes.

	composite := startShapes asShape
		             position: xStart - radius @ yStart;
		             propertyAt: #startCircle put: startCircle;
		             yourself.

	endCircle := self invisibleCircleAtPoint: xEnd @ yStart.

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

	startCircle := self invisibleCircleAtPoint: xStart @ yStart.
	startCircle propertyAt: #startCircle put: startCircle.

	endCircle := self invisibleCircleAtPoint: xEnd @ yStart.

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

	| orderedHeaders |
	orderedHeaders := Array new: headers size.

	headers valuesDo: [ :anAssoc | 
		orderedHeaders at: anAssoc value put: anAssoc key ].

	widths := Array streamContents: [ :aStream | 
		          orderedHeaders overlappingPairsDo: [ 
			          :anHeader 
			          :anotherHeader | 
			          aStream nextPut:
				          anHeader width + anotherHeader width / 2
				          * Float goldenRatio ].

		          aStream nextPut: orderedHeaders last width / 2 ].

	self assert: widths size = orderedHeaders size.

	messagesSends do: [ :aTimedMessageSend | 
		| anArray aMessageSend |
		aMessageSend := aTimedMessageSend messageSend.
		anArray := levels at: aMessageSend.

		aMessageSend
			ifMessageSend: [ 
				| client clientIndex receiverIndex clientIndent receiverIndent receiver messageWidth |
				client := aMessageSend client.
				receiver := aMessageSend receiver.

				"Get the corresponding indexes."
				clientIndex := self columnIndexOf: client.
				receiverIndex := self columnIndexOf: receiver.

				"Indent of the client due to nested self sends."
				clientIndent := self currentIndentOfLink: anArray first.
				receiverIndent := self currentIndentOfLink: anArray second.

				"Absolute width for the current message send."
				messageWidth := clientIndent + anArray third.

				aMessageSend
					ifSelfSend: [ "Everything has to fit in just one 'column' of the current 'client'."
						widths at: clientIndex update: [ :currentWidth | 
							currentWidth max:
								messageWidth + (anArray third * Float bronzeRatio) ] ]
					ifNotSelfSend: [ 
						| width start end dist |
						widths
							at: clientIndex
							update: [ :currentWidth | currentWidth max: clientIndent ].

						start := clientIndex min: receiverIndex.
						end := clientIndex max: receiverIndex.

						width := receiverIndent * (clientIndex < receiverIndex
							          ifTrue: [ "Toward right (forward) case" 1 ]
							          ifFalse: [ "Toward left (backward) case" -1 ]).

						start to: end - 1 do: [ :i | width := width + (widths at: i) ].

						dist := messageWidth - width / (end - start) max: 0.

						start to: end - 1 do: [ :i | 
						widths at: i update: [ :currentWidth | currentWidth + dist ] ] ] ]
			ifReturnMessageSend: [ "Ignore this case because we take care of max 
				of corresponding sends already in `#refresh`"
				 ] ].

	widths := widths scan: [ :acc :each | acc + each ] init: 0
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

	| aShape nicknameShape |
	aShape := umlBuilder headerShapeOf: anObject.

	nicknameShape := self nicknameOf: anObject ifAbsent: [ Error signal ].

	RSLocation new
		below;
		stick: nicknameShape on: aShape.

	^ RSComposite new
		  model: anObject;
		  shapes: (Array with: aShape with: nicknameShape);
		  yourself
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> invisibleCircleAtPoint: aPoint [

	^ RSCircle new
		  position: aPoint;
		  extent: 0 @ 0;
		  noPaint;
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

	| split shapes aligningShapes keywords receiverShape leftLocation |
	leftLocation := RSLocation new
		                outer;
		                left;
		                offset: Float goldenPlatinumRatio negated @ 0;
		                yourself.

	"Get the keywords of the selector."
	split := aMessageSend selector splitOn: $:.

	"In case there is at least one $:, then get rid of *last* empty string."
	split size > 1 ifTrue: [ 
		split := split allButLast collect: [ :each | each , ':' ] ].

	receiverShape := aMessageSend receiver in: [ :recv | 
		                 self
			                 nicknameOf: recv
			                 ifAbsent: [ 
			                 umlBuilder receiverArgumentsShapeOf: recv ] ].

	aligningShapes := OrderedCollection new.

	keywords := split withIndexCollect: [ :each :index | 
		            | label argument argumentShape |
		            label := (umlBuilder labelShapeOfString: each)
			                     bold;
			                     yourself.

		            argument := aMessageSend arguments
			                        at: index
			                        ifAbsent: [ nil ].

		            argumentShape := argument
			                             ifNil: [ 
				                             RSComposite new
					                             shapes: {  };
					                             extent: 0 @ 0;
					                             yourself ]
			                             ifNotNil: [ 
				                             self
					                             nicknameOf: argument
					                             ifAbsent: [ 
					                             umlBuilder 
						                             receiverArgumentsShapeOf: argument ] ].

		            leftLocation stick: label on: argumentShape.

		            aligningShapes add: argumentShape.

		            label -> argumentShape ].

	RSVerticalLineLayout new
		alignLeft;
		verticalGap: 0;
		on: aligningShapes.

	leftLocation stick: receiverShape on: keywords first key.

	shapes := { 
		          receiverShape.
		          (RSComposite new
			           shapes: (keywords collect: [ :anAssoc | 
						            RSComposite new
							            shapes:
								            (Array with: anAssoc key with: anAssoc value);
							            yourself ]);
			           yourself) }.

	^ RSComposite new
		  shapes: shapes;
		  when: RSMouseLeftClick do: [ 
			  (aMessageSend receiver class lookupSelector:
					   aMessageSend selector) ifNotNil: [ :cm | cm browse ] ];
		  yourself
]

{ #category : #shapes }
RSUMLSequenceDescriptor >> selectorShapeOfReturnMessageSend: aMessageSend [

	| return |
	return := aMessageSend return.

	^ self
		  nicknameOf: return
		  ifAbsent: [ umlBuilder receiverArgumentsShapeOf: return ]
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> selfMessageSends [

	^ selfMessageSends
]

{ #category : #API }
RSUMLSequenceDescriptor >> startCircleOf: anAssociation [

	^ (circles at: anAssociation) key
]

{ #category : #accessing }
RSUMLSequenceDescriptor >> umlBuilder: aBuilder [

	umlBuilder := aBuilder
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

Class {
	#name : #RSTreeLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #tests }
RSTreeLayoutTest >> exampleClassHierarchies: aCollection [

	<script:
	'RSTreeLayoutTest new exampleClassHierarchies: { Collection . Magnitude . RSObject . RBNode }'>
	| commits edges aCanvas gr |
	gr := 1.61803398875.
	commits := Array streamContents: [ :aStream | 
		           aCollection do: [ :aClass | 
			           aClass withAllSubclassesDo: [ :aSubClass | 
				           | label box |
				           label := RSLabel new text: aSubClass name.
				           aSubClass isAbstract ifTrue: [ 
					           label
						           bold;
						           italic ].
				           box := RSBox new
					                  color: Color white;
					                  withBorder;
					                  cornerRadius: gr double;
					                  extent: label extent + gr double double asPoint;
					                  yourself.
				           RSLocation new center stick: label on: box.
				           aStream nextPut: (RSComposite new
						            model: aSubClass;
						            shapes: (Array with: box with: label);
						            draggable;
						            when: RSMouseLeftClick
						            do: [ :ev | aSubClass browse ];
						            yourself) ] ] ].

	edges := RSLineBuilder horizontalBezier
		         shapes: commits;
		         withHorizontalAttachPoint;
		         connectToAll: [ :aSubClass | aSubClass subclasses ].

	edges sort: [ :a :b | 
		| aName bName |
		aName := a from model name.
		bName := b from model name.
		aName = bName
			ifTrue: [ a to model name < b to model name ]
			ifFalse: [ aName < bName ] ].

	RSHorizontalVanDerPloegTreeLayout new
		doNotValidateCycles;
		on: commits edges: edges.

	aCanvas := RSCanvas new
		           addAll: commits , edges;
		           yourself.

	aCanvas
		zoomToFit;
		exportToSVG;
		@ RSCanvasControllerInteraction;
		open
]

{ #category : #tests }
RSTreeLayoutTest >> exampleRoassal3CommitsWithTimeGaps [

	<script: 'RSTreeLayoutTest new exampleRoassal3CommitsWithTimeGaps'>
	| icerepo commits edges dict aCanvas |
	icerepo := IceRepository registry detect: [ :each | 
		           each name = 'Roassal3' ].

	dict := Dictionary new.

	icerepo allBranches do: [ :aBranch | 
		(icerepo newCommitWalk fromBranch: aBranch) commits do: [ :aCommit | 
			| circle |
			circle := dict at: aCommit id put: (RSCircle new
					           model: aCommit id asSymbol;
					           "radius:
						           ((aCommit changesTo: aCommit parent) size / Float pi)
							           sqrt;"
					           propertyAt: #gitCommit
					           put: aCommit;
					           color: Color white;
					           draggable;
					           addInteraction: (RSPopup new text: [ 
								            String streamContents: [ :aStream | 
										            aStream
											            nextPutAll: aCommit comment;
											            cr;
											            cr;
											            nextPutAll: aCommit shortId;
											            nextPutAll: ' -- by ';
											            nextPutAll: aCommit author;
											            nextPutAll: ' at ';
											            nextPutAll: aCommit datetime asLocalStringYMDHM;
											            nextPutAll: '.' ] ]);
					           withBorder;
					           yourself).

			aCommit isMergeCommit ifTrue: [ circle color: circle border color ] ] ].

	commits := dict values.

	edges := RSLineBuilder verticalBezier
		         shapes: commits;
		         withVerticalAttachPoint;
		         connectToAll: [ :aCommitId | 
			         ((dict at: aCommitId) propertyAt: #gitCommit) ancestorIds ].

	edges sort: [ :a :b | 
		| aTime bTime |
		aTime := (a to propertyAt: #gitCommit) datetime.
		bTime := (b to propertyAt: #gitCommit) datetime.
		aTime > bTime
			ifTrue: [ true ]
			ifFalse: [ 
				aTime = bTime
					ifTrue: [ 
						(a from propertyAt: #gitCommit) datetime
						> (b from propertyAt: #gitCommit) datetime ]
					ifFalse: [ false ] ] ].

	[ 
	RSVanDerPloegTreeLayout new
		doNotValidateCycles;
		verticalGap: [ :parent :child | 
			| duration goldenRatio |
			goldenRatio := 1.61803398875.
			duration := (parent propertyAt: #gitCommit) datetime
			            - (child propertyAt: #gitCommit) datetime.
			self assert: duration asSeconds >= 0.
			((duration asMinutes max: goldenRatio) log: goldenRatio)
			* goldenRatio ];
		on: commits edges: edges.

	aCanvas := RSCanvas new
		           addAll: commits , edges;
		           yourself.

	edges do: [ :each | 
		self deny: each to encompassingRectangle top
			< each from encompassingRectangle bottom.

		(each to propertyAt: #vdpLevel) - (each from propertyAt: #vdpLevel)
		> 1 ifTrue: [ 
			each
				dashArray: #( 4 );
				color: each color translucent;
				pushBack ] ].

	aCanvas
		zoomToFit;
		@ RSCanvasControllerInteraction;
		open ] timeToRun inspect
]

{ #category : #tests }
RSTreeLayoutTest >> exampleTraitsHierarchies [

	<script: 'RSTreeLayoutTest new exampleTraitsHierarchies'>
	| commits edges aCanvas gr |
	gr := 1.61803398875.
	commits := (Smalltalk allTraits sorted: [ :a :b | a name < b name ]) 
		           collect: [ :aTrait | 
			           | label box |
			           label := RSLabel new text: aTrait name.
			           box := RSBox new
				                  color: Color white;
				                  withBorder;
				                  cornerRadius: gr double;
				                  extent: label extent + gr double double asPoint;
				                  yourself.
			           RSLocation new center stick: label on: box.
			           RSComposite new
				           model: aTrait;
				           draggable;
				           shapes: (Array with: box with: label);
				           when: RSMouseLeftClick do: [ :ev | aTrait browse ];
				           yourself ].

	edges := RSLineBuilder horizontalBezier
		         shapes: commits;
		         withHorizontalAttachPoint;
		         connectFromAll: [ :aTrait | aTrait traits ].

	edges sort: [ :a :b | 
		| aName bName |
		aName := a from model name.
		bName := b from model name.
		aName = bName
			ifTrue: [ a to model name < b to model name ]
			ifFalse: [ aName < bName ] ].

	RSHorizontalVanDerPloegTreeLayout new
		doNotValidateCycles;
		on: commits edges: edges.

	aCanvas := RSCanvas new
		           addAll: commits , edges;
		           yourself.

	aCanvas
		zoomToFit;
		exportToSVG;
		@ RSCanvasControllerInteraction;
		open
]

{ #category : #tests }
RSTreeLayoutTest >> testBasic [
	RSTreeLayout on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithHorizontalGap [
	RSTreeLayout new horizontalGap: 50; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(117.5@7.5). (62.5@32.5). (200.0@32.5). (35.0@57.5). (117.5@57.5). (172.5@57.5). (227.5@57.5). (7.5@82.5). (62.5@82.5). (117.5@82.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithLeftGap [
	| withNoGap withGap |
	RSTreeLayout new leftGap: 15; on: canvas nodes.
	withNoGap := {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}.
	withGap := withNoGap collect: [ :p | p + (10 @ 0) ].
	self assert: (shapes collect: #position) asArray equals: withGap
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithTopGap [
	| withNoGap withGap |
	RSTreeLayout new topGap: 15; on: canvas nodes.
	withNoGap := {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}.
	withGap := withNoGap collect: [ :p | p + (0 @ 10) ].
	self assert: (shapes collect: #position) asArray equals: withGap
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithVerticalGap [
	RSTreeLayout new verticalGap: 50; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(23.5@7.5). (15.5@62.5). (35.5@62.5). (11.5@117.5). (23.5@117.5). (31.5@117.5). (39.5@117.5). (7.5@172.5). (15.5@172.5). (23.5@172.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testCycles [ 
	| chars |
	canvas := RSCanvas new.
	chars := $a to: $e.
	shapes := RSComposite models: chars forEach: [ :composite :char |
		| box label |
		label := RSLabel text: char.
		box := RSBox new 
			position: label position;
			extent: label extent + 10;
			yourself.
		
		composite 
			draggable;
			add: box;
			add: label;
			yourself.
		].

	canvas addAll: shapes.
	RSLineBuilder arrowedLine
		canvas: canvas;
		withVerticalAttachPoint;
		useAssociations: 
			{$a -> $b.
			$a -> $e.
			$b -> $c.
			$c -> $d.
			$d -> $a}. "cycle"
	self should: [RSTreeLayout on: shapes] raise: Error.
	RSTreeLayout new doNotValidateCycles; on: shapes
	
]

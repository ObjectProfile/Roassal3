Class {
	#name : #RSTreeLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal3-Layouts-Tests'
}

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

{ #category : #tests }
RSTreeLayoutTest >> testRoassal3CommitsWithTimeGaps [

	| icerepo commits edges dict |
	icerepo := IceRepository registry detect: [ :each | 
		           each name = 'Roassal3' ].
	"Containers-Essentials"

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
											            nextPutAll: '  -- by ';
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
		(a from propertyAt: #gitCommit) datetime
		> (b from propertyAt: #gitCommit) datetime ].

	[ 
	RSVanDerPloegTreeLayout new
		doNotValidateCycles;
		verticalGap: [ :parent :child | 
			| duration |
			duration := (parent propertyAt: #gitCommit) datetime
			            - (child propertyAt: #gitCommit) datetime.
			self assert: duration asSeconds >= 0.
			((duration asMinutes max: Float goldenRatio) log: Float goldenRatio)
			* Float goldenRatio ];
		on: commits edges: edges.

	edges do: [ :each | 
		each to encompassingRectangle top
		< each from encompassingRectangle bottom ifTrue: [ 
			each
				dashArray: #( 4 );
				color: each color translucent ] ].

	RSCanvas new
		addAll: commits , edges;
		@ RSCanvasController;
		zoomToFit;
		exportToSVG;
		open ] timeToRun inspect
]

"
NyanCat
"
Class {
	#name : #RSCat,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'pixel',
		'rainbowColors',
		'tileColor'
	],
	#category : #'Roassal3-Experimental-Animations'
}

{ #category : #building }
RSCat >> addAnimationSlider [
	| red black slider label loc layout ps durations |
	red := RSBox new extent: 3 * pixel asPoint; color: Color red.
	black := RSBox new extent: 18@3 * pixel; color: Color black.
	slider := { red. black }.
	layout := RSHorizontalLineLayout new gapSize: 0.
	layout on: slider.
	slider := slider asGroup asShape.
	slider isFixed: true.
	label := RSLabel new text: '100%'; color: Color white; isFixed: true.
	loc := RSLocation new
		outer; right;
		move: label on: slider.
	ps := NSScale linear domain: #(0 1); range: {0. 6 }.
	durations := canvas animations collect: [ :a | a duration ].
	slider when: RSMouseClick do: [ :evt | | p |
		p := evt camera fromSpaceToPixel: evt position.
		p := p x / slider width.
		red width: p * slider width.
		black width: (1-p)* slider width.
		layout on: slider children.
		slider adjustToChildren.
		p := ps scale: p.
		label text: (p*100) asInteger asString, '%'.
		loc move: label on: slider.

		canvas animations with: durations do: [ :a :d |
			a duration: d / p ] .
		].
	canvas addAll: {slider. label}
]

{ #category : #building }
RSCat >> addCat [
	| body head feet tail delta |
	body := self catBody.
	body position: 0@0.
	head := self catHead.
	head position: 8@ 2 * pixel.
	tail := self catTail.
	tail position: -12 @3 * pixel.
	feet := self catFeet.

	{-6@8. -9@7.5. 9@7.5. 5@8.} with: feet do: [ :pos :foot |
		foot position: pos * pixel ].

	delta := { -20. -100. -90. -10.   0. -45}.
	feet, {body. head } with: delta do: [ :part :d| | currentPosition |
		currentPosition := part position.
		canvas newAnimation repeat
			duration: 430 milliSeconds;
			from: 360;
			to: 0;
			onStepDo: [ :t | | angle |
				angle := (t +d) degreesToRadians.

				part position: (angle cos @ angle sin negated) * pixel + currentPosition
				].

		 ].
	canvas addAll: feet, { tail. body. head}
]

{ #category : #building }
RSCat >> addRainbow [
	| rainbow psx psy |
	rainbow := (1 to: 6 )collect: [ :i | self createRainbowSegFor: i ] as: RSGroup.
	psy := NSScale linear domain: #(0 0.5 1); range: { -1. 1. -1 }.
	psx := NSScale linear domain: #(0 1); range: { -1. -7 }.
	canvas newAnimation
		repeat;
		duration: 1 second;
		onStepDo: [ :t |
			rainbow doWithIndex: [ :s :i | | p y |
				p := s position.
				y := (psy scale: (t + (i / (rainbow size)))%1) * pixel * 2.
				s translateTo: p x @ y.
				 ].
			 ].
	canvas newAnimation
		repeat;
		duration: 4 seconds;
		onStepDo: [ :t |
			rainbow doWithIndex: [ :s :i | | p x |
				p := s position.
				x := (psx scale: (t+ (i /rainbow size))%1 ) * pixel*6.
				s translateTo: x @ p y.
			].
		].
	canvas addAll: rainbow.
	rainbow pushBack
]

{ #category : #building }
RSCat >> addStars [
	| stars sx r delta |
	stars := (1 to: 10) collect: [ :i | self newStar ] as: RSGroup.
	r := Random new.
	stars do: [ :s | s position: -1000@ (800 * r next - 400) ].
	sx := NSScale linear
		range: { 700. -700}.
	delta := stars collect: [ :i | r next ].
	canvas newAnimation
		repeat;
		duration: 4 seconds;
		onStepDo: [ :t |
			stars with: delta do: [ :s :d |
				s position: (sx scale: (t + d)%1) @ s position y.
				 ]
			 ].
	canvas addAll: stars.
	stars pushBack
]

{ #category : #building }
RSCat >> catBody [
	^ self partFrom: '
001111111111111111100
012222222222222222210
122233333333333332221
122333333343334333221
123343333333333333321
123333333333333343321
123333433333333333321
123333333333333333321
123333333433333333321
123334333333333333321
123333333333333433321
123333343333333333321
123333333333333343321
123433333333333333321
122333334333333333221
122233333333333332221
012222222222222222210
001111111111111111100
'
]

{ #category : #building }
RSCat >> catFeet [
	| feet |
	feet := {
'
001111
015551
155551
155551
155510
111100
'.

'
001111
015551
155551
155551
155510
111100
'.

'
111100
155510
155551
155551
015551
001111
'.

'
111100
155510
155551
155551
015551
001111
'.
 }.
	^ feet collect: [ :s | self partFrom: s ]
]

{ #category : #building }
RSCat >> catHead [
	^ self partFrom: '
0011000000001100
0155100000015510
0155510000155510
0155551111555510
0155555555555510
1555555555555551
1555715555571551
1555115551511551
1566555555555661
1566515515515661
0155511111115510
0015555555555100
0001111111111000
'
]

{ #category : #building }
RSCat >> catTail [
	| tail ys |
	tail:= RSGroup with: self firstTail.
	tail addAll: ((1 to: 3) collect: [ :i| self middleTail]).
	RSHorizontalLineLayout new gapSize: 0 * pixel; on: tail.

	ys := NSScale linear domain: #(0 0.5 1); range: { -1. 1. -1 }.
	canvas newAnimation repeat
		duration: 430 milliSeconds;
		onStepDo: [ :t |
			tail doWithIndex: [ :s :i | | p y |
				p := s position.
				y := (ys scale: t) *pixel * (tail size -i).
				s position: p x @ y.
				 ].
			].
	^ tail asShape
]

{ #category : #building }
RSCat >> createRainbowSegFor: i [
	| boxes segment |
	boxes := (1 to: 6) collect: [ :j |
		RSBox new
			extent: 9@3 * pixel;
			color: (rainbowColors scale: j);
			yourself.
		 ] as: RSGroup.
	RSVerticalLineLayout new gapSize: 0; on: boxes.

	segment := boxes asShape.

	^ segment
]

{ #category : #building }
RSCat >> firstTail [
	^ self partFrom: '
0111
1555
1555
0111'
]

{ #category : #initialization }
RSCat >> initialize [
	super initialize.
	canvas := RSCanvas new.
	pixel := 10.
	rainbowColors := NSScale ordinal
		rangeFrom: {'#f1944e'. '#f9d448'. '#feef50'. '#66d841'. '#56c5f9'. '#9294f8'}.
	tileColor := NSScale ordinal
		domain: {$1. $2. $3. $4. $5. $6. $7};
		rangeFrom: { 'black'. '#f6d4ac'. '#f1a9f8'. '#dd63b6'. '#a8c5e9'. '#f9deeb'. 'white'}
]

{ #category : #building }
RSCat >> middleTail [
	^ self partFrom: '
11
55
55
11
'
]

{ #category : #building }
RSCat >> newStar [
	| rays |
	rays :=( 1 to: 4) collect: [ :i | RSBox new color: Color white ].
	canvas newAnimation
		repeat;
		duration: 1 second;
		scale: (NSScale linear
			domain: #(0 0.33 0.66 1);
			range: { 0. 0.5. 1. 1} );
		onStepDo: [ :t |
			rays do: [ :s |  | r |
				r := s encompassingRectangle.
				r privateSetCorner: pixel / 2 @ (t* pixel * 6).
				s fromRectangle: r.
				 ].
		].

	canvas newAnimation
		repeat;
		duration: 1 second;
		scale: (NSScale linear
			domain: #(0 0.33 0.66 1);
			range: { 0. 0. 0.5. 1} );
		onStepDo: [ :t |
			rays do: [ :s |  | r |
				r := s encompassingRectangle.
				r privateSetOrigin: pixel / -2 @ (t* pixel * 6).
				s fromRectangle: r.
				 ].
		].

	^ (rays collectWithIndex: [ :r :i |
		RSComposite new
			add: r;
		 	rotateByDegrees: i* 90;
			yourself ]) asGroup asShape
]

{ #category : #building }
RSCat >> partFrom: aString [
	| model g |
	model := aString trimBoth.
	g := RSGroup new.
	model lines doWithIndex: [ :line :k |
		line doWithIndex: [ :c :j |
			self tileFor: c pos: j @ k in: g ] ].
	^ g asShape
]

{ #category : #running }
RSCat >> run [
	<script: 'self new run'>
	self addCat.
	canvas color: Color transparent.

	canvas open
		setLabel: 'Nyan cat in roassal';
		extent: 1000@800;
		color: Color transparent;
		position: 0@10.
	canvas camera zoomToFit: canvas extent* 0.8.
	self addRainbow; addStars.
	canvas newAnimation repeat onStepDo: [ canvas signalUpdate ].
	self addAnimationSlider
]

{ #category : #building }
RSCat >> tileFor: char pos: pos in: group [
	| tile |
	char = $0 ifTrue: [ ^ self ].
	tile := RSBox new
		size: pixel;
		color: (tileColor scale: char);
		position: pos * (pixel-1).
	group add: tile
]

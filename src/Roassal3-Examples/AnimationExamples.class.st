"
I have examples for animation
"
Class {
	#name : #AnimationExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
AnimationExamples >> example01 [ 
	<script: 'self new example01'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation 
		easing: TSEasing sin;
		from: -100@ -100;
		to: 100@100;
		on: b set: #position:.
	c animation 
		from: Color red;
		to: Color blue;
		on: b set: #color:.
	c animation 
		from: 0;
		to: 10;
		on: b border set: 'width:'.
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c clearBackground: false.
	c open.
]

{ #category : #examples }
AnimationExamples >> example02 [
	<script: 'self new example02'>
	| c b animation |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	animation := c animationFrom: { 
		(c tAnimation
			from: -100@ -200;
			to: 100@130;
			on: b set: #position:).
		(c tAnimation
			from: Color red;
			to: Color blue;
			on: b set: #color:).
		(c tAnimation 
			from: 0;
			to: 10;
			on: b border set: 'width:')
	}.
	animation
		loops: 2.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

{ #category : #examples }
AnimationExamples >> example03 [
	<script: 'self new example03'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)};
		on: b set: #position:.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

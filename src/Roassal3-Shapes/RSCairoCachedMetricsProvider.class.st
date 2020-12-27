"
I am a basic example of how to provide a text cache for roassal3 RSLabel text extent. But the idea is to use RSCairoMetricsProvider or RSCairoFitMetricsProvider. Only if you want speed for your labels

I use a Dictionary for each font, then for each font there is a new Dictionary where key is a char and value is the width of that char with that value.

This class allows us to use a cache and improve the speed of text calculation.

But it is not precise. There are some issues but in our benchmarks it shows a speed improvement.

Here an example

```Smalltalk
| c words mp can |
c := RSCanvas new.
words := String loremIpsum splitOn: ' '.
mp := RSCairoCachedMetricsProvider new.
""words ,"" #(
offic culp PŘÍLIŠ ŽLUŤOUČKÝ KŮN ÚPĚL ĎÁBELSKÉ ÓDY
ca caff Šca Šcaff Žca Žcaff Sca Scaff Zca Zcaff w . Ů) do: [ :word | 
	c add: (RSLabel new
		""fontName: 'Viner Hand ITC';""
		metricsProvider: mp;
		text: word;
		yourself)].
RSFlowLayout on: c nodes.
c showEncompassingRectangles.
can := RSCanvasController new.
can configuration maxScale: 40.
c @ can.
c
```
"
Class {
	#name : #RSCairoCachedMetricsProvider,
	#superclass : #RSCairoMetricsProvider,
	#instVars : [
		'cache'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSCairoCachedMetricsProvider >> dictionaryFor: font [
	^ Dictionary new.
	
]

{ #category : #hooks }
RSCairoCachedMetricsProvider >> extentsOf: aRSLabel [
	| map font h w |
	font := aRSLabel font.
	map := cache 
		at: font 
		ifAbsentPut: [ self dictionaryFor: font ].
	"this need to calculate the x_bearing and the kerning between characters"
	w := aRSLabel text 
		ifEmpty: [ 0 ]
	 	ifNotEmpty: [ (aRSLabel text
			collect: [ :char | self widthOf: char map: map font: font ] 
			as: Array) sum asFloat ].
	h := font getPreciseHeight asFloat.
	
	^ RSTextExtents new
		width: w;
		height: h;
		x_advance: 0;
		y_advance: 0;
		x_bearing: 0;
		y_bearing: font getPreciseAscent negated;
		yourself.

]

{ #category : #initialization }
RSCairoCachedMetricsProvider >> initialize [
	cache := Dictionary new.
]

{ #category : #hooks }
RSCairoCachedMetricsProvider >> widthOf: char map: map font: aLogicalFont [
	^ map at: char
		ifAbsentPut: [ 
			| glyphs rawExt cairoFont |
			glyphs := CairoFontMetricsProvider new
				font: aLogicalFont;
				glyphsOf: char asString.
			rawExt := CairoTextExtents new.
			cairoFont := CairoScaledFont fromFreetypeFont: aLogicalFont asFreetypeFont.
			cairoFont getExtentsOfGlyphs: glyphs getHandle ofLength: glyphs size into: rawExt.
			rawExt x_advance
			].
]

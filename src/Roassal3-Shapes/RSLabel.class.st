"
Instances of RSLabel uses font, text metrics, and a string. These labels can share fonts.

Instance variables:
- text: a String without character cr or lf or tabs.
- fontName: a String, the font family name, Eg: `Source Code Pro`.
- fontSize: a positive number.
- font: an instance of LogicalFont, Eg: `LogicalFont familyName: 'Source Code Pro' pointSize: 20`
- emphasis: an instance of TextEmphasis, Eg: `TextEmphasis italic`
- metricsProvider: an instance of RSMetricProvider. Users of RSLabel can define a subvclass of RSMetricProvider in order to have differnt metrics for this class.
- textExtents: an instance of RSTextExtents, it has text information of this class.
- cairoGlyphs: private varible used to compute extents and draw this shape on the canvas


```Smalltalk
| c font words |
c := RSCanvas new.
font := LogicalFont familyName: 'Source Code Pro' pointSize: 20.
words := String loremIpsum splitOn: ' '.
c addAll: (words collect: [:word | 
	RSLabel new
		font: font;
		text: word;
		yourself ]).
c showEncompassingRectangles.
RSFlowLayout on: c nodes.
	
c @ RSCanvasController.
c

```

For more fonts of your system use: `FreeTypeFontProvider current updateFromSystem families`.
"
Class {
	#name : #RSLabel,
	#superclass : #RSBoundingShape,
	#instVars : [
		'text',
		'fontName',
		'fontSize',
		'font',
		'emphasis',
		'metricsProvider',
		'textExtents',
		'cairoGlyphs'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #public }
RSLabel class >> defaultFont [
	^ StandardFonts defaultFont
]

{ #category : #public }
RSLabel class >> familyFontName [
	"
	self familyFontName
	"
	| fontList |
	fontList := LogicalFontManager current allFamilies collect: #familyName.
	
	(fontList includes: 'Source Sans Pro') ifTrue: [ ^ 'Source Sans Pro' ].
	(fontList includes: 'DejaVu Sans') ifTrue: [ ^ 'DejaVu Sans' ].
	fontList ifEmpty: [ ^ StandardFonts defaultFont familyName ].
	
	(fontList includes: StandardFonts listFont familyName ) 
		ifTrue: [ ^ StandardFonts listFont familyName ].
		
	
	^  StandardFonts defaultFont familyName 
]

{ #category : #accessing }
RSLabel class >> text: aText [
	^ self new text: aText
]

{ #category : #accessing }
RSLabel class >> text: aText model: aModelObject [
	"Initialize a label with a text and a model"
	^ self new text: aText; model: aModelObject
]

{ #category : #visiting }
RSLabel >> accept: visitor [
	visitor visitLabel: self.
]

{ #category : #'managing font' }
RSLabel >> bold [
"Make the label bold
```
| c lbl1 lbl2 |
c := RSCanvas new.
lbl1 := RSLabel new bold; text: 'hello'.
c addShape: lbl1.
lbl2 := RSLabel new text: 'world'.
c addShape: lbl2.
RSLocation new below; move: lbl2 on: lbl1.
c open
```
"
	self emphasisAdd: TextEmphasis bold.
]

{ #category : #accessing }
RSLabel >> cairoFont [
	"used in drawing and extents computation"
	^ CairoScaledFont fromFreetypeFont: font asFreetypeFont
]

{ #category : #accessing }
RSLabel >> cairoGlyphs [
	"used in drawing and extents computation"
	^ cairoGlyphs ifNil: [
		cairoGlyphs := CairoFontMetricsProvider new
			font: font;
			glyphsOf: text ].
]

{ #category : #metrics }
RSLabel >> computeTextExtents [
	^ self hasText 
		ifTrue: [ self metricsProvider extentsOf: self ]
		ifFalse: [ RSTextExtents empty ]
]

{ #category : #private }
RSLabel >> createFont [
	| aFont |
	aFont := LogicalFont 
		familyName: fontName
		pointSize: fontSize.
	aFont := aFont emphasized: emphasis emphasisCode.
	^ aFont
]

{ #category : #accessing }
RSLabel >> emphasis [
	^ emphasis
]

{ #category : #accessing }
RSLabel >> emphasis: aTextEmphasis [
"
| c lbl |
c := RSCanvas new.
lbl := RSLabel new text: 'hello'; emphasis: TextEmphasis italic.
c addShape: lbl.
c @ RSCanvasController.
c open
"
	emphasis = aTextEmphasis ifTrue: [ ^ self ].
	emphasis := aTextEmphasis.
	self resetFont.
]

{ #category : #'managing font' }
RSLabel >> emphasisAdd: anEmphasis [
	emphasis add: anEmphasis.
	self resetFont.
]

{ #category : #accessing }
RSLabel >> font [
	^ font
]

{ #category : #accessing }
RSLabel >> font: aLogicalFont [
	font = aLogicalFont ifTrue: [ ^ self ].
	font := aLogicalFont.
	fontSize := font pointSize.
	fontName := font familyName.
	emphasis := TextEmphasis fromCode: font emphasis.
	self fontName: self privateFontName.
	self resetCache.
	
]

{ #category : #accessing }
RSLabel >> fontName [
	^ fontName
]

{ #category : #accessing }
RSLabel >> fontName: aString [
	"
	LogicalFontManager current allFamilies inspect
	"
	fontName = aString ifTrue: [ ^ self ].
	fontName := aString.
	self resetFont.
	
]

{ #category : #accessing }
RSLabel >> fontSize [
	^ fontSize 
]

{ #category : #accessing }
RSLabel >> fontSize: aNumber [
	"Set the size of the label.
Here is an example:
```Smalltalk
c := RSCanvas new.

(1 to: 100 by: 5) shuffled do: [ :i |
	lbl := RSLabel new fontSize: i; text: 'hello'; model: i.
	c add: lbl.
	lbl @ RSPopup.
].
RSFlowLayout on: c shapes.
c @ RSCanvasController
```
"
	fontSize = aNumber ifTrue: [ ^ self ].
	fontSize := aNumber.
	self resetFont.
]

{ #category : #testing }
RSLabel >> hasText [
	^ text notNil and: [ text isNotEmpty ]
]

{ #category : #initialization }
RSLabel >> initialize [
	super initialize.
	paint := Color gray.
	self font: self class defaultFont.
	
]

{ #category : #private }
RSLabel >> is: anInteger [
	"anInteger is a valid code"
	^ (emphasis emphasisCode bitAnd: anInteger) > 0
]

{ #category : #testing }
RSLabel >> isBold [
	^ self is: 1
]

{ #category : #testing }
RSLabel >> isItalic [
	^ self is: 2
]

{ #category : #testing }
RSLabel >> isNormal [
	^ emphasis emphasisCode = 0
]

{ #category : #testing }
RSLabel >> isStruckOut [
	^ self is: 16
]

{ #category : #testing }
RSLabel >> isUnderlined [
	^ self is: 4
]

{ #category : #'managing font' }
RSLabel >> italic [
	"Make the label italic
```
| c lbl1 lbl2 |
c := RSCanvas new.
lbl1 := RSLabel new italic; text: 'hello'.
c addShape: lbl1.
lbl2 := RSLabel new text: 'world'.
c addShape: lbl2.
RSLocation new below; move: lbl2 on: lbl1.
c @ RSCanvasController.
c open
```
"
	self emphasisAdd: TextEmphasis italic.
]

{ #category : #metrics }
RSLabel >> metricsProvider [
	^ metricsProvider ifNil: [ metricsProvider := RSMetricsProvider default ]
]

{ #category : #metrics }
RSLabel >> metricsProvider: aRSMetricsProvider [
	"Set the way metrics related to the label (e.g., height, width), can be computed. The metric provier per default is RSCairoMetricsProvider.
	
	 The argument must be a subclass of RSMetricsProvider.
	
	For example:
	
```Smalltalk
metricsProvider := RSCairoMetricsProvider new.

words := (String loremIpsum: 2000) substrings.
labels := words collect: [ :w | RSLabel new metricsProvider: metricsProvider; text: w ].

c := RSCanvas new.
c addAll: labels.
RSFlowLayout on: labels.
c @ RSCanvasController
c open
```
	"
	metricsProvider := aRSMetricsProvider.
	self resetCache.
]

{ #category : #'accessing - attributes' }
RSLabel >> model: anObject [
	"model is used to create popups and other interactions"
	super model: anObject.
	self hasText ifFalse: [ self text: anObject asString ]
]

{ #category : #'managing font' }
RSLabel >> normal [
	self emphasis: TextEmphasis normal.
]

{ #category : #private }
RSLabel >> privateFontName [
	^ font realFont isTTCFont
		ifTrue: [ font familyName ] 
		ifFalse: [ self class familyFontName ]
	
]

{ #category : #initialization }
RSLabel >> resetCache [ 
	font ifNil: [ font := self createFont ].
	
	textExtents := nil.
	self resetCairoGlyphs.
	self extent: self textWidth @ self textHeight.
]

{ #category : #initialization }
RSLabel >> resetCairoGlyphs [
	cairoGlyphs := nil
]

{ #category : #initialization }
RSLabel >> resetFont [
	font := nil.
	self resetCache.
]

{ #category : #path }
RSLabel >> sessionChanged [
	super sessionChanged.
	self resetCairoGlyphs
]

{ #category : #'managing font' }
RSLabel >> struckOut [
	"Make the label strickethrough
	
```
| c lbl1 lbl2 |
c := RSCanvas new.
lbl1 := RSLabel new struckOut; text: 'hello'.
c addShape: lbl1.
lbl2 := RSLabel new text: 'world'.
c addShape: lbl2.
RSLocation new below; move: lbl2 on: lbl1.
c @ RSCanvasController.
c open
```
"
	self emphasisAdd: TextEmphasis struckOut.
]

{ #category : #accessing }
RSLabel >> text [
	^ text
]

{ #category : #accessing }
RSLabel >> text: string [
	"Set the text of a label. do not try to write in the `text` variable directly."
	text = string ifTrue: [ ^ self ].
	text := string asString.
	self resetCache; resetPath.
]

{ #category : #accessing }
RSLabel >> textExtents [
	^ textExtents ifNil: [ textExtents := self computeTextExtents ].
]

{ #category : #accessing }
RSLabel >> textHeight [
	"without any transformation"

	^ self textExtents height
]

{ #category : #accessing }
RSLabel >> textWidth [
	"without any transformation"
	
	^ self textExtents width
]

{ #category : #'managing font' }
RSLabel >> underline [
	"Make the label underlined
```
| c lbl1 lbl2 |
c := RSCanvas new.
lbl1 := RSLabel new underline; text: 'hello'.
c addShape: lbl1.
lbl2 := RSLabel new text: 'world'.
c addShape: lbl2.
RSLocation new below; move: lbl2 on: lbl1.
c @ RSCanvasController.
c open
```
"
	self emphasisAdd: TextEmphasis underlined.
]

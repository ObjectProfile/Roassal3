"
I represent simple label text
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
		'cachedHeight',
		'cachedWidth'
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

{ #category : #visiting }
RSLabel >> accept: visitor [
	visitor visitLabel: self.
]

{ #category : #'managing font' }
RSLabel >> bold [
"
Make the font bold

| c lbl1 lbl2 |
c := TSCanvas new.
lbl1 := TSLabel new bold; text: 'hello'.
c addShape: lbl1.
lbl2 := TSLabel new text: 'world'.
c addShape: lbl2.
RSLocate new below; move: lbl2 on: lbl1.
c open
"
	self emphasisAdd: TextEmphasis bold.
]

{ #category : #accessing }
RSLabel >> descent [
	^ font descent
]

{ #category : #accessing }
RSLabel >> emphasis [
"
| c lbl |
c := TSCanvas new.
lbl := TSLabel new text: 'hello'.
c addShape: lbl.
c open
"

	^ emphasis
]

{ #category : #accessing }
RSLabel >> emphasis: anEmphasis [
	emphasis := anEmphasis.
	self resetCache.
]

{ #category : #'managing font' }
RSLabel >> emphasisAdd: anEmphasis [
	emphasis add: anEmphasis.
	self resetCache
]

{ #category : #accessing }
RSLabel >> font [
	^ font
]

{ #category : #accessing }
RSLabel >> font: aFont [
	font := aFont
]

{ #category : #accessing }
RSLabel >> fontName [
	^ fontName
]

{ #category : #accessing }
RSLabel >> fontName: string [
	"
	LogicalFontManager current allFamilies inspect
	"
	fontName := string.
	self resetCache.
	
]

{ #category : #accessing }
RSLabel >> fontSize [
	^ fontSize 
]

{ #category : #accessing }
RSLabel >> fontSize: integer [
	"Set the size of the label.
Here is an example:
-=-=-=-=-=-=
c := RSCanvas new.

(1 to: 100 by: 5) shuffled do: [ :i |
	lbl := RSLabel new fontSize: i; text: 'hello'; model: i.
	c add: lbl.
	lbl @ RSPopup.
].
RSFlowLayout on: c shapes.
c @ RSControlsCanvas
-=-=-=-=-=-=
"
	fontSize := integer.
	self resetCache
]

{ #category : #initialization }
RSLabel >> initialize [
	| defaultFont |
	super initialize.
	paint := Color black.
	text := 'UNASSIGNED'.
	defaultFont := self class defaultFont.
	fontSize := defaultFont pixelSize.
	emphasis := TextEmphasis normal.
	
	self fontName: (defaultFont realFont class == StrikeFont 
		ifTrue: [ self class familyFontName ]
		ifFalse: [ defaultFont familyName ]). 
]

{ #category : #testing }
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
"
Make the font italic

| c lbl1 lbl2 |
c := TSCanvas new.
lbl1 := TSLabel new italic; text: 'hello'.
c addShape: lbl1.
lbl2 := TSLabel new text: 'world'.
c addShape: lbl2.
RSLocate new below; move: lbl2 on: lbl1.
c open
"
	self emphasisAdd: TextEmphasis italic.
]

{ #category : #'managing font' }
RSLabel >> normal [
	self emphasis: TextEmphasis normal.
]

{ #category : #'managing font' }
RSLabel >> resetCache [ 
	font := LogicalFont 
		familyName: fontName
		pointSize: fontSize.
	
	font := font emphasized: emphasis emphasisCode.
	cachedWidth := nil.
	cachedHeight := nil.
	self extent: self textWidth @ self textHeight.
]

{ #category : #'managing font' }
RSLabel >> struckOut [
	self emphasisAdd: TextEmphasis struckOut.
]

{ #category : #accessing }
RSLabel >> text [
	^ text
]

{ #category : #accessing }
RSLabel >> text: string [
	text = string ifTrue: [ ^ self ].
	text := string asString.
	self resetCache; resetPath.
]

{ #category : #accessing }
RSLabel >> textHeight [
	"without any transformation"

	^ cachedHeight
		ifNil: [ [ cachedHeight := font height ]
				on: Error
				do: [ :ex | cachedHeight := 10 ] ]
]

{ #category : #accessing }
RSLabel >> textWidth [
	"without any transformation"
	"font widthOfString: is a really expensive operation, so we cache it"
	^ cachedWidth
		ifNil: [ [ cachedWidth := font widthOfString: text ]
				on: Error
				do: [ :ex | cachedWidth := 5 ] ]
]

{ #category : #'managing font' }
RSLabel >> underline [
"
Make the font underlined

| c lbl1 lbl2 |
c := TSCanvas new.
lbl1 := TSLabel new underline; text: 'hello'.
c addShape: lbl1.
lbl2 := TSLabel new text: 'world'.
c addShape: lbl2.
RSLocate new below; move: lbl2 on: lbl1.
c open
"
	self emphasisAdd: TextEmphasis underlined.
]

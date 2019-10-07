"
I represent simple label text
"
Class {
	#name : #TSLabel,
	#superclass : #TSBoundingShape,
	#instVars : [
		'text',
		'fontName',
		'fontSize',
		'font',
		'emphasis',
		'cachedHeight',
		'cachedWidth'
	],
	#category : #'Roassal3-Shapes'
}

{ #category : #public }
TSLabel class >> defaultFont [
	^ StandardFonts defaultFont
]

{ #category : #public }
TSLabel class >> familyFontName [
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
TSLabel >> accept: visitor [
	visitor visitLabel: self.
]

{ #category : #'managing font' }
TSLabel >> bold [
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
TSLabel >> descent [
	^ font descent
]

{ #category : #accessing }
TSLabel >> emphasis [
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
TSLabel >> emphasis: anEmphasis [
	emphasis := anEmphasis.
	self resetCache.
]

{ #category : #'managing font' }
TSLabel >> emphasisAdd: anEmphasis [
	emphasis add: anEmphasis.
	self resetCache
]

{ #category : #accessing }
TSLabel >> font [
	^ font
]

{ #category : #accessing }
TSLabel >> font: aFont [
	font := aFont
]

{ #category : #accessing }
TSLabel >> fontName [
	^ fontName
]

{ #category : #accessing }
TSLabel >> fontName: string [
	"
	LogicalFontManager current allFamilies inspect
	"
	fontName := string.
	self resetCache.
	
]

{ #category : #accessing }
TSLabel >> fontSize [
	^ fontSize 
]

{ #category : #accessing }
TSLabel >> fontSize: integer [
	fontSize := integer.
	self resetCache
]

{ #category : #initialization }
TSLabel >> initialize [
	| defaultFont |
	super initialize.
	text := nil.
	defaultFont := self class defaultFont.
	fontSize := defaultFont pixelSize.
	emphasis := TextEmphasis normal.
	
	self fontName: (defaultFont realFont class == StrikeFont 
		ifTrue: [ self class familyFontName ]
		ifFalse: [ defaultFont familyName ]).
]

{ #category : #testing }
TSLabel >> is: anInteger [
	"anInteger is a valid code"
	^ (emphasis emphasisCode bitAnd: anInteger) > 0
]

{ #category : #testing }
TSLabel >> isBold [
	^ self is: 1
]

{ #category : #testing }
TSLabel >> isItalic [
	^ self is: 2
]

{ #category : #testing }
TSLabel >> isNormal [
	^ emphasis emphasisCode = 0
]

{ #category : #testing }
TSLabel >> isStruckOut [
	^ self is: 16
]

{ #category : #testing }
TSLabel >> isUnderlined [
	^ self is: 4
]

{ #category : #'managing font' }
TSLabel >> italic [
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
TSLabel >> normal [
	self emphasis: TextEmphasis normal.
]

{ #category : #'managing font' }
TSLabel >> resetCache [ 
	font := LogicalFont 
		familyName: fontName
		pointSize: fontSize.
	
	font := font emphasized: emphasis emphasisCode.
	cachedWidth := nil.
	cachedHeight := nil.
	self extent: self textWidth @ self textHeight.
]

{ #category : #'managing font' }
TSLabel >> struckOut [
	self emphasisAdd: TextEmphasis struckOut.
]

{ #category : #accessing }
TSLabel >> text [
	^ text
]

{ #category : #accessing }
TSLabel >> text: string [
	text = string ifTrue: [ ^ self ].
	text := string.
	self resetCache; resetPath.
]

{ #category : #accessing }
TSLabel >> textHeight [
	"without any transformation"

	^ cachedHeight
		ifNil: [ [ cachedHeight := font height ]
				on: Error
				do: [ :ex | cachedHeight := 10 ] ]
]

{ #category : #accessing }
TSLabel >> textWidth [
	"without any transformation"
	"font widthOfString: is a really expensive operation, so we cache it"
	^ cachedWidth
		ifNil: [ [ cachedWidth := font widthOfString: text ]
				on: Error
				do: [ :ex | cachedWidth := 5 ] ]
]

{ #category : #'managing font' }
TSLabel >> underline [
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

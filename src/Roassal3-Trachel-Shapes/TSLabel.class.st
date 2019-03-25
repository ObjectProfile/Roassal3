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
	#category : #'Roassal3-Trachel-Shapes-Core'
}

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
	self emphasis: (Array with: TextEmphasis bold).
]

{ #category : #accessing }
TSLabel >> descent [
	^ font descent
]

{ #category : #accessing }
TSLabel >> emphasis [
	^ emphasis
]

{ #category : #accessing }
TSLabel >> emphasis: anEmphasis [
	emphasis := anEmphasis isCollection
		ifTrue: [ anEmphasis ]
		ifFalse: [ Array with: anEmphasis ].
	self resetCache.
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
	super initialize.
	text := nil.
	fontSize := 12.
	emphasis := #().
	self fontName: self class familyFontName.
]

{ #category : #'managing font' }
TSLabel >> italic [
	self emphasis: (Array with: TextEmphasis italic).
]

{ #category : #'managing font' }
TSLabel >> resetCache [ 
	font := LogicalFont 
		familyName: fontName
		pointSize: fontSize.
	
	font := font emphasized: (emphasis inject: 0 into: [:sum :next | sum + next emphasisCode]).
	cachedWidth := nil.
	cachedHeight := nil.
	self extent: self textWidth @ self textHeight.
]

{ #category : #accessing }
TSLabel >> text [
	^ text
]

{ #category : #accessing }
TSLabel >> text: string [
	text := string.
	self resetCache.
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

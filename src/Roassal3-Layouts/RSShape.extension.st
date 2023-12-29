Extension { #name : 'RSShape' }

{ #category : '*Roassal3-Layouts' }
RSShape >> boxedWithPad: aPadding [

	^ self padded: aPadding withBoxDo: [ :box | 
		  box
			  color: Color white;
			  borderDo: [ :aBorder | aBorder color: aBorder color translucent ] ]
]

{ #category : '*Roassal3-Layouts' }
RSShape >> notedWithPad: aPadding [

	^ self padded: aPadding withNoteDo: [ :box | 
		  box
			  color: Color white;
			  borderDo: [ :aBorder | aBorder color: aBorder color translucent ] ]
]

{ #category : '*Roassal3-Layouts' }
RSShape >> padded: aPadding shape: boxShape do: aBlock [

	| box |
	box := boxShape
		       extent: self extent + (aPadding * 2);
		       cornerRadius: aPadding;
		       yourself.

	aBlock cull: box cull: self.

	RSLocation new
		center;
		stick: box on: self.

	^ RSComposite new
		  shapes: { 
				  box.
				  self };
		  yourself
]

{ #category : '*Roassal3-Layouts' }
RSShape >> padded: aPadding withBoxDo: aBlock [

	^ self padded: aPadding shape: RSBox new do: aBlock
]

{ #category : '*Roassal3-Layouts' }
RSShape >> padded: aPadding withNoteDo: aBlock [

	^ self padded: aPadding shape: RSNote new do: aBlock
]

{ #category : '*Roassal3-Layouts' }
RSShape >> padded: aPadding withSimplerNoteDo: aBlock [

	^ self padded: aPadding shape: RSSimplerNote new do: aBlock
]

{ #category : '*Roassal3-Layouts' }
RSShape >> paddedWithGoldenRatio [

	| pad |
	pad := self extent * Float silverRatio / 2 in: [ :extent | 
		       extent x max: extent y ].

	^ RSComposite new
		  shapes: { self };
		  padding: pad;
		  yourself
]

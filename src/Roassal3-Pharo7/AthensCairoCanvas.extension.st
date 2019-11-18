Extension { #name : #AthensCairoCanvas }

{ #category : #'*Roassal3-Pharo7' }
AthensCairoCanvas >> fillPreserve [
	^ self ffiCall: #(#void #cairo_fill_preserve #(#self))

	
]

{ #category : #'*Roassal3-Pharo7' }
AthensCairoCanvas >> fillRuleEvenOdd [
	"I am a extention method basic because pharo7 does not have this method
	we added in this package with the Baseline of roassal3
	this is a patch and we will find the right anwser to avoid this issue"
]

{ #category : #'*Roassal3-Pharo7' }
AthensCairoCanvas >> textPath: anUTF8String [
	"A drawing operator that generates the shape from a string of UTF-8 characters, rendered according to the current font_face, font_size (font_matrix), and font_options. "
	
	^ self ffiCall: #(void cairo_text_path (self, char * anUTF8String ))

]

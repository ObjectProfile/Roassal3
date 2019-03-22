Extension { #name : #AthensCairoCanvas }

{ #category : #'*Roassal3-Trachel' }
AthensCairoCanvas >> fillPreserve [
	^ self nbCall: #(#void #cairo_fill_preserve #(#self))

	
]

{ #category : #'*Roassal3-Trachel' }
AthensCairoCanvas >> textPath: anUTF8String [
	"A drawing operator that generates the shape from a string of UTF-8 characters, rendered according to the current font_face, font_size (font_matrix), and font_options. "
	
	^ self nbCall: #(void cairo_text_path (self, char * anUTF8String ))

]

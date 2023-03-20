Extension { #name : #RSAthensRenderer }

{ #category : #'*Roassal3-SVG' }
RSAthensRenderer >> buildSVGLinePath: line [
	| string |
	string := line svgPath value: line.

	string isString ifTrue: [ | converter |
		converter := ASPathConverter new stream: string readStream.
		converter convertPathData do: [ :each |
			builder
				perform: each first
				withArguments: each second ]
	] ifFalse: [
		string value: builder.
	]
]

{ #category : #'*Roassal3-SVG' }
RSAthensRenderer >> buildSVGPath: svg [
	svg segments ifNil: [ ^ self ].
	svg segments
		do: [ :each | builder perform: each first withArguments: each second ]
]

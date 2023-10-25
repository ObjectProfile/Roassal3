"
Root of most of the Roassal classes.
"
Class {
	#name : 'RSObject',
	#superclass : 'Object',
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'documentation' }
RSObject class >> addDocumentSection: aBuilder label: label methods: methods [

	methods ifEmpty: [ ^ self ].

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: label ] withLevel: 2.
	aBuilder unorderedListDuring: [
		(methods sorted: #selector ascending) do: [ :each |
			aBuilder item: [
				aBuilder monospace: (String streamContents:[:s |
					s << each methodClass name << '>>#' <<  each selector
					] ) ] ] ]
]

{ #category : 'documentation' }
RSObject class >> buildMicroDownUsing: aBuilder withComment: aString [
	super buildMicroDownUsing: aBuilder withComment: aString.
	self documentSections keysAndValuesDo: [ :label :methods |
		self addDocumentSection: aBuilder label: label methods: methods ]
]

{ #category : 'documentation' }
RSObject class >> documentSections [
	^ OrderedDictionary newFromPairs: {
		'Examples'. self class methods select: [ :each | each selector beginsWith: 'example' ].
		}
]

Class {
	#name : #RSRDGenerator,
	#superclass : #Object,
	#instVars : [
		'allClasses',
		'allKeyClasses'
	],
	#category : #'Roassal3-ReferenceDocumentation'
}

{ #category : #'as yet unclassified' }
RSRDGenerator >> doGenerate [
	<script: 'self new doGenerate'>
	| r3Packages |
	r3Packages := self roassal3Packages.
	allClasses := r3Packages flatCollect: #definedClasses.
	allKeyClasses := allClasses select: [ :c | self isKeyClass: c ].
	allKeyClasses := allKeyClasses sort: [ :a :b | a name < b name ].
	self writeRootFor: allKeyClasses.
	allKeyClasses do: [ :cls | self writeClass: cls ]
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> isKeyClass: aClass [
	^ aClass comment lines first = '<keyClass>'
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> path [
	^ '/Users/alexandrebergel/Dropbox/GitRepos/Roassal3/Reference'
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> roassal3Methods [
	^ self roassal3Packages flatCollect: #methods
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> roassal3Packages [
	^ RPackageOrganizer default packages
		select: [ :p |
			#('Numeric' 'Roassal3') anySatisfy: [ :r | p packageName beginsWith: r ] ]
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> writeClass: cls [

	| fr ref wr |
	fr := self path asFileReference.
	fr exists ifFalse: [ self error: 'Path does not exist' ].

	ref := fr / (cls name, '.md').
	ref exists ifTrue: [ ref delete ].

	wr := ref writeStream.
	wr nextPutAll: '[list of classes](reference.md)'; lf.
	wr nextPutAll: '# ', cls name; lf.
	wr nextPutAll: (String cr join: cls comment lines allButFirst) withUnixLineEndings; close
]

{ #category : #'as yet unclassified' }
RSRDGenerator >> writeRootFor: someClasses [

	| fr ref w |
	fr := self path asFileReference.
	fr exists ifFalse: [ self error: 'Path does not exist' ].

	ref := fr / 'reference.md'.
	ref exists ifTrue: [ ref delete ].
	w := ref writeStream.
	w nextPutAll: '# References'; lf.

	w nextPutAll: 'This page is the entry point of the _reference documentation_ of Roassal. We designate the reference documentation as a precise description of the machinary of Roassal. Comments of the key classes and key methods are accessible from this page.'.

	w lf; lf.
	w nextPutAll: 'The reduced distribution of Roassal (the ''default'' group in the baseline) is composed of '.
	w nextPutAll: self roassal3Packages size asString.
	w nextPutAll: ' packages, '.
	w nextPutAll: allClasses size asString.
	w nextPutAll: ' classes, and '.
	w nextPutAll: self roassal3Methods size asString.
	w nextPutAll: ' methods.'.

	w lf; lf.

	w nextPutAll: 'The key classes of Roassal are:'; lf.
	allKeyClasses do: [ :cls |
		w nextPutAll: '- [', cls name, '](', cls name, '.md)'; lf
	].
	w close
]

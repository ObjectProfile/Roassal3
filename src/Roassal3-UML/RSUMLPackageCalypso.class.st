"
I am a basic uml package browser
"
Class {
	#name : #RSUMLPackageCalypso,
	#superclass : #RSUMLCalypso,
	#instVars : [
		'packages'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #activation }
RSUMLPackageCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategy for: ClyPackageContextOfFullBrowser
]

{ #category : #accessing }
RSUMLPackageCalypso >> classes [
	^ packages flatCollect: #classes.
]

{ #category : #defaults }
RSUMLPackageCalypso >> defaultIconName [
	^#package
]

{ #category : #initialization }
RSUMLPackageCalypso >> defaultTitle [
	^'UML-Package'
]

{ #category : #accessing }
RSUMLPackageCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^packages = anotherBrowserTool packages
]

{ #category : #accessing }
RSUMLPackageCalypso >> packages [
	^ packages 
]

{ #category : #initialization }
RSUMLPackageCalypso >> setUpModelFromContext [
	super setUpModelFromContext.
	packages := context selectedPackages
]

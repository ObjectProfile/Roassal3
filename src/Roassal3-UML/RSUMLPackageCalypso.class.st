"
A browser tool for uml with packages and packages tags
"
Class {
	#name : #RSUMLPackageCalypso,
	#superclass : #RSAbstractUMLCalypso,
	#instVars : [
		'packages'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #'as yet unclassified' }
RSUMLPackageCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategy for: ClyClassGroup asCalypsoItemContext
]

{ #category : #'as yet unclassified' }
RSUMLPackageCalypso class >> classUmlTapActivation2 [
	<classAnnotation>
	^ClyTabActivationStrategy for: RPackage asCalypsoItemContext
]

{ #category : #accessing }
RSUMLPackageCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	^ RSUMLCalypsoSettings useCalypsoUML
		and: [ aBrowserContext isPackageSelected 
			and: [aBrowserContext isClassSelected not]]
]

{ #category : #accessing }
RSUMLPackageCalypso class >> tabOrder [
	^ -10
]

{ #category : #accessing }
RSUMLPackageCalypso >> computeClasses [
	^ self packages flatCollect: #classes.
	
]

{ #category : #initialization }
RSUMLPackageCalypso >> defaultTitle [
	^'UML-Package'
]

{ #category : #testing }
RSUMLPackageCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self packages = anotherBrowserTool packages
]

{ #category : #accessing }
RSUMLPackageCalypso >> packages [
	^ packages
]

{ #category : #accessing }
RSUMLPackageCalypso >> packages: aCollection [
	packages := aCollection
]

{ #category : #initialization }
RSUMLPackageCalypso >> setUpModelFromContext [
	self packages: (context isClassTagSelected 
		ifTrue: [ context selectedClassGroups ]
		ifFalse: [ context selectedPackages ]).
]

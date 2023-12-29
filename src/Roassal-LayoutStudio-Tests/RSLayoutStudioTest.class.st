"
A RSLayoutStudioTest is a test class for testing the behavior of RSLayoutStudio
"
Class {
	#name : 'RSLayoutStudioTest',
	#superclass : 'TestCase',
	#instVars : [
		'studio',
		'window'
	],
	#category : 'Roassal-LayoutStudio-Tests',
	#package : 'Roassal-LayoutStudio-Tests'
}

{ #category : 'running' }
RSLayoutStudioTest >> setUp [
	super setUp.
	studio := RSLayoutStudio new.
	window := studio open
]

{ #category : 'running' }
RSLayoutStudioTest >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : 'running' }
RSLayoutStudioTest >> testEditGridLayoutUpdatesToolPanel [
	| layoutClass association oldToolPanel |
	layoutClass := RSGridLayout.
	association := layoutClass -> layoutClass layoutDefinition.

	self deny: studio currentLayout class equals: layoutClass.
	oldToolPanel := studio controls.
	studio edit: association.
	self assert: studio currentLayout class equals: layoutClass.
	self deny: studio controls equals: oldToolPanel
]

{ #category : 'tests' }
RSLayoutStudioTest >> testGenerateFromDefaultCreatesAnString [
	| layoutClass association |
	layoutClass := RSGridLayout.
	association := layoutClass -> layoutClass layoutDefinition.
	studio edit: association.
	self assert: studio generateStringCode equals: 'layout := RSGridLayout new.'
]

{ #category : 'tests' }
RSLayoutStudioTest >> testGenerateWithChangedFieldShowsTheFieldAsString [
	| layoutClass association field |
	layoutClass := RSGridLayout.
	association := layoutClass -> layoutClass layoutDefinition.
	studio edit: association.
	field := studio layoutDefinition fieldNamed: 'horizontalGap'.
	field layoutValue: 20.
	self
		assert: studio generateStringCode
		equals: 'layout := RSGridLayout new
	horizontalGap: 20;
	yourself.'
]

{ #category : 'tests' }
RSLayoutStudioTest >> testOpenShouldCreateAWindow [
	self assert: window isDisplayed
]

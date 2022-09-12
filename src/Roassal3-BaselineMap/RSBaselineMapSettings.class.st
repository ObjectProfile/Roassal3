"
Settings for BaselineMap package, you can change the default class builder
"
Class {
	#name : #RSBaselineMapSettings,
	#superclass : #Object,
	#classInstVars : [
		'classMapBuilder'
	],
	#category : #'Roassal3-BaselineMap-UI'
}

{ #category : #accessing }
RSBaselineMapSettings class >> classMapBuilder [
	^ classMapBuilder ifNil: [ self defaultClassMapBuilder ]
]

{ #category : #accessing }
RSBaselineMapSettings class >> classMapBuilder: aClass [
	classMapBuilder := aClass
]

{ #category : #accessing }
RSBaselineMapSettings class >> defaultClassMapBuilder [
	^ RSThemedMapBuilder
]

{ #category : #settings }
RSBaselineMapSettings class >> settingsClassOn: aBuilder [
	<systemsettings>
	(aBuilder pickOne: #classMapBuilder)
		parent: #baselineMap;
		label: 'Baseline Map';
		description: 'Choose a class to be default in the inspector and baseline';
		target: self;
		domainValues: RSMapBuilder withAllSubclasses;
		default: RSMapBuilder
]

{ #category : #settings }
RSBaselineMapSettings class >> settingsGroupOn: aBuilder [
	<systemsettings>
	(aBuilder group: #baselineMap)
		label: #pharoSystem;
		label: 'Baseline Map';
		description: 'Used to generate a visual map'
]

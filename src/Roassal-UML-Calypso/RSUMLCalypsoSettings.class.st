"
Settings for UML use within Calypso
"
Class {
	#name : 'RSUMLCalypsoSettings',
	#superclass : 'Object',
	#classInstVars : [
		'initialSelectionClass',
		'darkThemeUMLClassColor',
		'lightThemeUMLClassColor',
		'methodsLimitUML',
		'useCalypsoUML',
		'useAnimationInCalypsoBaseline'
	],
	#category : 'Roassal-UML-Calypso-Settings',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Settings'
}

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> darkThemeUMLClassColor [
	^ darkThemeUMLClassColor ifNil: [ self defaultDarkThemeColorUMLClass ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> darkThemeUMLClassColor: aColor [
	darkThemeUMLClassColor := aColor
]

{ #category : 'accessing - defaults' }
RSUMLCalypsoSettings class >> defaultDarkThemeColorUMLClass [

	^Color colorFrom: '2C3E50'
]

{ #category : 'accessing - defaults' }
RSUMLCalypsoSettings class >> defaultLightThemeColorUMLClass [

	^Color colorFrom: 'ffffce'
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> initialSelectionClass [
	^ initialSelectionClass ifNil: [ RSDancingSelection ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> initialSelectionClass: aClass [
	initialSelectionClass := aClass
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> lightThemeUMLClassColor [
	^ lightThemeUMLClassColor ifNil: [ self defaultLightThemeColorUMLClass ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> lightThemeUMLClassColor: aColor [
	lightThemeUMLClassColor := aColor
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> methodsLimitUML [
	^ methodsLimitUML ifNil: [ methodsLimitUML := 30 ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> methodsLimitUML: aNumber [
	methodsLimitUML := aNumber
]

{ #category : 'settings' }
RSUMLCalypsoSettings class >> settingsForCalypsoUMLAnimationInBaseline: aBuilder [
	<systemsettings>
	(aBuilder setting: #useAnimationInCalypsoBaseline)
		parent: #useCalypsoUML;
		label: 'Use animation in calypso baseline';
		description: 'Enable or disable the animation for the Baseline-Graph';
		default: true;
		target: self
]

{ #category : 'settings' }
RSUMLCalypsoSettings class >> settingsForCalypsoUMLColorsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #CalypsoUMLColors)
		parent: #useCalypsoUML;
		label: 'UML Colors' ;
		description: 'All settings concerned with the look''n feel of your system';
		with: [
			(aBuilder setting: #lightThemeUMLClassColor)
				target: self;
				label: 'Light Theme UML Class color';
				default: self defaultLightThemeColorUMLClass.

			(aBuilder setting: #darkThemeUMLClassColor)
				target: self;
				label: 'Dark Theme UML Class color';
				default: self defaultDarkThemeColorUMLClass	 ]
]

{ #category : 'settings' }
RSUMLCalypsoSettings class >> settingsForCalypsoUMLInitialSelectionOn: aBuilder [
	<systemsettings>
	(aBuilder pickOne: #initialSelectionClass)
		parent: #useCalypsoUML;
		label: 'UML initial selection' ;
		description: 'Selected a strategy when you open a class with the uml';
		target: self;
		domainValues: RSInitialSelection allSubclasses;
		default: RSDancingSelection
]

{ #category : 'settings' }
RSUMLCalypsoSettings class >> settingsForCalypsoUMLOn: aBuilder [
	<systemsettings>
	(aBuilder group: #CalypsoUMLValues)
		parent: #useCalypsoUML;
		label: 'Capypso UML Methods' ;
		description: 'All settings concerned with the size of variables to show';
		with: [
			(aBuilder range: #methodsLimitUML)
				target: self;
				label: 'Limit for number of methods to show in UML class';
				default: 30;
				range: ( 0 to: 200). ]
]

{ #category : 'settings' }
RSUMLCalypsoSettings class >> settingsGroupOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #useCalypsoUML)
		label: 'Calypso UML';
		parent: #Calypso;
		default: true;
		target: self;
		description: 'Settings related to the UML within Calypso browser'
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> useAnimationInCalypsoBaseline [
	^ useAnimationInCalypsoBaseline ifNil: [ ^ true ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> useAnimationInCalypsoBaseline: aBoolean [
	useAnimationInCalypsoBaseline := aBoolean
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> useCalypsoUML [
	^ useCalypsoUML ifNil: [ ^ true ]
]

{ #category : 'accessing' }
RSUMLCalypsoSettings class >> useCalypsoUML: aBoolean [
	useCalypsoUML := aBoolean
]

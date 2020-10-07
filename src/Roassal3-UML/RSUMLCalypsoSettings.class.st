"
Settings for UML use within Calypso
"
Class {
	#name : #RSUMLCalypsoSettings,
	#superclass : #Object,
	#classVars : [
		'DarkThemeUMLClassColor',
		'LightThemeUMLClassColor',
		'MethodsLimitUML',
		'UseCalypsoUML'
	],
	#category : #'Roassal3-UML-Calypso-Settings'
}

{ #category : #accessing }
RSUMLCalypsoSettings class >> darkThemeUMLClassColor [
	^ DarkThemeUMLClassColor ifNil: [ self defaultDarkThemeColorUMLClass ]
]

{ #category : #accessing }
RSUMLCalypsoSettings class >> darkThemeUMLClassColor: aColor [
	DarkThemeUMLClassColor := aColor
]

{ #category : #defaults }
RSUMLCalypsoSettings class >> defaultDarkThemeColorUMLClass [

	^Color colorFrom: '2C3E50'
]

{ #category : #defaults }
RSUMLCalypsoSettings class >> defaultLightThemeColorUMLClass [

	^Color colorFrom: 'ffffce'
]

{ #category : #accessing }
RSUMLCalypsoSettings class >> lightThemeUMLClassColor [
	^LightThemeUMLClassColor ifNil: [ self defaultLightThemeColorUMLClass ]
]

{ #category : #accessing }
RSUMLCalypsoSettings class >> lightThemeUMLClassColor: aColor [
	LightThemeUMLClassColor := aColor
]

{ #category : #accessing }
RSUMLCalypsoSettings class >> methodsLimitUML [
	^ MethodsLimitUML ifNil: [ MethodsLimitUML := 30 ].
]

{ #category : #accessing }
RSUMLCalypsoSettings class >> methodsLimitUML: aNumber [
	MethodsLimitUML := aNumber
]

{ #category : #settings }
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

{ #category : #settings }
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

{ #category : #settings }
RSUMLCalypsoSettings class >> settingsGroupOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #useCalypsoUML)
		label: 'Calypso UML';
		parent: #Calypso;
		default: true;
		target: self;
		description: 'Settings related to the UML within Calypso browser'.
]

{ #category : #settings }
RSUMLCalypsoSettings class >> useCalypsoUML [
	^ UseCalypsoUML ifNil: [ ^ true ].
]

{ #category : #settings }
RSUMLCalypsoSettings class >> useCalypsoUML: aBoolean [
	UseCalypsoUML := aBoolean
]

"
Settings for UML use within Calypso
"
Class {
	#name : #RSUMLCalypsoSettings,
	#superclass : #Object,
	#classVars : [
		'DarkThemeUMLClassColor',
		'LightThemeUMLClassColor'
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

{ #category : #settings }
RSUMLCalypsoSettings class >> settingsForCalypsoUMLColorsOn: aBuilder [ 
	<systemsettings>
	(aBuilder group: #CalypsoUMLColors)
		parent: #CalypsoUML;
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
RSUMLCalypsoSettings class >> settingsGroupOn: aBuilder [
	<systemsettings>
	(aBuilder group: #CalypsoUML)
		label: 'Calypso UML';
		parent: #Calypso;
		description: 'Settings related to the UML within Calypso browser'
]

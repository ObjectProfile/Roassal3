Class {
	#name : #RSScriptOfTheDay,
	#superclass : #Object,
	#instVars : [
		'serverName',
		'servers'
	],
	#category : #'Roassal3-ScriptOfTheDay'
}

{ #category : #'class initialization' }
RSScriptOfTheDay class >> initialize [ 
	(Smalltalk includesKey: #DSWebhookClient) ifFalse: [ 
		Metacello new
		    baseline: #DiscordSt;
		    repository: 'github://bergel/DiscordSt/src';
		    load: #webhook ]. 
	
]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> initialize [
	
	| path |
	path := '/Users/alexandrebergel/Dropbox/Document/discordServers.txt'.
	path asFileReference contents lines.
	servers := Dictionary new.
	
	(path asFileReference contents lines collect: [ :l | l substrings: ' ' ]) do: [ :ar |
		servers at: ar first asSymbol put: ar second ].

	self useRealDiscordServer
	"
	self useTestDiscordServer.
"	

]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> loadDiscordSt [
	Metacello new
		baseline: #DiscordSt;
		repository: 'github://JurajKubelka/DiscordSt/src';
		load: #webhook
]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> runMe [
	<script: 'self new runMe'>
	UIManager default edit: '"Script of the day: XXXXXXX

https://github.com/ObjectProfile/Roassal3
https://twitter.com/Roassal1
"
| v nodes |
c := RSCanvas new.
nodes := Collection withAllSubclasses collect: [ :cls |
	RSBox new
		size: cls numberOfMethods;
		draggable;
		yourself ].
c addAll: nodes.
RSGridLayout on: nodes.
c open' label: 'Enter your Roassal3 script' accept: [ :aScript | self sendScript: aScript ]
]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> sendScript: aScript [
	| preamble message window morph |
	preamble := 'Here is a new script of the day for _Roassal3_: https://github.com/ObjectProfile/Roassal3'.
	preamble := preamble , String cr , 'Roassal3 is still in an early phase, so the API may evolve.' , String cr.
	message := preamble , String cr, '```Smalltalk' , String cr , aScript , String cr , '```'.
	window := OpalCompiler new
			source: aScript;
			evaluate.

	morph := window submorphs last.
	morph extent: window extent.
	morph canvas zoomToFit.
	DSWebhookClient new
		url: serverName;
		message: message;
		username: 'Roassal Script of the Day';
		avatarUrl: 'http://objectprofile.com/img/Roassal.png';
		fileName: 'scriptOfTheDay.png'
			morph: morph;
		send
]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> useRealDiscordServer [
	serverName := servers at: #real
]

{ #category : #'as yet unclassified' }
RSScriptOfTheDay >> useTestDiscordServer [
	serverName := servers at: #test
]

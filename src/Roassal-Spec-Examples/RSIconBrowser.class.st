"
Used to explore some icons of pharo echo system.
If you want an icon you can use

```st
self iconNamed: #pharo
```
But what icons are available? this class present them so you can use them in your projects
"
Class {
	#name : 'RSIconBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'canvas'
	],
	#category : 'Roassal-Spec-Examples-Menu',
	#package : 'Roassal-Spec-Examples',
	#tag : 'Menu'
}

{ #category : 'layout' }
RSIconBrowser class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #canvas;
		yourself
]

{ #category : 'initialization' }
RSIconBrowser >> connectPresenters [

	| c icons shapes |
	c := canvas canvas.
	icons := Smalltalk ui.
	icons := icons icons icons associations sorted: [ :a :b |
		         a key < b key ].

	shapes := icons collect: [ :icon |
		          RSBitmap new
			          form: icon value;
			          model: icon;
			          popupText: #key;
			          when: RSMouseClick do: [ :evt |
				          Clipboard clipboardText: evt shape model key.
				          self inform: 'Copied icon name' ]
			          for: self ].
	c addAll: shapes.
	RSRectanglePackLayout on: shapes.
	c @ RSCanvasController
]

{ #category : 'initialization' }
RSIconBrowser >> initializePresenters [
	canvas := self newRoassal
]

{ #category : 'TOREMOVE' }
RSIconBrowser >> title [
	^ 'Icons'
]

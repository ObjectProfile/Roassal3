Class {
	#name : 'SpRSTransitionInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'slider',
		'visualization',
		'animation',
		'step',
		'debug',
		'sliderMorph',
		'toggle',
		'toggleRestartLbl',
		'toggleRestartIcn',
		'togglePauseLbl',
		'togglePauseIcn'
	],
	#category : 'Roassal-Inspector-SP2',
	#package : 'Roassal-Inspector',
	#tag : 'SP2'
}

{ #category : 'accessing' }
SpRSTransitionInspectorPresenter >> animation: anAnimation [

	animation := anAnimation.

	sliderMorph := PluggableSliderMorph new
		               model: animation;
		               getValueSelector: #progress ;
		               setValueSelector: #stepWithNumber:;
		               value: animation progress;
		               max: 1;
		               min: 0;
		               quantum: 0.01;
		               setBalloonText: 'Move it';
		               vResizing: #spaceFill;
		               hResizing: #spaceFill;
		               yourself.

	animation canvas @ RSCanvasController.

	slider morph: sliderMorph.
	visualization morph: animation canvas createMorph
]

{ #category : 'controls' }
SpRSTransitionInspectorPresenter >> debugAnimationStep [

	| process session |
	process := [ animation step ] newProcess.
	session := (OupsDebugRequest newForContext: process suspendedContext)
		           process: process;
		           compiledMethod:
			           animation class >> #performStepActionWith:;
		           label: 'Debug animation';
		           submit;
		           debugSession.
	3 timesRepeat: [ session stepInto ]
]

{ #category : 'initialization' }
SpRSTransitionInspectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newVertical
				   add: slider withConstraints: [ :c |
					   c
						   height: 30;
						   expand: false ];
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: toggle;
				   add: step;
				   add: debug;
				   yourself) expand: false ;
		  add: visualization;
		  yourself
]

{ #category : 'controls' }
SpRSTransitionInspectorPresenter >> disableDebuggingControls [

	slider disable.
	step disable.
	debug disable
]

{ #category : 'controls' }
SpRSTransitionInspectorPresenter >> enableDebuggingControls [

	sliderMorph updateValue.
			slider enable.
			step enable.
			debug enable
]

{ #category : 'initialization' }
SpRSTransitionInspectorPresenter >> initializePresenters [

	togglePauseLbl := 'Pin and pause'.
	togglePauseIcn := #smallPushpin.

	toggleRestartLbl := 'Restart at previous pin'.
	toggleRestartIcn := #glamorousRestart.

	toggle := self newButton
		          label: togglePauseLbl;
		          iconName: togglePauseIcn;
		          action: [ self toggle ].
	step := self newButton
		        label: 'Next frame';
		        iconName: #glamorousRight;
		        action: [ self step ].
	debug := self newButton
		         label: 'Debug step action';
		         iconName: #glamorousBug;
		         action: [ self debugAnimationStep ].

	slider := SpMorphPresenter new.
	visualization := SpMorphPresenter new.

	self disableDebuggingControls
]

{ #category : 'stepping' }
SpRSTransitionInspectorPresenter >> step [

	|progress|
	progress := sliderMorph value + sliderMorph quantum.
	animation stepWithNumber: progress.
		sliderMorph value: progress
]

{ #category : 'controls' }
SpRSTransitionInspectorPresenter >> toggle [

	animation isPaused
		ifTrue: [
			toggle
				label: togglePauseLbl;
				iconName: togglePauseIcn.
			animation continue.
			self disableDebuggingControls. ]
		ifFalse: [
			toggle
				label: toggleRestartLbl;
				iconName: toggleRestartIcn.
			animation pause.
			self enableDebuggingControls ]
]

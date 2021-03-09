"
Inspired by Raven Kwok drawingMachine_10 (http://openprocessing.org/sketch/34320).
"
Class {
	#name : #RSForceExample,
	#superclass : #RSObject,
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #examples }
RSForceExample >> example01 [
	<script: 'self new example01 open'>
	| c |
	c := RSForceBuilder new.
	c build.
	^ c canvas
]

{ #category : #examples }
RSForceExample >> example02 [
	<script: 'self new example02 open'>
	| c |
	c := RSForceBuilder new.
	c particlesSize: 2000.
	c particlesRadius: 200.
	c interferencesSize: 200.
	c interferencesRadius: 100.
	c build.
	^ c canvas
]

{ #category : #examples }
RSForceExample >> example03 [
	<script: 'self new example03 open'>
	| c |
	c := RSForceBuilder new.
	c particlesSize: 2000.
	c particlesRadius: 50.
	c interferencesSize: 200.
	c interferencesRadius: 200.
	c build.
	^ c canvas
]

{ #category : #examples }
RSForceExample >> example04 [
	<script: 'self new example04 open'>
	| c |
	c := RSForceBuilder new.
	c particlesSize: 2000.
	c particlesRadius: 50.
	c interferencesSize: 200.
	c interferencesRadius: 200.
	c colorGenerator: RSColorPerlinGenerator new.
	c build.
	^ c canvas
]

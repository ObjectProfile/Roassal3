"
Basic examples about parametric XY lines.
"
Class {
	#name : #RSParametricLineExamples,
	#superclass : #RSAbstractExamples,
	#traits : 'RSTParametricXYLines',
	#classTraits : 'RSTParametricXYLines classTrait',
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #lines }
RSParametricLineExamples >> example45ParametricButterfly [

	<script: 'self new example45ParametricButterfly open'>
	^ RSCanvas new
		  add: self parametricXYlineButterfly;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricHypotrochoid [

	<script: 'self new example45ParametricHypotrochoid open'>
	^ RSCanvas new
		  add: self lineParametricHypotrochoid;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricLissajous [

	<script: 'self new example45ParametricLissajous open'>
	^ RSCanvas new
		  add: self lineParametricLissajous;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricNeil [

	<script: 'self new example45ParametricNeil open'>
	^ RSCanvas new
		  add: self lineParametricNeil;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricNeil2 [

	<script: 'self new example45ParametricNeil2 open'>
	^ RSCanvas new
		  add: self lineParametricNeil2;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricTrochoid [

	<script: 'self new example45ParametricTrochoid open'>
	^ RSCanvas new
		  add: self lineParametricTrochoid;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSParametricLineExamples >> example45ParametricUnitCircle [

	<script: 'self new example45ParametricUnitCircle open'>
	^ RSCanvas new
		  add: self lineParametricUnitCircle;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

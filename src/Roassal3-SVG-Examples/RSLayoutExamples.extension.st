Extension { #name : #RSLayoutExamples }

{ #category : #'*Roassal3-SVG-Examples' }
RSLayoutExamples >> example14ClassHierarchy [
	<script: 'self new example14ClassHierarchy open'>
	| c classes |
	c := RSCanvas new.

	classes := (Object withAllSubclasses first: 300)
		flatCollect: #withAllSuperclasses.
	classes := classes asSet 
		collect: [:cls | RSEllipse new draggable; popup; model: cls; yourself] 
		as: RSGroup.
	c addAll: classes.
	RSLineBuilder line
		color: Color gray;
		canvas: c;
		shapes: classes;
		connectFrom: #superclass.
	RSNormalizer size
		shapes: classes;
		to: 20;
		normalize: #numberOfMethods.
	RSNormalizer color
		shapes: classes;
		normalize: #numberOfMethods.
	RSClusterLayout on: classes.
	RSMultiBezierEdgeBuilder multiBezier
		borderColor: (Color blue alpha: 0.3);
		canvas: c;
		shapes: classes;
		withBorderAttachPoint;
		following: #superclass;
		connectToAll: #dependentClasses.
	c @ RSCanvasController.
	^ c
]

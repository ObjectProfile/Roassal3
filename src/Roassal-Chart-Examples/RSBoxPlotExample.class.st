"
Example plots making use of RSBoxPlot.
"
Class {
	#name : 'RSBoxPlotExample',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Chart-Examples',
	#package : 'Roassal-Chart-Examples'
}

{ #category : 'examples' }
RSBoxPlotExample >> example01 [
	"A simple boxplot"
	<script: 'self new example01 open'>
	| p y |

	y := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	p := RSBoxPlot new y: y.

	p horizontalTick numberOfTicks: y size.
	p xlabel: 'X Axis'.
	p verticalTick numberOfTicks: 10;
		asFloat.
	p ylabel: 'Y Axis'.
	p title: 'Box Plot'.
	^ p
]

{ #category : 'examples' }
RSBoxPlotExample >> example01new [
	"A simple boxplot"
	<script: 'self new example01new open'>
	| p y |
	y := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	p := RSBoxPlot new y: y.
	^ p
]

{ #category : 'examples' }
RSBoxPlotExample >> example02new [
	"This is a grouped boxplot, comparing different datasets with the same x axis"
	<script: 'self new example02new open'>
	|p p1 y1 |

	y1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }.
			{ 12. 12. 13. 14. 15. 24. } }.

	"y2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }.
			{ 12. 12. 13. 14. 15. 24. }  }.

	y3 := { { 1. 2. 3. 3. 3. 5. 3. 5. 5. 7. 8. 5. 6. 10. 11. } .
			 { 12. 7. 10. 11. 11. 13. 10. 11. 12. 11. 15. 16. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. 25. 24. 25. 26. 24. 23. 23. 25. 25. }.
			{ 12. 12. 13. 14. 15. 24. }  }."

	p1 := RSBoxPlot data: y1.
	"p2 := RSBoxPlot data: y2.
	p3 := RSBoxPlot data: y3."
	p := p1." + p2 + p3."
	^ p
]

{ #category : 'examples' }
RSBoxPlotExample >> example03 [
	"A simple boxplot"
	<script: 'self new example03 open'>
	| p y |
	y := { 1. 2. 3. 4. 5. } .
	p := RSBoxPlot new y: y.
	^ p
]

"
Baseline for https://github.com/ObjectProfile/Roassal3
"
Class {
	#name : #BaselineOfRoassal3,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassal3
}

{ #category : #baselines }
BaselineOfRoassal3 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ | core examples tests |
			"our dependencies"
			"https://github.com/ObjectProfile/Roassal3"
			spec baseline: 'AthensSVG' with: [
				spec repository: 'github://pharo-contributions/Athens-SVG/src' ].
			spec package: 'Athens-SVG-PathConverter' with: [
				spec repository: 'github://pharo-contributions/Athens-SVG/src' ].
			spec baseline: 'Geometry' with: [ 
				spec repository: 'github://pharo-contributions/Geometry/src' ].
			spec baseline: 'NumericScales'with: [ 
				spec repository: 'github://ObjectProfile/NumericScales/src' ].
			spec 
				baseline: 'OSSubprocess'
				with: [ spec repository: 'github://pharo-contributions/OSSubprocess/repository' ].
				
			"The packages to use, but not load"
			
			self
				roassalCorePackagesIn: spec;
				roassalExamplesIn: spec;
				roassalTestsIn: spec;
				roassalSVGIn: spec.
				
			spec package: #'Roassal3-GraphViz' with: [ spec requires: #('OSSubprocess') ].
			spec package: #'Roassal3-Mondrian'.
			
			
			"packages to load"
			core := self corePackagesNames.
			examples := self examplePackagesNames.
			tests := self testPackagesNames.
				
			Smalltalk globals at: #SpPresenter ifPresent: [
				core add: 'Roassal3-Spec'.
				examples add: 'Roassal3-Spec-Examples'.
				tests add: 'Roassal3-Spec-Tests'.
			] ifAbsent: [ "pharo7"
				core add: 'Roassal3-Pharo7' ].
			spec 
				group: 'Core' with: core asArray;
				group: 'Examples'  with: examples asArray;
				group: 'Tests' with: tests asArray;
				group: 'SVG' with: #('Core' 'Roassal3-SVG');
				group: 'SVGTests' with: #('SVG' 'Tests' 'Roassal3-SVG-Tests');
				group: 'SVGExamples' with: #('SVG' 'Examples' 'Roassal3-SVG-Examples');
				group: 'SVGImporter' with: #('SVG' 'SVGExamples' 'SVGTests' 'Roassal3-SVG-Importer');
				group: 'GraphViz' with: #(Core SVG 'Roassal3-GraphViz');
				group: 'default' with: #('Core' 'Tests' 'Examples' 'SVG' 'SVGTests' 'SVGExamples' 'Roassal3-Mondrian') ].

		
	







]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> corePackagesNames [
	^ #(
	'Roassal3'
	'Roassal3-Builders'
	'Roassal3-Shapes'
	'Roassal3-Interaction'
	'Roassal3-Layouts'
	'Roassal3-Colors'
	'Roassal3-Legend'
	'Roassal3-Animation'
	'Roassal3-UML'
	'Roassal3-Sunburst'
	'Roassal3-Pie'
	'Roassal3-Inspector'
	'Roassal3-Chart'
	'Roassal3-Menu') asOrderedCollection
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> examplePackagesNames [
	^ #(
	'Core' 
	'Roassal3-Examples'
	'Roassal3-Legend-Examples'
	'Roassal3-Chart-Examples'
	'Roassal3-Pie-Examples'
	'Roassal3-Sunburst-Examples'
	'Roassal3-UML-Examples') asOrderedCollection
]

{ #category : #'package management' }
BaselineOfRoassal3 >> roassalCorePackagesIn: spec [
	spec
		package: #'Roassal3' with: [ spec requires: #('Geometry' 'NumericScales') ];
		package: #'Roassal3-Pharo7';
		package: #'Roassal3-Builders';
		package: #'Roassal3-Shapes';
		package: #'Roassal3-Animation';
		package: #'Roassal3-Chart';
		package: #'Roassal3-Interaction';
		package: #'Roassal3-Legend';
		package: #'Roassal3-Pie';
		package: #'Roassal3-UML';
		package: #'Roassal3-Layouts';
		package: #'Roassal3-Colors';
		package: #'Roassal3-Sunburst';
		package: #'Roassal3-Inspector';
		package: #'Roassal3-Menu';
		package: #'Roassal3-Spec'.
]

{ #category : #'package management' }
BaselineOfRoassal3 >> roassalExamplesIn: spec [
	spec
		package: #'Roassal3-Examples';
		package: #'Roassal3-Legend-Examples';
		package: #'Roassal3-Chart-Examples';
		package: #'Roassal3-Pie-Examples';
		package: #'Roassal3-Spec-Examples';
		package: #'Roassal3-Sunburst-Examples';
		package: #'Roassal3-UML-Examples'.

]

{ #category : #'package management' }
BaselineOfRoassal3 >> roassalSVGIn: spec [
	spec		
		package: 'Roassal3-SVG' with: [ spec requires: #('Athens-SVG-PathConverter') ];
		package: 'Roassal3-SVG-Tests';
		package: 'Roassal3-SVG-Examples';
		package: 'Roassal3-SVG-Importer' with: [ spec requires: #('AthensSVG') ].
]

{ #category : #'package management' }
BaselineOfRoassal3 >> roassalTestsIn: spec [.	
	spec
		package: #'Roassal3-Global-Tests';
		package: #'Roassal3-Animation-Tests';
		package: 'Roassal3-Shapes-Tests';
		package: 'Roassal3-Interaction-Tests';
		package: 'Roassal3-Layouts-Tests';
		package: 'Roassal3-Chart-Tests';
		package: 'Roassal3-Spec-Tests';
		package: 'Roassal3-UML-Tests'.
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> testPackagesNames [
	^ #(
	'Core' 
	'Roassal3-Global-Tests' 
	'Roassal3-Animation-Tests'
	'Roassal3-Shapes-Tests'
	'Roassal3-Interaction-Tests'
	'Roassal3-Layouts-Tests'
	'Roassal3-Chart-Tests'
	'Roassal3-UML-Tests') asOrderedCollection
]

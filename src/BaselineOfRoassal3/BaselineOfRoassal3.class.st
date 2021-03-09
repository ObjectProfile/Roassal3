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
	"https://github.com/ObjectProfile/Roassal3"
	"pharo7 not supported"
	spec for: #'pharo8.x' do: [ self baselineForPharo8: spec ].
	spec for: #'pharo9.x' do: [ self baselineForPharo9: spec ].
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForCommon: spec [
	"https://github.com/ObjectProfile/Roassal3"
	self dependencies: spec.
	self registerPackages: spec.
	self roassalGroups: spec 
		core: self corePackagesNames
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo8: spec [
	self baselineForCommon: spec
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo9: spec [
	self baselineForCommon: spec
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> corePackagesNames [
	^ #(
	'Roassal3-Builders'
	'Roassal3-Shapes'
	'Roassal3-Animation'
	'Roassal3-Interaction'
	'Roassal3-Layouts'
	'Roassal3-Colors'
	'Roassal3-Legend'
	'Roassal3-UML'
	'Roassal3-Sunburst'
	'Roassal3-Pie'
	'Roassal3-Inspector'
	'Roassal3-Chart'
	'Roassal3-Menu'
	'Roassal3-Spec')
]

{ #category : #baselines }
BaselineOfRoassal3 >> dependencies: spec [.
	spec baseline: 'AthensSVG' with: [
		spec repository: 'github://pharo-contributions/Athens-SVG/src' ].
	spec package: 'Athens-SVG-PathConverter' with: [
		spec repository: 'github://pharo-contributions/Athens-SVG/src' ].
	spec baseline: 'Geometry' with: [ 
		spec repository: 'github://pharo-contributions/Geometry/src' ].
	spec baseline: 'NumericScales'with: [ 
		spec repository: 'github://ObjectProfile/NumericScales:v1.0/src' ].
	spec 
		baseline: 'OSSubprocess'
		with: [ spec repository: 'github://pharo-contributions/OSSubprocess/repository' ].
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> examplePackagesNames [
	^ #(
	'Roassal3-Examples'
	'Roassal3-Legend-Examples'
	'Roassal3-Chart-Examples'
	'Roassal3-Pie-Examples'
	'Roassal3-Sunburst-Examples'
	'Roassal3-UML-Examples'
	'Roassal3-Spec-Examples')
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> extraPackagesNames [
	^ #(
	'Roassal3-Mondrian'
	'Roassal3-Experimental')
]

{ #category : #baselines }
BaselineOfRoassal3 >> registerPackages: spec [
	"The packages to use, but not load"
	spec package: #'Roassal3' with: [ spec requires: #('Geometry' 'NumericScales') ].
	self corePackagesNames, 
	self examplePackagesNames, 
	self testPackagesNames, 
	self extraPackagesNames do: [ :name | spec package: name ].
	
	spec		
		package: #'Roassal3-SVG' with: [ spec requires: #('Athens-SVG-PathConverter') ];
		package: #'Roassal3-SVG-Tests';
		package: #'Roassal3-SVG-Examples';
		package: #'Roassal3-SVG-Importer' with: [ spec requires: #('AthensSVG') ].
		
	spec package: #'Roassal3-GraphViz' with: [ spec requires: #('OSSubprocess') ].
	









]

{ #category : #baselines }
BaselineOfRoassal3 >> roassalGroups: spec core: arr1 examples: arr2 tests: arr3 [
	| core |
	core := #('Core').
	spec 
		group: 'Core' with: #('Roassal3'), arr1;
		group: 'Examples' with: core, arr2;
		group: 'Tests' with: core, arr3;
		group: 'SVG' with: #('Core' 'Roassal3-SVG');
		group: 'SVGTests' with: #('SVG' 'Tests' 'Roassal3-SVG-Tests');
		group: 'SVGExamples' with: #('SVG' 'Examples' 'Roassal3-SVG-Examples');
		group: 'SVGImporter' with: #('SVG' 'SVGExamples' 'SVGTests' 'Roassal3-SVG-Importer');
		group: 'GraphViz' with: #('SVG' 'Roassal3-GraphViz');
		
		group: 'Mini' with: #('SVGTests' 'SVGExamples');
		group: 'Full' with: #('Mini'), self extraPackagesNames;
		group: 'default' with: #('Core' 'Mini')










]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> testPackagesNames [
	^ #(
	'Roassal3-Global-Tests' 
	'Roassal3-Animation-Tests'
	'Roassal3-Shapes-Tests'
	'Roassal3-Interaction-Tests'
	'Roassal3-Layouts-Tests'
	'Roassal3-Chart-Tests'
	'Roassal3-UML-Tests'
	'Roassal3-Spec-Tests'
	'Roassal3-Inspector-Tests')
]

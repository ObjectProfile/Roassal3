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
	spec for: #'pharo10.x' do: [ self baselineForPharo10: spec ].
	spec for: #'pharo11.x' do: [ self baselineForPharo11: spec ].
	spec for: #'common' do: [ self baselineForCommon: spec ].
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForCommon: spec [
	self dependencies: spec.
	self registerPackages: spec.
	self roassalGroups: spec 
		core: self corePackagesNames
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo10: spec [
	self dependencies: spec.
	self registerPackages: spec.
	spec package: #'Roassal3-Pharo'.
	spec package: #'Roassal3-Pharo10'.
	self roassalGroups: spec 
		core: self corePackagesNames, #('Roassal3-Pharo' 'Roassal3-Pharo10')
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo11: spec [
	self dependencies: spec.
	self registerPackages: spec.
	spec package: #'Roassal3-Pharo'.
	self roassalGroups: spec 
		core: self corePackagesNames, #('Roassal3-Pharo')
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo8: spec [
	self dependencies: spec.
	self registerPackages: spec.
	spec package: #'Roassal3-Pharo8'.
	spec package: #'Roassal3-Spec-Obsolete'.
	spec package: #'Roassal3-Pharo'.
	self roassalGroups: spec 
		core: self corePackagesNames, #('Roassal3-Pharo8' 'Roassal3-Spec-Obsolete' 'Roassal3-Pharo')
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #baselines }
BaselineOfRoassal3 >> baselineForPharo9: spec [
	self dependencies: spec.
	self registerPackages: spec.
	spec package: #'Roassal3-Pharo9'.
	spec package: #'Roassal3-Pharo'.
	self roassalGroups: spec 
		core: self corePackagesNames, #('Roassal3-Pharo9' 'Roassal3-Pharo')
		examples: self examplePackagesNames
		tests: self testPackagesNames.
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> corePackagesNames [
	^ #(
	'Roassal3-Event'
	'Roassal3-Builders'
	'Roassal3-Shapes'
	'Roassal3-Animation'
	'Roassal3-Interaction'
	'Roassal3-Layouts-Util'
	'Roassal3-Layouts'
	'Roassal3-Colors'
	'Roassal3-Legend'
	'Roassal3-UML'
	'Roassal3-Sunburst'
	'Roassal3-FlameGraph'
	'Roassal3-Pie'
	'Roassal3-Inspector'
	'Roassal3-Chart'
	'Roassal3-DSM'
	'Roassal3-Menu'
	'Roassal3-Spec'
	'Roassal3-Spec-Morphic'
	'Roassal3-BaselineMap'
	'Roassal3-SVG'
	)
]

{ #category : #dependencies }
BaselineOfRoassal3 >> dependencies: spec [
	spec baseline: 'Bloc' with: [
		spec repository: 'github://pharo-graphics/Bloc:dev-1.0/src' ].

	spec baseline: 'AthensSVG' with: [
		spec repository: 'github://pharo-contributions/Athens-SVG/src' ].
	spec package: 'Athens-SVG-PathConverter' with: [
		spec repository: 'github://pharo-contributions/Athens-SVG/src'].
	spec baseline: 'Geometry' with: [ 
		spec repository: 'github://pharo-contributions/Geometry/src' ].
	spec baseline: 'NumericScales'with: [ 
		spec repository: 'github://ObjectProfile/NumericScales:v1.01/src' ].
	spec 
		baseline: 'OSSubprocess'
		with: [ spec repository: 'github://pharo-contributions/OSSubprocess/repository' ].
	spec 
		baseline: 'DataFrame'
		with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> examplePackagesNames [
	^ #(
	'Roassal3-Examples'
	'Roassal3-Legend-Examples'
	'Roassal3-Chart-Examples'
	'Roassal3-Pie-Examples'
	'Roassal3-Sunburst-Examples'
	'Roassal3-FlameGraph-Examples'
	'Roassal3-UML-Examples'
	'Roassal3-Spec-Examples')
]

{ #category : #'API-packages' }
BaselineOfRoassal3 >> extraPackagesNames [
	^ #(
	'Roassal3-Mondrian'
	'Roassal3-Experimental'
	'Roassal3-LayoutStudio'
	'Roassal3-LayoutStudio-Tests')
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
		package: #'Roassal3-Bloc' with: [ spec requires: #('Bloc') ];

		package: #'Roassal3-SVG' with: [ spec requires: #('Athens-SVG-PathConverter') ];
		package: #'Roassal3-SVG-Tests';
		package: #'Roassal3-SVG-Examples';
		package: #'Roassal3-SVG-Importer' with: [ spec requires: #('AthensSVG') ].
		
	spec package: #'Roassal3-GraphViz' with: [ spec requires: #('OSSubprocess') ].
	
	spec package: #'Roassal3-Gtk'.
	spec package: #'Roassal3-Spec-Gtk'.

	spec package: #'Roassal3-Chart-DataFrame' with: [ spec requires: #('DataFrame') ].






]

{ #category : #baselines }
BaselineOfRoassal3 >> roassalGroups: spec core: arr1 examples: arr2 tests: arr3 [
	| core |
	core := #('Core').
	spec
		group: 'Core' with: #('Roassal3'), arr1;
		group: 'Examples' with: core, arr2;
		group: 'Tests' with: core, arr3;
		group: 'SVGExamples' with: #('Examples' 'Roassal3-SVG-Examples');
		group: 'SVGImporter' with: #('SVGExamples' 'Roassal3-SVG-Importer');
		group: 'Gtk' with: #('Roassal3-Gtk' 'Roassal3-Spec-Gtk');

		group: 'Mini' with: #('Tests' 'SVGExamples');
		group: 'Full' with: #('Mini'), self extraPackagesNames;
		group: 'GraphViz' with: #('Full' 'Roassal3-GraphViz');
		group: 'BlocFull' with: #('Full' 'Roassal3-Bloc');
		group: 'default' with: #('Mini');
		group: 'Full-DataFrame' with: #('Full' 'Roassal3-Chart-DataFrame')
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
	'Roassal3-Inspector-Tests'
	'Roassal3-BaselineMap-Tests'
	'Roassal3-SVG-Tests'
	)
]

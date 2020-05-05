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
		do: [ | core examples tests svg svgTests svgExamples |
			"our dependencies"
			"https://github.com/ObjectProfile/Roassal3"
			spec package: 'Athens-SVG' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec package: 'Geometry' with: [ 
				spec repository: 'github://TelescopeSt/Geometry:v1.1.0/src' ].
			spec baseline: 'NumericScales'with: [ 
				spec repository: 'github://ObjectProfile/NumericScales' ].
			
			"The packages to use, but not load"
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
				package: #'Roassal3-Spec';
				package: #'Roassal3-Sunburst';
				package: #'Roassal3-Inspector';
				package: #'Roassal3-Menu';
				
				package: #'Roassal3-Examples';
				package: #'Roassal3-Legend-Examples';
				package: #'Roassal3-Chart-Examples';
				package: #'Roassal3-Pie-Examples';
				package: #'Roassal3-Spec-Examples';
				package: #'Roassal3-Sunburst-Examples';
				package: #'Roassal3-UML-Examples';
				
				package: #'Roassal3-Global-Tests';
				package: #'Roassal3-Animation-Tests';
				package: 'Roassal3-Shapes-Tests';
				package: 'Roassal3-Interaction-Tests';
				package: 'Roassal3-Layouts-Tests';
				package: 'Roassal3-Chart-Tests';
				package: 'Roassal3-Spec-Tests';
				package: 'Roassal3-UML-Tests';
				
				package: 'Roassal3-SVG' with: [ spec requires: #('Athens-SVG') ];
				package: 'Roassal3-SVG-Tests' with: [ spec requires: #('Roassal3-SVG' 'Roassal3-Shapes-Tests') ];
				package: 'Roassal3-SVG-Examples' with: [ spec requires: #('Roassal3-SVG' 'Roassal3-Examples') ].

			"packages to load"
			core := #(
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
				'Roassal3-Menu') asOrderedCollection.
			examples := #(
				'Core' 
				'Roassal3-Examples'
				'Roassal3-Legend-Examples'
				'Roassal3-Chart-Examples'
				'Roassal3-Pie-Examples'
				'Roassal3-Sunburst-Examples'
				'Roassal3-UML-Examples') asOrderedCollection.
			tests := #(
				'Core' 
				'Roassal3-Global-Tests' 
				'Roassal3-Animation-Tests'
				'Roassal3-Shapes-Tests'
				'Roassal3-Interaction-Tests'
				'Roassal3-Layouts-Tests'
				'Roassal3-Chart-Tests'
				'Roassal3-UML-Tests') asOrderedCollection.
			svg := #(
				'Core' 
				'Roassal3-SVG') asOrderedCollection.
			svgTests := #(
				'Core' 
				'SVG' 
				'Tests'
				'Roassal3-SVG-Tests') asOrderedCollection.
			svgExamples := #(
				'Core' 
				'SVG' 
				'Examples'
				'Roassal3-SVG-Examples') asOrderedCollection.
				
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
				group: 'SVG' with: svg asArray;
				group: 'SVGTests' with: svgTests asArray;
				group: 'SVGExamples' with: svgExamples asArray;
				group: 'default' with: #('Core' 'Tests' 'Examples' 'SVG' 'SVGTests' 'SVGExamples') ].

		
	







]

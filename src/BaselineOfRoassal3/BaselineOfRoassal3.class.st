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
		do: [ | dep1 dep2  |
			spec package: 'Athens-SVG' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec package: 'Geometry' with: [ 
				spec repository: 'github://TelescopeSt/Geometry:v1.1.0/src' ].
			spec
				baseline: 'NumericScales'
				with: [ spec repository: 'github://ObjectProfile/NumericScales/src' ].
			(AthensCairoCanvas canUnderstand: #fillRuleEvenOdd) ifTrue: [
				dep1 := #('Athens-SVG').
				dep2 := #('Roassal3-Spec').
			] ifFalse: [
				dep1 := #('Athens-SVG' 'Roassal3-Pharo7').
				dep2 := #() ].
			
			spec
				package: #'NumericScales';
				package: #'Roassal3-Pharo7';
				package: #'Roassal3-Trachel' with: [ spec requires: dep1 ];
				package: #'Roassal3-Animation' with: [ spec requires: #(NumericScales) ];
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3' with: [spec requires: #('Geometry')];
				package: #'Roassal3-Interaction';
				package: #'Roassal3-Utils';
				package: #'Roassal3-Legend';
				package: #'Roassal3-Pie';
				package: #'Roassal3-UML';
				package: #'Roassal3-Layouts';
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3-Colors';
				package: #'Roassal3-Spec';
				package: #'Roassal3-Inspector' with: [spec requires: dep2 ];
				package: #'Roassal3-Examples';
				package: #'Roassal3-Tests';
				package: #'Roassal3-Menu'.
				
			spec 
				group: 'Core' with: #(
					'Roassal3'
					'Roassal3-Interaction'
					'Roassal3-Layouts'
					'Roassal3-Utils'
					'Roassal3-Colors'
					'Roassal3-Legend'
					'Roassal3-Trachel'
					'Roassal3-Trachel-Shapes'
					'Roassal3-Animation'
					'Roassal3-UML'
					'Roassal3-Pie'
					'Roassal3-Inspector'
					'Roassal3-Menu');
				group: 'Examples'  with: #('Core' 'Roassal3-Examples');
				group: 'Tests' with: #('Core' 'Roassal3-Tests');
				group: 'default' with: #('Core' 'Tests' 'Examples') ].

		
	







]

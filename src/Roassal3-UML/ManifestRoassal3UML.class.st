"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestRoassal3UML,
	#superclass : #PackageManifest,
	#category : #'Roassal3-UML-Manifest'
}

{ #category : #'code-critics' }
ManifestRoassal3UML class >> ruleEndTrueFalseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#RSUMLSequenceDescriptor #cumulateWidths #false)) #'2021-12-20T16:40:22.07811+01:00') )
]

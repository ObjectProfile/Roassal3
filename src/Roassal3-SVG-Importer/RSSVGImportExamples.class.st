"
I have svg import examples
"
Class {
	#name : #RSSVGImportExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-SVG-Importer'
}

{ #category : #examples }
RSSVGImportExamples >> example01SVGImport [
	<script: 'self new example01SVGImport inspect'>
	| canvas svg |
	canvas := RSCanvas new.
	svg := RSSVGImporter fromString: self roassalSVG.
	canvas add: svg.
	canvas @ RSCanvasController.
	^ canvas 
]

{ #category : #'data - svg' }
RSSVGImportExamples >> roassalSVG [
	^ '<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 23.0.4, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 298.7 300" style="enable-background:new 0 0 298.7 300;" xml:space="preserve">
<style type="text/css">
	.st0{fill:none;stroke:#B51920;stroke-width:35;stroke-miterlimit:10;}
	.st1{fill:#333333;}
	.st2{fill:none;stroke:#25B4AF;stroke-width:21.0003;stroke-miterlimit:10;}
	.st3{fill:#E83A54;}
</style>
<g>
	<path class="st2" d="M77,24.4v243.9 M264.2,232.3c0,0-24.1,30-51.7,30C144.3,262.3,174,113,77,113c-18.5,0-37.6,12.6-37.6,30
		c0,16,11.8,28,38.3,28s115.7-10.7,115.7-77.1c0-53.9-45.7-69.5-116.5-69.5c-11.8,0-21.8,1.4-30.1,3.4c-4.6,1.1-8.7,2.4-12.3,3.8"/>
	<circle class="st3" cx="264.2" cy="232.3" r="20.4"/>
	<circle class="st3" cx="143.6" cy="158.1" r="20.4"/>
	<circle class="st3" cx="77" cy="268.4" r="20.4"/>
	<circle class="st3" cx="34.6" cy="31.6" r="20.4"/>
</g>
</svg>
'
]

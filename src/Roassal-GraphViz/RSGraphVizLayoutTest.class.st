Class {
	#name : #RSGraphVizLayoutTest,
	#superclass : #RSTest,
	#category : #'Roassal3-GraphViz-Tests'
}

{ #category : #tests }
RSGraphVizLayoutTest >> testBasic [

	| m layout |
	m := RSMondrian new.
	"m shape box size: 30."
	m shape box size: 30; "width: 30; height: 20;" labeled .
	m nodes: 'abcde'.
	m graphvizLine
		arrowMarkerEnd;
		useAssociations: { $a -> $b . $b -> $c . $a -> $c . $d -> $c . $e -> $c . $e -> $a }.
	layout := m layout graphviz digraph.
	m build.
	self assert: (layout graphvizResult asString copyWithoutAll: String crlf) equals: ('graph 1 2.6528 3.3071
node 1 1.9028 2.1294 0.75 0.45176 a solid ellipse black lightgrey
node 2 1.375 1.1776 0.75 0.45176 b solid ellipse black lightgrey
node 3 1.75 0.22588 0.75 0.45176 c solid ellipse black lightgrey
node 4 0.375 1.1776 0.75 0.45176 d solid ellipse black lightgrey
node 5 2.2778 3.0812 0.75 0.45176 e solid ellipse black lightgrey
edge 1 2 4 1.7856 1.9105 1.7201 1.7956 1.6367 1.6497 1.5623 1.5194 solid black
edge 1 3 7 1.9073 1.9004 1.9099 1.6664 1.9077 1.2816 1.875 0.95176 1.8632 0.83234 1.8427 0.70279 1.8218 0.58734 solid black
edge 2 3 4 1.4601 0.95409 1.5052 0.84304 1.5616 0.70393 1.6127 0.57805 solid black
edge 4 3 4 0.61451 1.0028 0.82811 0.85927 1.1439 0.64706 1.3883 0.48285 solid black
edge 5 1 4 2.1927 2.8576 2.1476 2.7466 2.0912 2.6075 2.0401 2.4816 solid black
edge 5 3 7 2.3352 2.856 2.3908 2.622 2.459 2.2341 2.4028 1.9035 2.3204 1.4191 2.0901 0.89726 1.9264 0.56974 solid black
stop
' copyWithoutAll: String crlf)
]

{ #category : #tests }
RSGraphVizLayoutTest >> testBasic2 [

	| m layout |
	m := RSMondrian new.
	m shape box size: 20; labeled.
	m nodes: 'abcd'.
	m graphvizLine
		arrowMarkerEnd;
		useAssociations: { $a -> $b . $b -> $c . $c -> $d . $d -> $a }.
	layout := m layout graphviz sfdp.
	m build.

	self assert: (layout dotDescription copyWithoutAll: String crlf) equals: ('graph G {
ratio = auto ;
layout = "sfdp" ;
1 [label="a", height=0.2];
2 [label="b", height=0.2];
3 [label="c", height=0.2];
4 [label="d", height=0.2];
"4" --"1";
"1" --"2";
"2" --"3";
"3" --"4"}' copyWithoutAll: String crlf).

	self assert: (layout graphvizResult asString includesSubstring: 'node')
]

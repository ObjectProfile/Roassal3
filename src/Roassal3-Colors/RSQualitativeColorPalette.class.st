"
Qualitative schemes do not imply magnitude differences between legend classes, and hues are used to create the primary visual differences between classes. Qualitative schemes are best suited to representing nominal or categorical data.

More info: 
http://colorbrewer2.org/learnmore/schemes_full.html#qualitative

---Copyright:
All colors, palettes and schemes are from www.ColorBrewer.org by Cynthia A. Brewer, Geography, Pennsylvania State University.
Code by Cynthia is under the Apache License 2.0 (https://github.com/axismaps/colorbrewer/blob/master/LICENCE.txt)
Roassal3 is distributed under the MIT License, which is compatible with Apache License 2.0 

FalutUI1 color scheme come from: http://flatuicolors.com/
"
Class {
	#name : #RSQualitativeColorPalette,
	#superclass : #RSColorPalette,
	#category : #'Roassal3-Colors'
}

{ #category : #accessing }
RSQualitativeColorPalette class >> paletteName [
	^ #qualitative
]

{ #category : #palette }
RSQualitativeColorPalette >> accent3 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134))
]

{ #category : #palette }
RSQualitativeColorPalette >> accent4 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134) #(255 255 153))
]

{ #category : #palette }
RSQualitativeColorPalette >> accent5 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134) #(255 255 153) #(56 108 176))
]

{ #category : #palette }
RSQualitativeColorPalette >> accent6 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134) #(255 255 153) #(56 108 176) #(240 2 127))
]

{ #category : #palette }
RSQualitativeColorPalette >> accent7 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134) #(255 255 153) #(56 108 176) #(240 2 127) #(191 91 23))
]

{ #category : #palette }
RSQualitativeColorPalette >> accent8 [
	^ self fromTriplet: #(#(127 201 127) #(190 174 212) #(253 192 134) #(255 255 153) #(56 108 176) #(240 2 127) #(191 91 23) #(102 102 102))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark23 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark24 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179) #(231 41 138))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark25 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179) #(231 41 138) #(102 166 30))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark26 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179) #(231 41 138) #(102 166 30) #(230 171 2))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark27 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179) #(231 41 138) #(102 166 30) #(230 171 2) #(166 118 29))
]

{ #category : #palette }
RSQualitativeColorPalette >> dark28 [
	^ self fromTriplet: #(#(27 158 119) #(217 95 2) #(117 112 179) #(231 41 138) #(102 166 30) #(230 171 2) #(166 118 29) #(102 102 102))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui110 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui111 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui112 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui113 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui114 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui115 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui116 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166) #(243 156 18))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui117 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166) #(243 156 18) #(211 84 0))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui118 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166) #(243 156 18) #(211 84 0) #(192 57 43))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui119 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166) #(243 156 18) #(211 84 0) #(192 57 43) #(189 195 199))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui120 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173) #(44 62 80) #(241 196 15) #(230 126 34) #(231 76 60) #(236 240 241) #(149 165 166) #(243 156 18) #(211 84 0) #(192 57 43) #(189 195 199) #(127 140 141))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui13 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui14 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui15 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui16 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui17 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui18 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185))
]

{ #category : #palette }
RSQualitativeColorPalette >> flatui19 [
	^ self fromTriplet: #(#(26 188 156) #(46 204 113) #(52 152 219) #(155 89 182) #(52 73 94) #(22 160 133) #(39 174 96) #(41 128 185) #(142 68 173))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired10 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111) #(255 127 0) #(202 178 214) #(106 61 154))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired11 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111) #(255 127 0) #(202 178 214) #(106 61 154) #(255 255 153))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired12 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111) #(255 127 0) #(202 178 214) #(106 61 154) #(255 255 153) #(177 89 40))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired3 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired4 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired5 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired6 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired7 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired8 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111) #(255 127 0))
]

{ #category : #palette }
RSQualitativeColorPalette >> paired9 [
	^ self fromTriplet: #(#(166 206 227) #(31 120 180) #(178 223 138) #(51 160 44) #(251 154 153) #(227 26 28) #(253 191 111) #(255 127 0) #(202 178 214))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel13 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel14 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel15 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228) #(254 217 166))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel16 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228) #(254 217 166) #(255 255 204))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel17 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228) #(254 217 166) #(255 255 204) #(229 216 189))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel18 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228) #(254 217 166) #(255 255 204) #(229 216 189) #(253 218 236))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel19 [
	^ self fromTriplet: #(#(251 180 174) #(179 205 227) #(204 235 197) #(222 203 228) #(254 217 166) #(255 255 204) #(229 216 189) #(253 218 236) #(242 242 242))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel23 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel24 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232) #(244 202 228))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel25 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232) #(244 202 228) #(230 245 201))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel26 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232) #(244 202 228) #(230 245 201) #(255 242 174))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel27 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232) #(244 202 228) #(230 245 201) #(255 242 174) #(241 226 204))
]

{ #category : #palette }
RSQualitativeColorPalette >> pastel28 [
	^ self fromTriplet: #(#(179 226 205) #(253 205 172) #(203 213 232) #(244 202 228) #(230 245 201) #(255 242 174) #(241 226 204) #(204 204 204))
]

{ #category : #palette }
RSQualitativeColorPalette >> set13 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74))
]

{ #category : #palette }
RSQualitativeColorPalette >> set14 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163))
]

{ #category : #palette }
RSQualitativeColorPalette >> set15 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163) #(255 127 0))
]

{ #category : #palette }
RSQualitativeColorPalette >> set16 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163) #(255 127 0) #(255 255 51))
]

{ #category : #palette }
RSQualitativeColorPalette >> set17 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163) #(255 127 0) #(255 255 51) #(166 86 40))
]

{ #category : #palette }
RSQualitativeColorPalette >> set18 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163) #(255 127 0) #(255 255 51) #(166 86 40) #(247 129 191))
]

{ #category : #palette }
RSQualitativeColorPalette >> set19 [
	^ self fromTriplet: #(#(228 26 28) #(55 126 184) #(77 175 74) #(152 78 163) #(255 127 0) #(255 255 51) #(166 86 40) #(247 129 191) #(153 153 153))
]

{ #category : #palette }
RSQualitativeColorPalette >> set23 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203))
]

{ #category : #palette }
RSQualitativeColorPalette >> set24 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203) #(231 138 195))
]

{ #category : #palette }
RSQualitativeColorPalette >> set25 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203) #(231 138 195) #(166 216 84))
]

{ #category : #palette }
RSQualitativeColorPalette >> set26 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203) #(231 138 195) #(166 216 84) #(255 217 47))
]

{ #category : #palette }
RSQualitativeColorPalette >> set27 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203) #(231 138 195) #(166 216 84) #(255 217 47) #(229 196 148))
]

{ #category : #palette }
RSQualitativeColorPalette >> set28 [
	^ self fromTriplet: #(#(102 194 165) #(252 141 98) #(141 160 203) #(231 138 195) #(166 216 84) #(255 217 47) #(229 196 148) #(179 179 179))
]

{ #category : #palette }
RSQualitativeColorPalette >> set310 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105) #(252 205 229) #(217 217 217) #(188 128 189))
]

{ #category : #palette }
RSQualitativeColorPalette >> set311 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105) #(252 205 229) #(217 217 217) #(188 128 189) #(204 235 197))
]

{ #category : #palette }
RSQualitativeColorPalette >> set312 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105) #(252 205 229) #(217 217 217) #(188 128 189) #(204 235 197) #(255 237 111))
]

{ #category : #palette }
RSQualitativeColorPalette >> set33 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218))
]

{ #category : #palette }
RSQualitativeColorPalette >> set34 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114))
]

{ #category : #palette }
RSQualitativeColorPalette >> set35 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211))
]

{ #category : #palette }
RSQualitativeColorPalette >> set36 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98))
]

{ #category : #palette }
RSQualitativeColorPalette >> set37 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105))
]

{ #category : #palette }
RSQualitativeColorPalette >> set38 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105) #(252 205 229))
]

{ #category : #palette }
RSQualitativeColorPalette >> set39 [
	^ self fromTriplet: #(#(141 211 199) #(255 255 179) #(190 186 218) #(251 128 114) #(128 177 211) #(253 180 98) #(179 222 105) #(252 205 229) #(217 217 217))
]

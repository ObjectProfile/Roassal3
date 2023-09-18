"
I am a fairly conventional 3d matrix. I can transform 3d points and perform a variety of manipulations on the transform
"
Class {
	#name : #RSMatrix3D,
	#superclass : #Object,
	#instVars : [
		'xx',
		'xy',
		'xz',
		'x0',
		'yx',
		'yy',
		'yz',
		'y0',
		'zx',
		'zy',
		'zz',
		'z0'
	],
	#category : #'Roassal3-Basic3D-Core'
}

{ #category : #inspector }
RSMatrix3D >> gtInspertorMatrix: composite [
	<gtInspectorPresentationOrder: 20>
	composite table
		title: 'Matrix';
		display: [ self values ];
		column: 'x' evaluated: [ :each | each first ];
		column: 'y' evaluated: [ :each | each second ];
		column: 'z' evaluated: [ :each | each third ];
		column: '0' evaluated: [ :each | each fourth ]
]

{ #category : #'instance creation' }
RSMatrix3D >> identity [
	xx := yy := zz := 1.
	xy := xz := x0 := 0.
	yx := yz := y0 := 0.
	zx := zy := z0 := 0
]

{ #category : #initialization }
RSMatrix3D >> initialize [
	self identity
]

{ #category : #tranforming }
RSMatrix3D >> mult: r [
	"multiply this matrix by a second matrix, M := M*R"
	| lxx lxy lxz lx0 lyx lyy lyz ly0 lzx lzy lzz lz0 |
	lxx := (xx * r xx) + (yx * r xy) + (zx * r xz).
	lxy := (xy * r xx) + (yy * r xy) + (zy * r xz).
	lxz := (xz * r xx) + (yz * r xy) + (zz * r xz).
	lx0 := (x0 * r xx) + (y0 * r xy) + (z0 * r xz) + r x0.

	lyx := (xx * r yx) + (yx * r yy) + (zx * r yz).
	lyy := (xy * r yx) + (yy * r yy) + (zy * r yz).
	lyz := (xz * r yx) + (yz * r yy) + (zz * r yz).
	ly0 := (x0 * r yx) + (y0 * r yy) + (z0 * r yz) + r y0.

	lzx := (xx * r zx) + (yx * r zy) + (zx * r zz).
	lzy := (xy * r zx) + (yy * r zy) + (zy * r zz).
	lzz := (xz * r zx) + (yz * r zy) + (zz * r zz).
	lz0 := (x0 * r zx) + (y0 * r zy) + (z0 * r zz) + r z0.

	xx := lxx.
	xy := lxy.
	xz := lxz.
	x0 := lx0.

	yx := lyx.
	yy := lyy.
	yz := lyz.
	y0 := ly0.

	zx := lzx.
	zy := lzy.
	zz := lzz.
	z0 := lz0
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> scale: f [
	"scale by f in all dimensions"
	xx := xx * f.
	xy := xy * f.
	xz := xz * f.
	x0 := x0 * f.

	yx := yx * f.
	yy := yy * f.
	yz := yz * f.
	y0 := y0 * f.

	zx := zx * f.
	zy := zy * f.
	zz := zz * f.
	z0 := z0 * f
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> scaleX: xf y: yf z: zf [
	"scale by f in all dimensions"
	xx := xx * xf.
	xy := xy * xf.
	xz := xz * xf.
	x0 := x0 * xf.

	yx := yx * yf.
	yy := yy * yf.
	yz := yz * yf.
	y0 := y0 * yf.

	zx := zx * zf.
	zy := zy * zf.
	zz := zz * zf.
	z0 := z0 * zf
]

{ #category : #tranforming }
RSMatrix3D >> tranform: alist in: result [
	"tranform a list to a another vector"
	| lxx lxy lxz lx0 lyx lyy lyz ly0 lzx lzy lzz lz0 |
	lxx := xx. lxy := xy. lxz := xz. lx0 := x0.
	lyx := yx. lyy := yy. lyz := yz. ly0 := y0.
	lzx := zx. lzy := zy. lzz := zz. lz0 := z0.

	alist doWithIndex: [ :p :index |
		| tx ty tz x y z l |
		x := p first. y := p second. z := p third.

		tx := (x * lxx) + (y * lxy) + (z * lxz) + lx0.
		ty := (x * lyx) + (y * lyy) + (z * lyz) + ly0.
		tz := (x * lzx) + (y * lzy) + (z * lzz) + lz0.

		l := result at: index.
		l
			ifNil: [ result at: index put: { tx. ty. tz } ]
			ifNotNil: [
				l
					at: 1 put: tx;
					at: 2 put: ty;
					at: 3 put: tz. ]
		 ]
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> translateByX: x y: y z: z [
	x0 := x0 + x.
	y0 := y0 + y.
	z0 := z0 + z.
]

{ #category : #accessing }
RSMatrix3D >> values [
	^ Array
		with: (Array with: xx with: xy with: xz with: x0)
		with: (Array with: yx with: yy with: yz with: y0)
		with: (Array with: zx with: zy with: zz with: x0)
]

{ #category : #accessing }
RSMatrix3D >> x0 [
	^ x0
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> xrot: theta [
	" theta is in radians, rotation in x axis"
	| ct st nyx nyy nyz ny0 nzx nzy nzz nz0 |

	ct := theta cos.
	st := theta sin.

	nyx := (yx * ct) + (zx * st).
	nyy := (yy * ct) + (zy * st).
	nyz := (yz * ct) + (zz * st).
	ny0 := (y0 * ct) + (z0 * st).

	nzx := (zx * ct) - (yx * st).
	nzy := (zy * ct) - (yy * st).
	nzz := (zz * ct) - (yz * st).
	nz0 := (z0 * ct) - (y0 * st).

	yx := nyx.
	yy := nyy.
	yz := nyz.
	y0 := ny0.

	zx := nzx.
	zy := nzy.
	zz := nzz.
	z0 := nz0
]

{ #category : #accessing }
RSMatrix3D >> xx [
	^ xx
]

{ #category : #accessing }
RSMatrix3D >> xy [
	^ xy
]

{ #category : #accessing }
RSMatrix3D >> xz [
	^ xz
]

{ #category : #accessing }
RSMatrix3D >> y0 [
	^ y0
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> yrot: theta [
	" theta is in radians, rotation in y axis"
	| ct st nxx nxy nxz nx0 nzx nzy nzz nz0 |

	ct := theta cos.
	st := theta sin.

	nxx := (xx * ct) + (zx * st).
	nxy := (xy * ct) + (zy * st).
	nxz := (xz * ct) + (zz * st).
	nx0 := (x0 * ct) + (z0 * st).

	nzx := (zx * ct) - (xx * st).
	nzy := (zy * ct) - (xy * st).
	nzz := (zz * ct) - (xz * st).
	nz0 := (z0 * ct) - (x0 * st).

	xx := nxx.
	xy := nxy.
	xz := nxz.
	x0 := nx0.

	zx := nzx.
	zy := nzy.
	zz := nzz.
	z0 := nz0
]

{ #category : #accessing }
RSMatrix3D >> yx [
	^ yx
]

{ #category : #accessing }
RSMatrix3D >> yy [
	^ yy
]

{ #category : #accessing }
RSMatrix3D >> yz [
	^ yz
]

{ #category : #accessing }
RSMatrix3D >> z0 [
	^ z0
]

{ #category : #'scaling, rotation, translation' }
RSMatrix3D >> zrot: theta [
	" theta is in radians, rotation in z axis"
	| ct st nyx nyy nyz ny0 nxx nxy nxz nx0 |

	ct := theta cos.
	st := theta sin.

	nyx := (yx * ct) + (xx * st).
	nyy := (yy * ct) + (xy * st).
	nyz := (yz * ct) + (xz * st).
	ny0 := (y0 * ct) + (x0 * st).

	nxx := (xx * ct) - (yx * st).
	nxy := (xy * ct) - (yy * st).
	nxz := (xz * ct) - (yz * st).
	nx0 := (x0 * ct) - (y0 * st).

	yx := nyx.
	yy := nyy.
	yz := nyz.
	y0 := ny0.

	xx := nxx.
	xy := nxy.
	xz := nxz.
	x0 := nx0
]

{ #category : #accessing }
RSMatrix3D >> zx [
	^ zx
]

{ #category : #accessing }
RSMatrix3D >> zy [
	^ zy
]

{ #category : #accessing }
RSMatrix3D >> zz [
	^ zz
]

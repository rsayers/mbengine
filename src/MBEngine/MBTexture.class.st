Class {
	#name : #MBTexture,
	#superclass : #Object,
	#instVars : [
		'image'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBTexture >> getCol: position wallHeight: wallHeight [ 
	| tmp texX yInc y c|
	yInc := (wallHeight * 2) / (self height).
	y := 0.
	texX := ((self width * (position x + position y)) % self width) asInteger.
	tmp := Form extent: (image extent) depth: (image depth).
	1 to: (self height) do: [ :i |
			c := image colorAt: (texX@i).
			tmp colorAt: (texX@(y floor)) put: c.
			y := y + yInc.
	].
	^ tmp.
]

{ #category : #accessing }
MBTexture >> height [
	^ self image height
]

{ #category : #accessing }
MBTexture >> image [

	^ image
]

{ #category : #accessing }
MBTexture >> image: anObject [

	image := anObject
]

{ #category : #accessing }
MBTexture >> load: filename [ 
	image := ImageReadWriter formFromFileNamed: filename
]

{ #category : #accessing }
MBTexture >> width [ 
	^ self image width
]

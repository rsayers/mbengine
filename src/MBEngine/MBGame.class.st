Class {
	#name : #MBGame,
	#superclass : #Morph,
	#instVars : [
		'screenWidth',
		'screenHeight',
		'renderDelay',
		'player',
		'raycastPrecision',
		'map',
		'running',
		'process'
	],
	#pools : [
		'SDL2Constants',
		'SDL2Types'
	],
	#category : #MBEngine
}

{ #category : #cleanup }
MBGame class >> cleanUp [ 
	MBGame allInstancesDo: [ :x | x renderer destroy. x window destroy ]
]

{ #category : #accessing }
MBGame >> clearScreen [ 
	renderer clear.
]

{ #category : #accessing }
MBGame >> drawColor: color [ 
	renderer drawColorR: (color red * 255) g:  (color green * 255) b: (color blue * 255) a: 255.
]

{ #category : #accessing }
MBGame >> drawLineFrom: start to: end [
	renderer drawLineX1: start x y1: start y x2: end x y2: end y.
]

{ #category : #drawing }
MBGame >> drawOn: canvas [ 

	| rayAngle ray rayCos raySin wall distance wallHeight |
	rayAngle := 60 - 30.

	1 to: screenWidth do: [ :rayCount | 
		ray := MBRay new.
		ray position: player position.
		rayCos := rayAngle degreesToRadians cos / raycastPrecision.
		raySin := rayAngle degreesToRadians sin / raycastPrecision.
		wall := 0.
		[ wall = 0 ] whileTrue: [ 
			ray position: ray position + (rayCos @ raySin).
			wall := (map at: ray position y floor) at: (ray position x floor) ].

		distance := player position distanceTo: ray position.
		wallHeight := (self halfScreenHeight / distance) floor.
		self drawColor: Color cyan.
		self drawLineFrom: rayCount@0 to: rayCount@(self halfScreenHeight - wallHeight).
		self drawColor: Color red.
		self drawLineFrom: rayCount@(self halfScreenHeight - wallHeight) to: rayCount@(self halfScreenHeight + wallHeight).
		self drawColor: Color green.
		self drawLineFrom: rayCount@(self halfScreenHeight + wallHeight) to: rayCount@(self screenHeight).

		rayAngle := rayAngle + self rayIncrementAngle ].

]

{ #category : #'as yet unclassified' }
MBGame >> halfScreenHeight [
	^ self screenHeight / 2
]

{ #category : #'as yet unclassified' }
MBGame >> halfScreenWidth [
	^ self screenWidth / 2
]

{ #category : #initialization }
MBGame >> initialize [

	screenWidth := 640.
	screenHeight := 640.
	renderDelay := 30.
	raycastPrecision := 64.
	player := MBPlayer new.
	player fov: 60.
	player position: 2@2.
	map := { 
		       { 1. 1. 1. 1. 1. 1. 1. 1. 1. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 1. 1. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 1. 1. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 1. 1. 1. 1. 1. 1. 1. 1. 1 } }.
	self initSDL.
]

{ #category : #accessing }
MBGame >> map [

	^ map
]

{ #category : #accessing }
MBGame >> map: anObject [

	map := anObject
]

{ #category : #accessing }
MBGame >> player [

	^ player
]

{ #category : #accessing }
MBGame >> player: anObject [

	player := anObject
]

{ #category : #'as yet unclassified' }
MBGame >> pointsOnLineFrom: startPoint to: endPoint [
    | x1 y1 x2 y2 dx dy steps x y points |
    x1 := startPoint x.
    y1 := startPoint y.
    x2 := endPoint x.
    y2 := endPoint y.
    dx := x2 - x1.
    dy := y2 - y1.
    steps := dx abs max: dy abs.
    dx := dx asFloat / steps.
    dy := dy asFloat / steps.
    x := x1 asFloat.
    y := y1 asFloat.
    points := OrderedCollection new.
    1 to: steps + 1 do: [ :i |
        points add: x asInteger @ y asInteger.
        x := x + dx.
        y := y + dy.
    ].
    ^ points
]

{ #category : #'as yet unclassified' }
MBGame >> rayIncrementAngle [
	^ self player fov / self screenWidth 
]

{ #category : #accessing }
MBGame >> raycastPrecision [

	^ raycastPrecision
]

{ #category : #accessing }
MBGame >> raycastPrecision: anObject [

	raycastPrecision := anObject
]

{ #category : #accessing }
MBGame >> raycasting [

	| rayAngle ray rayCos raySin wall distance wallHeight |
	rayAngle := 60 - 30.

	1 to: screenWidth do: [ :rayCount | 
		ray := MBRay new.
		ray position: player position.
		rayCos := rayAngle degreesToRadians cos / raycastPrecision.
		raySin := rayAngle degreesToRadians sin / raycastPrecision.
		wall := 0.
		[ wall = 0 ] whileTrue: [ 
			ray position: ray position + (rayCos @ raySin).
			wall := (map at: ray position y floor) at: (ray position x floor) ].

		distance := player position distanceTo: ray position.
		wallHeight := (self halfScreenHeight / distance) floor.
		self drawColor: Color cyan.
		self drawLineFrom: rayCount@0 to: rayCount@(self halfScreenHeight - wallHeight).
		self drawColor: Color red.
		self drawLineFrom: rayCount@(self halfScreenHeight - wallHeight) to: rayCount@(self halfScreenHeight + wallHeight).
		self drawColor: Color green.
		self drawLineFrom: rayCount@(self halfScreenHeight + wallHeight) to: rayCount@(self screenHeight).

		rayAngle := rayAngle + self rayIncrementAngle ].
	renderer present.
]

{ #category : #accessing }
MBGame >> renderDelay [

	^ renderDelay
]

{ #category : #accessing }
MBGame >> renderDelay: anObject [

	renderDelay := anObject
]

{ #category : #accessing }
MBGame >> renderer [

	^ renderer
]

{ #category : #accessing }
MBGame >> renderer: anObject [

	renderer := anObject
]

{ #category : #accessing }
MBGame >> screenHeight [

	^ screenHeight
]

{ #category : #accessing }
MBGame >> screenHeight: anObject [

	screenHeight := anObject
]

{ #category : #accessing }
MBGame >> screenWidth [

	^ screenWidth
]

{ #category : #accessing }
MBGame >> screenWidth: anObject [

	screenWidth := anObject
]

{ #category : #accessing }
MBGame >> window [

	^ window
]

{ #category : #accessing }
MBGame >> window: anObject [

	window := anObject
]

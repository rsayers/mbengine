Class {
	#name : #MBGame,
	#superclass : #Object,
	#instVars : [
		'screenWidth',
		'screenHeight',
		'renderDelay',
		'player',
		'raycastPrecision',
		'map',
		'window',
		'renderer',
		'running'
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

{ #category : #'as yet unclassified' }
MBGame >> halfScreenHeight [
	^ self screenHeight / 2
]

{ #category : #'as yet unclassified' }
MBGame >> halfScreenWidth [
	^ self screenWidth / 2
]

{ #category : #accessing }
MBGame >> initSDL [ 	
	SDL2 initVideo.
	window := SDL2 createWindow: 'Test Window'
					x: SDL_WINDOWPOS_UNDEFINED
					y: SDL_WINDOWPOS_UNDEFINED
					width: 640
					height: 480
					flags: SDL_WINDOW_SHOWN.
	renderer := window createDefaultRenderer.
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
MBGame >> mainLoop [

	| event |
	running := true.
	event := SDL_Event new.
	[ running ] whileTrue: [ 
		[ (SDL2 pollEvent: event) > 0 ] whileTrue:
			[ self processEvent: event ]. 
		self clearScreen.
		self raycasting ]. 
	renderer destroy.
	window destroy
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

{ #category : #accessing }
MBGame >> processEvent: event [ 
	event type = SDL_QUIT ifTrue: [ running := false ]
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

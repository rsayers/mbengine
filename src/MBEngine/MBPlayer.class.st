Class {
	#name : #MBPlayer,
	#superclass : #Object,
	#instVars : [
		'fov',
		'position',
		'angle'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBPlayer >> angle [

	^ angle
]

{ #category : #accessing }
MBPlayer >> angle: anObject [

	angle := anObject
]

{ #category : #accessing }
MBPlayer >> fov [

	^ fov.
]

{ #category : #accessing }
MBPlayer >> fov: anObject [

	fov := anObject
]

{ #category : #accessing }
MBPlayer >> halfFov [

	^ fov // 2
]

{ #category : #accessing }
MBPlayer >> position [

	^ position
]

{ #category : #accessing }
MBPlayer >> position: anObject [

	position := anObject
]

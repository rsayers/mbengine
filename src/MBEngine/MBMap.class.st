Class {
	#name : #MBMap,
	#superclass : #Object,
	#instVars : [
		'mapData',
		'width',
		'height',
		'game'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBMap >> at: aPoint [ 
	^ mapData at: (aPoint y floor) * width + (aPoint x floor) ifAbsent:[0].
]

{ #category : #accessing }
MBMap >> at: aPoint put: aValue [
	mapData at: (aPoint y floor) * width + (aPoint x floor) ifAbsent: [^true].
	^ mapData at: ((aPoint y floor) * width + (aPoint x floor)) put: aValue.
]

{ #category : #accessing }
MBMap >> game [

	^ game
]

{ #category : #accessing }
MBMap >> game: anObject [

	game := anObject
]

{ #category : #accessing }
MBMap >> height [

	^ height
]

{ #category : #accessing }
MBMap >> height: anObject [

	height := anObject
]

{ #category : #accessing }
MBMap >> mapData [

	^ mapData
]

{ #category : #accessing }
MBMap >> mapData: anObject [

	mapData := anObject
]

{ #category : #accessing }
MBMap >> width [

	^ width
]

{ #category : #accessing }
MBMap >> width: anObject [

	width := anObject
]

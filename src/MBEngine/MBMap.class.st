Class {
	#name : #MBMap,
	#superclass : #Object,
	#instVars : [
		'mapData',
		'width',
		'height'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBMap >> at: aPoint [ 
	^ mapData at: (aPoint y floor) * width + (aPoint x floor).
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

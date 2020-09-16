"
I represent a descriptor of how the text will be like


Public API and Key Messages:

- classFolder
- loadSpriteWith:using:
- spriteSize


"
Class {
	#name : #WBATextDescriptor,
	#superclass : #GameSpriteDescriptor,
	#category : #'Winter-WizardBattleArena'
}

{ #category : #Defaults }
WBATextDescriptor class >> availableText [
	^ #( 
	1
	2
	3
	4
	arena
	arrowLeft0
	arrowLeft1
	arrowRight0
	arrowRight1
	character
	player
	players
	season
	select
	spell
	title
	winner
	)
]

{ #category : #Bootstrap }
WBATextDescriptor >> classFolder [
	^ 'text/'
]

{ #category : #Bootstrap }
WBATextDescriptor >> loadSpritesWith: aSurface using: anAssetsManagementSystem [

	self class availableText
		do: [ :key | 
			fileName := key asString.
			self loadImageFileUsing: anAssetsManagementSystem ]
]

{ #category : #Bootstrap }
WBATextDescriptor >> resourceFolder [

	^ 'resources/wba'
]

{ #category : #Bootstrap }
WBATextDescriptor >> spriteSize [

	^ 32 @ 48
]

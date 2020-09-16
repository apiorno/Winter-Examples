"
I am the base class for WBA game

Instance Variables
- scheduler
- collisionHandlers
- screen
- scene
- rootSystem

Public API and Key Messages:

- descriptor 
- gameDescriptor





"
Class {
	#name : #WBA,
	#superclass : #Game,
	#instVars : [
		'scheduler',
		'descriptor',
		'gameDescriptor',
		'assetsManager',
		'players'
	],
	#category : #'Winter-WizardBattleArena'
}

{ #category : #accessing }
WBA class >> start [

	^WBANumberPlayerSelectScreenModel new
		screen: WinterScreen new;
		display
]

{ #category : #Accessing }
WBA >> assetsManager [

	^ assetsManager 
]

{ #category : #Validating }
WBA >> checkEndGame [

	| alivePlayers |

	alivePlayers := self players reject: [ :each | each character isDead ].
	alivePlayers size = 1
		ifTrue: [ self endScreen: alivePlayers first ]
]

{ #category : #Accessing }
WBA >> dimensions [

	^ descriptor windowExtent
]

{ #category : #Computing }
WBA >> endScreen: winner [

	WBAEndScreenModel new
		screen: screen;
		startingGame: self;
		winner: winner;
		display
]

{ #category : #Accessing }
WBA >> gameDescriptor [

	^ gameDescriptor
]

{ #category : #Accessing }
WBA >> gameDescriptor: anObject [

	gameDescriptor := anObject
]

{ #category : #initialization }
WBA >> initialize [

	super initialize.
	self
		initializeResources;
		initializeSchedulers
]

{ #category : #initialization }
WBA >> initializeResources [

	assetsManager := AssetsManager new.
	WBATextDescriptor new loadSpritesWith: nil using: assetsManager
]

{ #category : #initialization }
WBA >> initializeSchedulers [

	scheduler  := AnimationsScheduler new.
]

{ #category : #Accessing }
WBA >> players [

	^ players
]

{ #category : #Accessing }
WBA >> players: aPlayersCollection [

	players := aPlayersCollection
]

{ #category : #Accessing }
WBA >> scheduler [

	^ scheduler
]

{ #category : #initialization }
WBA >> start [

	super start.
	scheduler  startProcess
	
]

{ #category : #initialization }
WBA >> stop [

	super stop.
	scheduler
		ifNotNil: [ scheduler terminateProcess.
			scheduler := nil
			]
]

{ #category : #Accessing }
WBA >> textSpritesAt: aName [

	^ assetsManager assetNamed: aName
]

{ #category : #Accessing }
WBA >> title [

	^'Wizard Battle Arena'
]

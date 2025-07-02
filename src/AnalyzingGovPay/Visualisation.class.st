Class {
	#name : #Visualisation,
	#superclass : #Object,
	#classInstVars : [
		'allFiles'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
Visualisation class >> backgroundForFile: aFile [ 

	(aFile basename matches: '*Test*') ifTrue: [
		allFiles detect: [:f | (aFile basename allButLast: 9) = (f basename allButLast: 5)] ifFound: [^Color lightGreen]
		 ifNone: [^Color lightYellow]].
	(aFile basename matches: '*Test*') ifFalse: [
		allFiles detect: [:f | (f basename allButLast: 9) = (aFile basename allButLast: 5)] ifFound: [^Color lightYellow]
		 ifNone: [^Color lightGreen]].
	^Color lightRed
]

{ #category : #accessing }
Visualisation class >> backgroundForMetrics: aMetrics [ 
	| file |
	file := aMetrics file.
	file size <1000 ifTrue: [^Color green].
	file size < 5000 ifTrue: [^Color yellow].
	^Color red
]

{ #category : #accessing }
Visualisation class >> borderForFile: aFile [
	(aFile basename matches: '*Test*')
		ifTrue: [ ^ BlBorder paint: Color green width: 3 ].
	(aFile basename matches: '*IT*')
		ifTrue: [ ^ BlBorder paint: Color blue width: 3 ].
	(aFile basename matches: '*Exception*')
		ifTrue: [ ^ BlBorder paint: Color red width: 3 ].
	^ BlBorder paint: Color gray
]

{ #category : #accessing }
Visualisation class >> javaFiles: files [
	<gtExample>
	| view |
	allFiles := files.
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			GtMondrianUMLClassElement withDefaultContainer
				label: each basenameWithoutExtension;
				border: (self borderForFile: each) ;
				background: (self backgroundForFile: each)];
		with: files;
		forEach: [ :file | 
			view nodes
				shape: [ :metrics | 
					BlElement new
						background: (metrics background);
						size: (metrics metricsSize);
						yourself ];
				with: ((FileMetrics on: file) metrics)].
	view layout rectanglePack.
	^ view
]

{ #category : #accessing }
Visualisation class >> sizeForMetrics: aMetrics [ 
	|nrOfMocks nrOfTests|
nrOfMocks := (aMetrics file contents allRegexMatches: '@Mock') size.
	nrOfTests := (aMetrics file contents allRegexMatches: '@Test') size.
	^(3 max: nrOfMocks ) @ ( 3 max: nrOfTests)
]

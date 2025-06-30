Class {
	#name : #Visualisation,
	#superclass : #Object,
	#category : #'AnalyzingGovPay-Visualisation'
}

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
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			GtMondrianUMLClassElement withDefaultContainer
				label: each basename;
				border: (self borderForFile: each) ];
		with: files;
		forEach: [ :file | 
			view nodes
				shape: [ :metrics | 
					BlElement new
						background: (self backgroundForMetrics: metrics);
						size: (self sizeForMetrics: metrics);
						yourself ];
				with: (Array with: (FileMetrics on: file) )].
	view layout rectanglePack.
	^ view
]

{ #category : #accessing }
Visualisation class >> sizeForMetrics: aMetrics [ 
	|nrOfMocks nrOfImports|
nrOfMocks := (aMetrics file contents allRegexMatches: '@Mock') size.
	nrOfImports := (aMetrics file contents allRegexMatches: 'import') size.
	^(3 max: nrOfMocks ) @ ( 3 max: nrOfImports)
]

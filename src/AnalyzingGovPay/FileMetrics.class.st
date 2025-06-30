Class {
	#name : #FileMetrics,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
FileMetrics class >> on: aFileReference [
	^self new
		file: aFileReference;
		yourself
]

{ #category : #'as yet unclassified' }
FileMetrics >> background [
	file size <1000 ifTrue: [^Color green].
	file size < 5000 ifTrue: [^Color yellow].
	^Color red
]

{ #category : #accessing }
FileMetrics >> file [
	^ file
]

{ #category : #accessing }
FileMetrics >> file: aFileReference [ 
	file := aFileReference
]

{ #category : #'as yet unclassified' }
FileMetrics >> metricsSize [
	|nrOfMocks nrOfImports|
nrOfMocks := (file contents allRegexMatches: '@Mock') size.
	nrOfImports := (file contents allRegexMatches: 'import') size.
	^(3 max: nrOfMocks ) @ ( 3 max: nrOfImports)
]

{ #category : #'as yet unclassified' }
FileMetrics >> oneFileMetrics: aView [
	<gtView>
	^aView mondrian
		title: 'File metrics';
		priority: 10;
		painting: [ :m | 
			m nodes 
				stencil: [ :metrics |
					BlElement new
						background: self background;
						size: self metricsSize
					];
					with: (Array with:self).

			m ]
	
]

Class {
	#name : #BaselineOfAnalyzingGovPay,
	#superclass : #BaselineOf,
	#category : #BaselineOfAnalyzingGovPay
}

{ #category : #loading }
BaselineOfAnalyzingGovPay class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'analyzing-gov-pay' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfAnalyzingGovPay >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'AnalyzingGovPay'
		]
]

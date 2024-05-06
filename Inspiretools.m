(* ::Package:: *)

(* ::Section:: *)
(*Inspire Mathematica Interface (just execute all)*)


(* ::Subsection:: *)
(*General functions*)


(*InterpretDate[str_]:=DateObject[{StringSplit[str,"+"]\[LeftDoubleBracket]1\[RightDoubleBracket],{"Year","-","Month","-","Day","T","Hour",":","Minute",":","Second"}} ,TimeZone\[Rule]"UTC"];*)
StringToDateOld[string_]:=Quiet[Check[First[Cases[{DateList[StringSplit[string,"+"][[1]] ,TimeZone->"UTC" ]},x_:>x[[1]]+(x[[2]]-1)/12+(x[[3]]-1)/365]]//N,If[ToString[Head[ToExpression[string]]]=="Real",ToExpression[string],string]]];
StringToDateNew[string_] := Quiet[Module[{dateobj, datelist, instant, result}, Check[dateobj = DateObject[StringSplit[string, "+"][[1]], "Instant", TimeZone -> "UTC"]; datelist = DateList[dateobj]; instant = datelist[[-1]] - Floor[datelist[[-1]]]; result = 1900 + (AbsoluteTime[dateobj, TimeZone -> "UTC"] + instant)/(365.2422*24*60*60.); {If[Abs[result-Round[result]]<0.0027,N[Round[result]],result]}, If[ToString[Head[ToExpression[string]]] == "Real", ToExpression[string], string]]]];
StringToDate[string_] := StringToDateNew[string];
DateToDateObject[date_] := Module[{tmp, datelist, instant, newdatelist}, tmp = FromAbsoluteTime[(date - 1900)*365.2422*24*60*60., TimeZone -> "UTC"]; tmp]; 
GetDateFromArXivNumber[arxivnumber_]:=If[ToString[arxivnumber]!=ToString[Null],StringCases[StringCases[StringDelete[arxivnumber,"."],DigitCharacter..][[1]],w_~~x_~~y_~~z_~~k__:>Which[ToExpression[w<>x]<=50,ToExpression[w<>x]+2000+(ToExpression[y<>z]-1)/12.+ToExpression[k]/1000000.,ToExpression[w<>x]>50,ToExpression[w<>x]+1900+(ToExpression[y<>z]-1)/12.+ToExpression[k]/1000000.]],{Null}][[1]];
SelectSmallestDate[list_]:=Quiet[Check[Module[{tmp},tmp=N[#]&/@DeleteDuplicates[Sort[MinimalBy[DeleteCases[Flatten[list],Null],IntegerPart[#]&]]];If[Length[tmp]==1,tmp[[1]],If[tmp[[1]]-IntegerPart[tmp[[1]]]==0,tmp[[2]],tmp[[1]]]]],Null]];
ArXivCat[string_]:=StringReplace[string,RegularExpression["\\.(.*)"]:>""];


(* ::Text:: *)
(*Possible URLS appearing in records (not needed anymore)*)


authorsurls={"https://inspirehep.net/api/authors/"};
institutionsurls={"https://labs.inspirehep.net/api/institutions/","https://inspirehep.net/api/institutions/"};
journalsurls={"https://labs.inspirehep.net/api/journals/","https://inspirehep.net/api/journals/"};
literatureurls ={"https://labs.inspirehep.net/api/literature/","https://inspirehep.net/api/literature/"};


(* ::Subsection:: *)
(*Check schema and import sample records to test the interface*)


(* ::Text:: *)
(*Import the Inspire schema conaining all keys to be extracted from the JSON database*)


schema=Import["https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html"];


keys[1]={"created","id","links","metadata","updated"};
keys[2]=StringTrim[StringSplit[StringReplace[StringCases[schema,RegularExpression["Properties:.+[^\n]"]][[1]],"Properties: "->""],","]];
keys[3]={"artid","cnum","conf_acronym","conference_record","curated_relation","hidden","journal_issue","journal_record","journal_title","journal_volume","material","page_end","page_start","parent_isbn","parent_record","parent_report_number","pubinfo_freetext","year"};


(* ::Subsection:: *)
(*Schema: General elements for all records and objects*)


(* ::Text:: *)
(*Functions that correspond to all general elements for each JSON entry (in all records: authors, conferences, data, experiments, hep, insitutions, jobs, journals)*)


RecordID[entry_]:=ToExpression[entry[["id"]]/.Missing["KeyAbsent",x__]:>0];
RecordLinks[entry_]:=entry[["links"]]/.Missing["KeyAbsent",x__]:>{""};
RecordCreated[entry_]:=entry[["created"]]/.Missing["KeyAbsent",x__]:>"";
RecordUpdated[entry_]:=entry[["updated"]]/.Missing["KeyAbsent",x__]:>"";


ObjectAcceleratorExperiments=Association[{"accelerator"->"","curated_relation"->False,"experiment"->"","institution"->"","legacy_name"->"","record"->ObjectJSONReference}];
ObjectAcquisitionSource=Association[{"datetime"->"","email"->"","internal_uid"->0,"method"->"","orcid"->"","source"->"","submission_number"->""}];
ObjectAddress=Association[{"cities"->{""},"country_code"->"","latitude"->0.,"longitude"->0.,"place_name"->"","postal_address"->{""},"postal_code"->"","state"->""}];
ObjectAdvisors=Association[{"curated_relation"->False,"degree_type"->"","ids"->{ObjectID},"name"->"","record"->ObjectJSONReference}];
ObjectAffiliations=Association[{"curated_relation"->False,"record"->ObjectJSONReference,"value"->""}];
ObjectAffiliationsIdentifiers=Association[{"schema"->"","value"->""}];
ObjectArXivEprint=Association[{"categories"->{""},"value"->""}];
ObjectAuthors=Association[{"affiliations"->{ObjectAffiliations},"affiliations_identifiers"->{ObjectAffiliationsIdentifiers},"alternative_names"->{""},
											"credit_roles"->{""},"curated_relation"->False,"emails"->{""},"full_name"->"","ids"->{ObjectID},"inspire_roles"->{""},
											"raw_affiliations"->{ObjectSourcedValue},"record"->ObjectJSONReference,"signature_block"->"","uuid"->""}];
ObjectAwards=Association[{"name"->"","url"->ObjectURL,"year"->0}];
ObjectBookSeries=Association[{"title"->"","volume"->""}];
ObjectCollaborations=Association[{"record"->ObjectJSONReference,"value"->""}];
ObjectCopyright=Association[{"holder"->"","material"->"","statement"->"","url"->"","year"->0}];
ObjectDESYBookkeeping=Association[{"date"->"","expert"->"","identifier"->"","status"->""}];
ObjectDocument=Association[{"description"->"","filename"->False,"fulltext"->False,"hidden"->False,"key"->"","material"->"","original_url"->"","source"->"","url"->""}];
ObjectDOI=Association[{"material"->"","source"->"","value"->""}];
ObjectEmailAddress=Association[{"current"->False,"hidden"->False,"value"->""}];
ObjectExportTo=Association[{"CDS"->False,"HAL"->False}];
ObjectFigure=Association[{"caption"->"","filename"->"","key"->"","label"->"","material"->"","original_url"->"","source"->"","url"->""}];
ObjectFundingInfo=Association[{"agency"->"","grant_number"->"","project_number"->""}];
ObjectHarvestingInfo=Association[{"coverage"->"","date_last_harvest"->"","last_seen_item"->"","method"->""}];
ObjectID=Association[{"schema"->"","value"->""}];
ObjectImprints=Association[{"date"->"","place"->"","publisher"->""}];
ObjectInspireField=Association[{"source"->"","term"->""}];
ObjectInstitution=Association[{"curated_relation"->False,"name"->"","record"->ObjectJSONReference}];
ObjectInstitutionHierarchy=Association[{"acronym"->"","name"->""}];
ObjectISBN=Association[{"medium"->"","value"->""}];
ObjectISSN=Association[{"medium"->"","value"->""}];
ObjectJSONReference=Association[{"$ref"->""}];
ObjectKeyword=Association[{"schema"->"","source"->"","value"->""}];
ObjectLicense=Association[{"imposing"->"","license"->"","material"->"","url"->""}];
ObjectLicenseJournal=Association[{"license"->"","url"->""}];
ObjectName=Association[{"name_variants"->{""},"native_names"->{""},"numeration"->"","preferred_name"->"","previous_names"->{""},"title"->"","value"->""}];
ObjectPersistentIdentifier=Association[{"material"->"","schema"->"","source"->"","value"->""}];
ObjectPosition=Association[{"curated_relation"->False,"current"->False,"end_date"->"","institution"->"","rank"->"","record"->ObjectJSONReference,"start_date"->""}];
ObjectProjectMembership=Association[{"curated_relation"->False,"current"->False,"end_date"->"","name"->"","record"->ObjectJSONReference,"start_date"->""}];
ObjectPublicationInfo=Association[{"artid"->"","cnum"->"","conf_acronym"->"","conference_record"->ObjectJSONReference,"curated_relation"->False,
									"hidden"->False,"journal_issue"->"","journal_record"->ObjectJSONReference,"journal_title"->"","journal_volume"->"",
									"material"->"","page_end"->"","page_start"->"","parent_isbn"->"","parent_record"->ObjectJSONReference,
									"parent_report_number"->"","pubinfo_freetext"->"","year"->0}];
ObjectRawRefs=Association[{"schema"->"","source"->"","value"->""}];
ObjectRecordsFiles=Association[{"bucket"->"","checksum"->"","file_id"->"","filename"->"","key"->"","size"->0,"version_id"->""}];
ObjectReferences=Association[{"curated_relation"->False,"legacy_curated"->False,"raw_refs"->{ObjectRawRefs},"record"->ObjectJSONReference,"reference"->ObjectReference}];
ObjectReference=Association[{"arxiv_eprint"->"","authors"->{ObjectReferenceAuthors},"book_series"->ObjectBookSeries,"collaborations"->{""},"document_type"->"","dois"->{""},
								"external_system_identifiers"->{ObjectID},"imprint"->ObjectImprints,"isbn"->"","label"->"","misc"->{""},"persistent_identifiers"->{ObjectID},
								"publication_info"->ObjectReferencePublicationInfo,"report_numbers"->{""},"texkey"->"","title"->ObjectTitle,"urls"->ObjectURL}];
ObjectReferenceAuthors=Association[{"full_name"->"","inspire_role"->""}];
ObjectReferencePublicationInfo=Association[{"artid"->"","cnum"->"","journal_issue"->"","journal_record"->ObjectJSONReference,"journal_title"->"","journal_volume"->"",
											"material"->"","page_end"->"","page_start"->"","parent_isbn"->"","parent_report_number"->"","parent_title"->"","year"->0}];
ObjectRelatedRecord=Association[{"curated_relation"->False,"record"->ObjectJSONReference,"relation"->"","relation_freetext"->""}];
ObjectReportNumber=Association[{"hidden"->False,"source"->"","value"->""}];
ObjectSourcedValue=Association[{"source"->"","value"->""}];
ObjectThesisInfo=Association[{"date"->"","defense_date"->"","degree_type"->"","institutions"->{ObjectInstitution}}];
ObjectTitle=Association[{"source"->"","subtitle"->"","title"->""}];
ObjectTitleTranslation=Association[{"language"->"","source"->"","subtitle"->"","title"->""}];
ObjectURL=Association[{"description"->"","value"->""}];


ObjectAcceleratorExperimentsLegend[n_]:=Association[{"accelerator"->"accelerator_"<>ToString[n],"curated_relation"->"curated_relation_"<>ToString[n],
														"experiment"->"experiment_"<>ToString[n],"institution"->"institution_<>ToString[n]",
														"legacy_name"->"legacy_name_"<>ToString[n],"record"->ObjectJSONReferenceLegend[n]}];
ObjectAcquisitionSourceLegend[n_]:=Association[{"datetime"->"datetime_"<>ToString[n],"email"->"email_"<>ToString[n],"internal_uid"->"internal_uid_"<>ToString[n],
												"method"->"method_"<>ToString[n],"orcid"->"orcid_"<>ToString[n],"source"->"source_"<>ToString[n],
												"submission_number"->"submission_number_"<>ToString[n]}];
ObjectAddressLegend[n_]:=Association[{"cities"->{"city_"<>ToString[n]<>"_1","city_"<>ToString[n]<>"_2"},"country_code"->"country_code_"<>ToString[n],
										"latitude"->"latitude_"<>ToString[n],"longitude"->"longitude_"<>ToString[n],"place_name"->"place_name_"<>ToString[n],
										"postal_address"->{"postal_address_"<>ToString[n]<>"_1","postal_address_"<>ToString[n]<>"_2"},
										"postal_code"->"postal_code_"<>ToString[n],"state"->"state_"<>ToString[n]}];
ObjectAdvisorsLegend[n_]:=Association[{"curated_relation"->"curated_relation_"<>ToString[n],"degree_type"->"degree_type","ids"->{ObjectIDLegend},"name"->"","record"->ObjectJSONReference}];
ObjectAffiliations=Association[{"curated_relation"->False,"record"->ObjectJSONReference,"value"->""}];
ObjectAffiliationsIdentifiers=Association[{"schema"->"","value"->""}];
ObjectArXivEprint=Association[{"categories"->{""},"value"->""}];
ObjectAuthors=Association[{"affiliations"->{ObjectAffiliations},"affiliations_identifiers"->{ObjectAffiliationsIdentifiers},"alternative_names"->{""},
											"credit_roles"->{""},"curated_relation"->False,"emails"->{""},"full_name"->"","ids"->{ObjectID},"inspire_roles"->{""},
											"raw_affiliations"->{ObjectSourcedValue},"record"->ObjectJSONReference,"signature_block"->"","uuid"->""}];
ObjectAwards=Association[{"name"->"","url"->ObjectURL,"year"->0}];
ObjectBookSeries=Association[{"title"->"","volume"->""}];
ObjectCollaborations=Association[{"record"->ObjectJSONReference,"value"->""}];
ObjectCopyright=Association[{"holder"->"","material"->"","statement"->"","url"->"","year"->0}];
ObjectDESYBookkeeping=Association[{"date"->"","expert"->"","identifier"->"","status"->""}];
ObjectDocument=Association[{"description"->"","filename"->False,"fulltext"->False,"hidden"->False,"key"->"","material"->"","original_url"->"","source"->"","url"->""}];
ObjectDOI=Association[{"material"->"","source"->"","value"->""}];
ObjectEmailAddress=Association[{"current"->False,"hidden"->False,"value"->""}];
ObjectExportTo=Association[{"CDS"->False,"HAL"->False}];
ObjectFigure=Association[{"caption"->"","filename"->"","key"->"","label"->"","material"->"","original_url"->"","source"->"","url"->""}];
ObjectFundingInfo=Association[{"agency"->"","grant_number"->"","project_number"->""}];
ObjectHarvestingInfo=Association[{"coverage"->"","date_last_harvest"->"","last_seen_item"->"","method"->""}];
ObjectID=Association[{"schema"->"","value"->""}];
ObjectImprints=Association[{"date"->"","place"->"","publisher"->""}];
ObjectInspireField=Association[{"source"->"","term"->""}];
ObjectInstitution=Association[{"curated_relation"->False,"name"->"","record"->ObjectJSONReference}];
ObjectInstitutionHierarchy=Association[{"acronym"->"","name"->""}];
ObjectISBN=Association[{"medium"->"","value"->""}];
ObjectISSN=Association[{"medium"->"","value"->""}];
ObjectJSONReference=Association[{"$ref"->""}];
ObjectKeyword=Association[{"schema"->"","source"->"","value"->""}];
ObjectLicense=Association[{"imposing"->"","license"->"","material"->"","url"->""}];
ObjectLicenseJournal=Association[{"license"->"","url"->""}];
ObjectName=Association[{"name_variants"->{""},"native_names"->{""},"numeration"->"","preferred_name"->"","previous_names"->{""},"title"->"","value"->""}];
ObjectPersistentIdentifier=Association[{"material"->"","schema"->"","source"->"","value"->""}];
ObjectPosition=Association[{"curated_relation"->False,"current"->False,"end_date"->"","institution"->"","rank"->"","record"->ObjectJSONReference,"start_date"->""}];
ObjectProjectMembership=Association[{"curated_relation"->False,"current"->False,"end_date"->"","name"->"","record"->ObjectJSONReference,"start_date"->""}];
ObjectPublicationInfo=Association[{"artid"->"","cnum"->"","conf_acronym"->"","conference_record"->ObjectJSONReference,"curated_relation"->False,
									"hidden"->False,"journal_issue"->"","journal_record"->ObjectJSONReference,"journal_title"->"","journal_volume"->"",
									"material"->"","page_end"->"","page_start"->"","parent_isbn"->"","parent_record"->ObjectJSONReference,
									"parent_report_number"->"","pubinfo_freetext"->"","year"->0}];
ObjectRawRefs=Association[{"schema"->"","source"->"","value"->""}];
ObjectRecordsFiles=Association[{"bucket"->"","checksum"->"","file_id"->"","filename"->"","key"->"","size"->0,"version_id"->""}];
ObjectReferences=Association[{"curated_relation"->False,"legacy_curated"->False,"raw_refs"->{ObjectRawRefs},"record"->ObjectJSONReference,"reference"->ObjectReference}];
ObjectReference=Association[{"arxiv_eprint"->"","authors"->{ObjectReferenceAuthors},"book_series"->ObjectBookSeries,"collaborations"->{""},"document_type"->"","dois"->{""},
								"external_system_identifiers"->{ObjectID},"imprint"->ObjectImprints,"isbn"->"","label"->"","misc"->{""},"persistent_identifiers"->{ObjectID},
								"publication_info"->ObjectReferencePublicationInfo,"report_numbers"->{""},"texkey"->"","title"->ObjectTitle,"urls"->ObjectURL}];
ObjectReferenceAuthors=Association[{"full_name"->"","inspire_role"->""}];
ObjectReferencePublicationInfo=Association[{"artid"->"","cnum"->"","journal_issue"->"","journal_record"->ObjectJSONReference,"journal_title"->"","journal_volume"->"",
											"material"->"","page_end"->"","page_start"->"","parent_isbn"->"","parent_report_number"->"","parent_title"->"","year"->0}];
ObjectRelatedRecord=Association[{"curated_relation"->False,"record"->ObjectJSONReference,"relation"->"","relation_freetext"->""}];
ObjectReportNumber=Association[{"hidden"->False,"source"->"","value"->""}];
ObjectSourcedValue=Association[{"source"->"","value"->""}];
ObjectThesisInfo=Association[{"date"->"","defense_date"->"","degree_type"->"","institutions"->{ObjectInstitution}}];
ObjectTitle=Association[{"source"->"","subtitle"->"","title"->""}];
ObjectTitleTranslation=Association[{"language"->"","source"->"","subtitle"->"","title"->""}];
ObjectURL=Association[{"description"->"","value"->""}];


(* ::Subsection:: *)
(*HEP records*)


(* ::Subsubsection:: *)
(*Schema: HEP records*)


(* ::Text:: *)
(*Literature: Functions to extract all necessary information from each JSON entry (exact replica of Inspire Schema)*)


(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#schema*)
HEPSchema[entry_]:=entry[["metadata","$schema"]]/.Missing["KeyAbsent",x__]:>""; 

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#bucket*)
HEPBucket[entry_]:=entry[["metadata","_bucket"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#collections*)
HEPCollections[entry_]:=entry[["metadata","_collections"]]/.Missing["KeyAbsent",x__]:>{""};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#desy-bookkeeping*)
HEPDESYBookkeeping[entry_]:=Module[{tmp},tmp=entry[["metadata","_desy_bookkeeping"]];If[Not@StringContainsQ[ToString[tmp],"Missing"],tmp,{ObjectDESYBookkeeping}]];
	HEPDESYBookkeepingDate[entry_]:=(#[["date"]]&/@HEPDESYBookkeeping[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPDESYBookkeepingExpert[entry_]:=(#[["expert"]]&/@HEPDESYBookkeeping[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPDESYBookkeepingIdentifier[entry_]:=(#[["identifier"]]&/@HEPDESYBookkeeping[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPDESYBookkeepingStatus[entry_]:=(#[["status"]]&/@HEPDESYBookkeeping[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPDESYBookkeepingArray[entry_]:=Transpose@{HEPDESYBookkeepingDate[entry],HEPDESYBookkeepingExpert[entry],HEPDESYBookkeepingIdentifier[entry],HEPDESYBookkeepingStatus[entry]};
		
(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#export-to*)
HEPExportTo[entry_]:=entry[["metadata","_export_to"]]/.Missing["KeyAbsent",x__]:>ObjectExportTo;
	HEPExportToCDS[entry_]:=HEPExportTo[entry][["CDS"]]/.Missing["KeyAbsent",x__]:>False;
	HEPExportToHAL[entry_]:=HEPExportTo[entry][["HAL"]]/.Missing["KeyAbsent",x__]:>False;
		HEPExportToArray[entry_]:={HEPExportToCDS[entry],HEPExportToHAL[entry]};
		
(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#files*)
HEPFiles[entry_]:=entry[["metadata","_files"]]/.Missing["KeyAbsent",x__]:>{ObjectRecordsFiles};
	HEPFilesBucket[entry_]:=(#[["bucket"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesChecksum[entry_]:=(#[["checksum"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesFileID[entry_]:=(#[["file_id"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesFilename[entry_]:=(#[["filename"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesKey[entry_]:=(#[["key"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesSize[entry_]:=(#[["size"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPFilesVersionID[entry_]:=(#[["version_id"]]&/@HEPFiles[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPFilesArray[entry_]:=Transpose@{HEPFilesBucket[entry],HEPFilesChecksum[entry],HEPFilesFileID[entry],HEPFilesFilename[entry],HEPFilesKey[entry],HEPFilesSize[entry],HEPFilesVersionID[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#private-notes*)
HEPPrivateNotes[entry_]:=entry[["metadata","_private_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	HEPPrivateNotesSource[entry_]:=(#[["source"]]&/@HEPPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPrivateNotesValue[entry_]:=(#[["value"]]&/@HEPPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPPrivateNotesArray[entry_]:=Transpose@{HEPPrivateNotesSource[entry],HEPPrivateNotesValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#abstracts*)
HEPAbstracts[entry_]:=entry[["metadata","abstracts"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	HEPAbstractsSource[entry_]:=(#[["source"]]&/@HEPAbstracts[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAbstractsValue[entry_]:=(#[["value"]]&/@HEPAbstracts[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPAbstractsArray[entry_]:=Transpose@{HEPAbstractsSource[entry],HEPAbstractsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#accelerator-experiments*)
HEPAcceleratorExperiments[entry_]:=entry[["metadata","accelerator_experiments"]]/.Missing["KeyAbsent",x__]:>{ObjectAcceleratorExperiments};
	HEPAcceleratorExperimentsAccelerator[entry_]:=(#[["accelerator"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAcceleratorExperimentsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPAcceleratorExperimentsExperiment[entry_]:=(#[["experiment"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAcceleratorExperimentsInstitution[entry_]:=(#[["institution"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAcceleratorExperimentsLegacyName[entry_]:=(#[["legacy_name"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAcceleratorExperimentsRecord[entry_]:=(#[["record"]]&/@HEPAcceleratorExperiments[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPAcceleratorExperimentsRecordRef[entry_]:=#[["$ref"]]&/@HEPAcceleratorExperimentsRecord[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPAcceleratorExperimentsArray[entry_]:=Transpose@{HEPAcceleratorExperimentsAccelerator[entry],HEPAcceleratorExperimentsCuratedRelation[entry],
															HEPAcceleratorExperimentsExperiment[entry],HEPAcceleratorExperimentsInstitution[entry],
															HEPAcceleratorExperimentsLegacyName[entry],HEPAcceleratorExperimentsRecordRef[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#acquisition-source*)
HEPAcquisitionSource[entry_]:=entry[["metadata","acquisition_source"]]/.Missing["KeyAbsent",x__]:>ObjectAcquisitionSource;
	HEPAcquisitionSourceDateTime[entry_]:=HEPAcquisitionSource[entry][["datetime"]]/.Missing["KeyAbsent",x__]:>"";
	HEPAcquisitionSourceEmail[entry_]:=HEPAcquisitionSource[entry][["email"]]/.Missing["KeyAbsent",x__]:>"";
	HEPAcquisitionSourceInternalUID[entry_]:=HEPAcquisitionSource[entry][["internal_uid"]]/.Missing["KeyAbsent",x__]:>0;
	HEPAcquisitionSourceMethod[entry_]:=HEPAcquisitionSource[entry][["method"]]/.Missing["KeyAbsent",x__]:>"";
	HEPAcquisitionSourceORCID[entry_]:=HEPAcquisitionSource[entry][["orcid"]]/.Missing["KeyAbsent",x__]:>"";
	HEPAcquisitionSourceSource[entry_]:=HEPAcquisitionSource[entry][["source"]]/.Missing["KeyAbsent",x__]:>"";	
	HEPAcquisitionSourceSubmissionNumber[entry_]:=HEPAcquisitionSource[entry][["submission_number"]]/.Missing["KeyAbsent",x__]:>"";
		HEPAcquisitionSourceArray[entry_]:={HEPAcquisitionSourceDateTime[entry],HEPAcquisitionSourceEmail[entry],
											HEPAcquisitionSourceInternalUID[entry],HEPAcquisitionSourceMethod[entry],
											HEPAcquisitionSourceORCID[entry],HEPAcquisitionSourceSource[entry],
											HEPAcquisitionSourceSubmissionNumber[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#arxiv-eprints*)
HEPArXivEprints[entry_]:=entry[["metadata","arxiv_eprints"]]/.Missing["KeyAbsent",x__]:>{ObjectArXivEprint};
	HEPArXivEprintsCategories[entry_]:=(#[["categories"]]&/@HEPArXivEprints[entry])/.Missing["KeyAbsent",x__]:>{""};
	HEPArXivEprintsValue[entry_]:=(#[["value"]]&/@HEPArXivEprints[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPArXivEprintsArray[entry_]:=Transpose@{HEPArXivEprintsCategories[entry],HEPArXivEprintsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#authors*)
HEPAuthors[entry_]:=entry[["metadata","authors"]]/.Missing["KeyAbsent",x__]:>{ObjectAuthors};
	HEPAuthorsAffiliations[entry_]:=(#[["affiliations"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{ObjectAffiliations};
		HEPAuthorsAffiliationsCuratedRelation[entry_]:=((#[["curated_relation"]]&/@#)&/@HEPAuthorsAffiliations[entry])/.Missing["KeyAbsent",x__]:>False;
		HEPAuthorsAffiliationsRecord[entry_]:=((#[["record"]]&/@#)&/@HEPAuthorsAffiliations[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		HEPAuthorsAffiliationsRecordRef[entry_]:=((#[["$ref"]]&/@#)&/@HEPAuthorsAffiliationsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPAuthorsAffiliationsValue[entry_]:=((#[["value"]]&/@#)&/@HEPAuthorsAffiliations[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPAuthorsAffiliationsArray[entry_]:=Transpose@{HEPAuthorsAffiliationsCuratedRelation[entry],HEPAuthorsAffiliationsRecordRef[entry],HEPAuthorsAffiliationsValue[entry]};
	HEPAuthorsAlternativeNames[entry_]:=(#[["alternative_names"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{""};
	HEPAuthorsCreditRoles[entry_]:=(#[["credit_roles"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{""};
	HEPAuthorsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPAuthorsEmails[entry_]:=(#[["emails"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{""};
	HEPAuthorsFullName[entry_]:=(#[["full_name"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAuthorsIDs[entry_]:=(#[["ids"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{ObjectID};
		HEPAuthorsIDsSchema[entry_]:=((#[["schema"]]&/@#)&/@HEPAuthorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPAuthorsIDsValue[entry_]:=((#[["value"]]&/@#)&/@HEPAuthorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPAuthorsIDsArray[entry_]:=Transpose@{HEPAuthorsIDsSchema[entry],HEPAuthorsIDsValue[entry]};
	HEPAuthorsInspireRoles[entry_]:=(#[["inspire_roles"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{""};
	HEPAuthorsRawAffiliations[entry_]:=(#[["raw_affiliations"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
		HEPAuthorsRawAffiliationsSource[entry_]:=((#[["source"]]&/@#)&/@HEPAuthorsRawAffiliations[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPAuthorsRawAffiliationsValue[entry_]:=((#[["value"]]&/@#)&/@HEPAuthorsRawAffiliations[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPAuthorsRawAffiliationsArray[entry_]:=Transpose@{HEPAuthorsRawAffiliationsSource[entry],HEPAuthorsRawAffiliationsValue[entry]};
	HEPAuthorsRecord[entry_]:=(#[["record"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPAuthorsRecordRef[entry_]:=#[["$ref"]]&/@HEPAuthorsRecord[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPAuthorsSignatureBlock[entry_]:=(#[["signature_block"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPAuthorsUUID[entry_]:=(#[["uuid"]]&/@HEPAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPAuthorsArray[entry_]:=Transpose@{HEPAuthorsAffiliationsArray[entry],HEPAuthorsAlternativeNames[entry],HEPAuthorsCreditRoles[entry],
											HEPAuthorsCuratedRelation[entry],HEPAuthorsEmails[entry],HEPAuthorsFullName[entry],HEPAuthorsIDsArray[entry],
											HEPAuthorsInspireRoles[entry],HEPAuthorsRawAffiliationsArray[entry],HEPAuthorsRecordRef[entry],
											HEPAuthorsSignatureBlock[entry],HEPAuthorsUUID[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#book-series*)
HEPBookSeries[entry_]:=entry[["metadata","book_series"]]/.Missing["KeyAbsent",x__]:>{ObjectBookSeries};
	HEPBookSeriesTitle[entry_]:=(#[["title"]]&/@HEPBookSeries[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPBookSeriesVolume[entry_]:=(#[["volume"]]&/@HEPBookSeries[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPBookSeriesArray[entry_]:=Transpose@{HEPBookSeriesTitle[entry],HEPBookSeriesVolume[entry]};
	
(*Unknown*)
HEPCitations[entry_]:=entry[["metadata","citation_count"]]/.Missing["KeyAbsent",x__]:>-1;

(*Unknown*)
HEPCitationsNoSelf[entry_]:=entry[["metadata","citation_count_without_self_citations"]]/.Missing["KeyAbsent",x__]:>-1;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#citeable*)
HEPCiteable[entry_]:=entry[["metadata","citeable"]]/.Missing["KeyAbsent",x__]:>False;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#collaborations*)
HEPCollaborations[entry_]:=entry[["metadata","collaborations"]]/.Missing["KeyAbsent",x__]:>{ObjectCollaborations};
	HEPCollaborationsRecord[entry_]:=(#[["record"]]&/@HEPCollaborations[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPCollaborationsRecordRef[entry_]:=#[["$ref"]]&/@HEPCollaborationsRecord[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPCollaborationsValue[entry_]:=(#[["value"]]&/@HEPCollaborations[entry])/.Missing["c",x__]:>"";
		HEPCollaborationsArray[entry_]:=Transpose@{HEPCollaborationsRecordRef[entry],HEPCollaborationsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#control-number*)
HEPControlNumber[entry_]:=entry[["metadata","control_number"]]/.Missing["KeyAbsent",x__]:>-1;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#copyright*)
HEPCopyright[entry_]:=entry[["metadata","copyright"]]/.Missing["KeyAbsent",x__]:>{ObjectCopyright};
	HEPCopyrightHolder[entry_]:=(#[["holder"]]&/@HEPCopyright[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPCopyrightMaterial[entry_]:=(#[["material"]]&/@HEPCopyright[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPCopyrightStatement[entry_]:=(#[["state,emt"]]&/@HEPCopyright[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPCopyrightURL[entry_]:=(#[["url"]]&/@HEPCopyright[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPCopyrightYear[entry_]:=(#[["year"]]&/@HEPCopyright[entry])/.Missing["KeyAbsent",x__]:>0;	
		HEPCopyrightArray[entry_]:=Transpose@{HEPCopyrightHolder[entry],HEPCopyrightMaterial[entry],HEPCopyrightStatement[entry],HEPCopyrightURL[entry],HEPCopyrightYear[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#core*)
HEPCore[entry_]:=entry[["metadata","core"]]/.Missing["KeyAbsent",x__]:>False;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#corporate-author*)
HEPCorporateAuthor[entry_]:=entry[["metadata","corporate_author"]]/.Missing["KeyAbsent",x__]:>{""};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#curated*)
HEPCurated[entry_]:=entry[["metadata","curated"]]/.Missing["KeyAbsent",x__]:>False;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#deleted*)
HEPDeleted[entry_]:=entry[["metadata","deleted"]]/.Missing["KeyAbsent",x__]:>False;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#deleted-records*)
HEPDeletedRecords[entry_]:=entry[["metadata","deleted_records"]]/.Missing["KeyAbsent",x__]:>{ObjectJSONReference};
	HEPDeletedRecordsRef[entry_]:=#[["$ref"]]&/@HEPDeletedRecords[entry]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#document-type*)
HEPDocumentType[entry_]:=entry[["metadata","document_type"]]/.Missing["KeyAbsent",x__]:>{""};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#documents*)
HEPDocuments[entry_]:=entry[["metadata","documents"]]/.Missing["KeyAbsent",x__]:>{ObjectDocument};
	HEPDocumentsDescription[entry_]:=#[["description"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsFilename[entry_]:=#[["filename"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsFulltext[entry_]:=#[["fulltext"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>False;
	HEPDocumentsHidden[entry_]:=#[["hidden"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>False;
	HEPDocumentsKey[entry_]:=#[["key"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsMaterial[entry_]:=#[["material"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsOriginalURL[entry_]:=#[["original_url"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsSource[entry_]:=#[["source"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPDocumentsURL[entry_]:=#[["url"]]&/@HEPDocuments[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPDocumentsArray[entry_]:=Transpose@{HEPDocumentsDescription[entry],HEPDocumentsFilename[entry],HEPDocumentsFulltext[entry],
												HEPDocumentsHidden[entry],HEPDocumentsKey[entry],HEPDocumentsMaterial[entry],
												HEPDocumentsOriginalURL[entry],HEPDocumentsSource[entry],HEPDocumentsURL[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#dois*)
HEPDOIs[entry_]:=entry[["metadata","dois"]]/.Missing["KeyAbsent",x__]:>{ObjectDOI};
	HEPDOIsMaterial[entry_]:=(#[["material"]]&/@HEPDOIs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPDOIsSource[entry_]:=(#[["source"]]&/@HEPDOIs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPDOIsValue[entry_]:=(#[["value"]]&/@HEPDOIs[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPDOIsArray[entry_]:=Transpose@{HEPDOIsMaterial[entry],HEPDOIsSource[entry],HEPDOIsValue[entry]};

(*unknown*)
HEPEarliestDate[entry_]:=entry[["metadata","date"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#editions*)
HEPEditions[entry_]:=entry[["metadata","editions"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#energy-ranges*)
HEPEnergyRanges[entry_]:=entry[["metadata","energy_ranges"]]/.Missing["KeyAbsent",x__]:>{""};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#external-system-identifiers*)
HEPExternalSystemIdentifiers[entry_]:=entry[["metadata","external_system_identifiers"]]/.Missing["KeyAbsent",x__]:>{ObjectID};
	HEPExternalSystemIdentifiersSchema[entry_]:=#[["schema"]]&/@HEPExternalSystemIdentifiers[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPExternalSystemIdentifiersValue[entry_]:=#[["value"]]&/@HEPExternalSystemIdentifiers[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPExternalSystemIdentifiersArray[entry_]:=Transpose@{HEPExternalSystemIdentifiersSchema[entry],HEPExternalSystemIdentifiersValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#figures*)
HEPFigures[entry_]:=entry[["metadata","figures"]]/.Missing["KeyAbsent",x__]:>{ObjectFigure};
	HEPFiguresCaption[entry_]:=#[["caption"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresFilename[entry_]:=#[["filename"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresKey[entry_]:=#[["key"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresLabel[entry_]:=#[["label"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresMaterial[entry_]:=#[["material"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";	
	HEPFiguresOriginalURL[entry_]:=#[["original_url"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresSource[entry_]:=#[["source"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFiguresURL[entry_]:=#[["url"]]&/@HEPFigures[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPFiguresArray[entry_]:=Transpose@{HEPFiguresCaption[entry],HEPFiguresFilename[entry],HEPFiguresKey[entry],
											HEPFiguresLabel[entry],HEPFiguresMaterial[entry],HEPFiguresOriginalURL[entry],
											HEPFiguresSource[entry],HEPFiguresURL[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#funding-info*)
HEPFundingInfo[entry_]:=entry[["metadata","funding_info"]]/.Missing["KeyAbsent",x__]:>{ObjectFundingInfo};
	HEPFundingInfoAgency[entry_]:=#[["agency"]]&/@HEPFundingInfo[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFundingInfoGrantNumber[entry_]:=#[["grant_number"]]&/@HEPFundingInfo[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPFundingInfoProjectNumber[entry_]:=#[["project_number"]]&/@HEPFundingInfo[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPFundingInfoArray[entry_]:=Transpose@{HEPFundingInfoAgency[entry],HEPFundingInfoGrantNumber[entry],HEPFundingInfoProjectNumber[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#imprints*)
HEPImprints[entry_]:=entry[["metadata","imprints"]]/.Missing["KeyAbsent",x__]:>{ObjectImprints};
	HEPImprintsDate[entry_]:=#[["date"]]&/@HEPImprints[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPImprintsPlace[entry_]:=#[["place"]]&/@HEPImprints[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPImprintsPublisher[entry_]:=#[["publisher"]]&/@HEPImprints[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPImprintsArray[entry_]:=Transpose@{HEPImprintsDate[entry],HEPImprintsPlace[entry],HEPImprintsPublisher[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#inspire-categories*)
HEPInspireCategories[entry_]:=entry[["metadata","inspire_categories"]]/.Missing["KeyAbsent",x__]:>{ObjectInspireField};
	HEPInspireCategoriesSource[entry_]:=#[["source"]]&/@HEPInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	HEPInspireCategoriesTerm[entry_]:=#[["term"]]&/@HEPInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
		HEPInspireCategoriesArray[entry_]:=Transpose@{HEPInspireCategoriesSource[entry],HEPInspireCategoriesTerm[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#isbns*)
HEPISBNs[entry_]:=entry[["metadata","isbns"]]/.Missing["KeyAbsent",x__]:>{ObjectISBN};
	HEPISBNsMedium[entry_]:=(#[["medium"]]&/@HEPISBNs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPISBNsValue[entry_]:=(#[["value"]]&/@HEPISBNs[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPISBNsArray[entry_]:=Transpose@{HEPISBNsMedium[entry],HEPISBNsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#keywords*)
HEPKeywords[entry_]:=entry[["metadata","keywords"]]/.Missing["KeyAbsent",x__]:>{ObjectKeyword};
	HEPKeywordsSchema[entry_]:=(#[["schema"]]&/@HEPKeywords[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPKeywordsSource[entry_]:=(#[["source"]]&/@HEPKeywords[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPKeywordsValue[entry_]:=(#[["value"]]&/@HEPKeywords[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPKeywordsArray[entry_]:=Transpose@{HEPKeywordsSchema[entry],HEPKeywordsSource[entry],HEPKeywordsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#languages  ISO 639-1 alpha 2 language code*)
HEPLanguages[entry_]:=entry[["metadata","languages"]]/.Missing["KeyAbsent",x__]:>{"en"};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#legacy-creation-date*)
HEPLegacyCreationDate[entry_]:=entry[["metadata","legacy_creation_date"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#legacy-version*)
HEPLegacyVersion[entry_]:=entry[["metadata","legacy_version"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#license*)
HEPLicense[entry_]:=entry[["metadata","license"]]/.Missing["KeyAbsent",x__]:>{ObjectLicense};
	HEPLicenseImposing[entry_]:=(#[["imposing"]]&/@HEPLicense[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPLicenseLicense[entry_]:=(#[["license"]]&/@HEPLicense[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPLicenseMaterial[entry_]:=(#[["material"]]&/@HEPLicense[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPLicenseURL[entry_]:=(#[["url"]]&/@HEPLicense[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPLicenseArray[entry_]:=Transpose@{HEPLicenseImposing[entry],HEPLicenseLicense[entry],HEPLicenseMaterial[entry],HEPLicenseURL[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#new-record*)
HEPNewRecord[entry_]:=entry[["metadata","new_record"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPNewRecordRef[entry_]:=HEPNewRecord[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
	
(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#number-of-pages*)
HEPNumberOfPages[entry_]:=entry[["metadata","number_of_pages"]]/.Missing["KeyAbsent",x__]:>0;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#persistent-identifiers*)
HEPPersistentIdentifiers[entry_]:=entry[["metadata","persistent_identifiers"]]/.Missing["KeyAbsent",x__]:>{ObjectPersistentIdentifier};
	HEPPersistentIdentifiersMaterial[entry_]:=(#[["material"]]&/@HEPPersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPersistentIdentifiersSchema[entry_]:=(#[["schema"]]&/@HEPPersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPersistentIdentifiersSource[entry_]:=(#[["source"]]&/@HEPPersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPersistentIdentifiersValue[entry_]:=(#[["value"]]&/@HEPPersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPPersistentIdentifiersArray[entry_]:=Transpose@{HEPPersistentIdentifiersMaterial[entry],HEPPersistentIdentifiersSchema[entry],
															HEPPersistentIdentifiersSource[entry],HEPPersistentIdentifiersValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#preprint-date*)
HEPPreprintDate[entry_]:=entry[["metadata","preprint_date"]]/.Missing["KeyAbsent",x__]:>"";

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#public-notes*)
HEPPublicNotes[entry_]:=entry[["metadata","public_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	HEPPublicNotesSource[entry_]:=(#[["source"]]&/@HEPPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicNotesValue[entry_]:=(#[["value"]]&/@HEPPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPPublicNotesArray[entry_]:=Transpose@{HEPPublicNotesSource[entry],HEPPublicNotesValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#publication-info*)
HEPPublicationInfo[entry_]:=entry[["metadata","publication_info"]]/.Missing["KeyAbsent",x__]:>{ObjectPublicationInfo};
	HEPPublicationInfoArtID[entry_]:=(#[["artid"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoCnum[entry_]:=(#[["cnum"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoConfAcronym[entry_]:=(#[["conf_acronym"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoConferenceRecord[entry_]:=(#[["conference_record"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPPublicationInfoConferenceRecordRef[entry_]:=(#[["$ref"]]&/@HEPPublicationInfoConferenceRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPPublicationInfoHidden[entry_]:=(#[["hidden"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPPublicationInfoJournalIssue[entry_]:=(#[["journal_issue"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoJournalRecord[entry_]:=(#[["journal_record"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPPublicationInfoJournalRecordRef[entry_]:=(#[["$ref"]]&/@HEPPublicationInfoJournalRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoJournalTitle[entry_]:=(#[["journal_title"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoJournalVolume[entry_]:=(#[["journal_volume"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoMaterial[entry_]:=(#[["material"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoPageEnd[entry_]:=(#[["page_end"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoPageStart[entry_]:=(#[["page_start"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoParentISBN[entry_]:=(#[["parent_isbn"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoParentRecord[entry_]:=(#[["parent_record"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPPublicationInfoParentRecordRef[entry_]:=(#[["$ref"]]&/@HEPPublicationInfoParentRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoParentReportNumber[entry_]:=(#[["parent_report_number"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoPubinfoFreetext[entry_]:=(#[["pubinfo_freetext"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPPublicationInfoYear[entry_]:=(#[["year"]]&/@HEPPublicationInfo[entry])/.Missing["KeyAbsent",x__]:>0;
		HEPPublicationInfoArray[entry_]:=Transpose@{HEPPublicationInfoArtID[entry],HEPPublicationInfoCnum[entry],HEPPublicationInfoConfAcronym[entry],
													HEPPublicationInfoConferenceRecordRef[entry],HEPPublicationInfoCuratedRelation[entry],HEPPublicationInfoHidden[entry],
													HEPPublicationInfoJournalIssue[entry],HEPPublicationInfoJournalRecordRef[entry],HEPPublicationInfoJournalTitle[entry],
													HEPPublicationInfoJournalVolume[entry],HEPPublicationInfoMaterial[entry],HEPPublicationInfoPageEnd[entry],
													HEPPublicationInfoPageStart[entry],HEPPublicationInfoParentISBN[entry],HEPPublicationInfoParentRecordRef[entry],
													HEPPublicationInfoParentReportNumber[entry],HEPPublicationInfoPubinfoFreetext[entry],HEPPublicationInfoYear[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#publication-type*)
HEPPublicationType[entry_]:=entry[["metadata","publication_type"]]/.Missing["KeyAbsent",x__]:>{""};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#record-affiliations*)
HEPRecordAffiliations[entry_]:=entry[["metadata","record_affiliations"]]/.Missing["KeyAbsent",x__]:>{ObjectAffiliations};
	HEPRecordAffiliationsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPRecordAffiliations[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPRecordAffiliationsRecord[entry_]:=(#[["record"]]&/@HEPRecordAffiliations[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	EPRecordAffiliationsRecordRef[entry_]:=(#[["$ref"]]&/@HEPRecordAffiliationsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPRecordAffiliationsValue[entry_]:=(#[["value"]]&/@HEPRecordAffiliations[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPRecordAffiliationsArray[entry_]:=Transpose@{HEPRecordAffiliationsCuratedRelation[entry],EPRecordAffiliationsRecordRef[entry],HEPRecordAffiliationsValue[entry]};

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#refereed*)
HEPRefereed[entry_]:=entry[["metadata","refereed"]]/.Missing["KeyAbsent",x__]:>False;

(*https://inspire-schemas.readthedocs.io/en/latest/schemas/hep.html#references*)
HEPReferences[entry_]:=entry[["metadata","references"]]/.Missing["KeyAbsent",x__]:>{ObjectReferences};
	HEPReferencesCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPReferences[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPReferencesLegacyCurated[entry_]:=(#[["legacy_curated"]]&/@HEPReferences[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPReferencesRawRefs[entry_]:=(#[["raw_refs"]]&/@HEPReferences[entry])/.Missing["KeyAbsent",x__]:>ObjectRawRefs;
		HEPReferencesRawRefsSchema[entry_]:=((#[["schema"]]&/@#)&/@HEPReferencesRawRefs[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesRawRefsSource[entry_]:=((#[["source"]]&/@#)&/@HEPReferencesRawRefs[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesRawRefsValue[entry_]:=((#[["value"]]&/@#)&/@HEPReferencesRawRefs[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesRawRefsArray[entry_]:=(({#[["schema"]],#[["source"]],#[["value"]]}&/@#)&/@HEPReferencesRawRefs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPReferencesArray[entry_]:=Transpose@{HEPReferencesCuratedRelation[entry],HEPReferencesLegacyCurated[entry],HEPReferencesRawRefsArray[entry]};
	HEPReferencesRecord[entry_]:=(#[["record"]]&/@HEPReferences[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPReferencesRecordRef[entry_]:=(#[["$ref"]]&/@HEPReferencesRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPReferencesReference[entry_]:=(#[["reference"]]&/@HEPReferences[entry])/.Missing["KeyAbsent",x__]:>ObjectReference;
		HEPReferencesReferenceArXivEprint[entry_]:=(#[["arxiv_eprint"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceAuthors[entry_]:=(#[["authors"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{ObjectReferenceAuthors};
			HEPReferencesReferenceAuthorsFullName[entry_]:=((#[["full_name"]]&/@#)&/@HEPReferencesReferenceAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceAuthorsInspireRole[entry_]:=((#[["inspire_role"]]&/@#)&/@HEPReferencesReferenceAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
				HEPReferencesReferenceAuthorsArray[entry_]:=(({#[["full_name"]],#[["inspire_role"]]}&/@#)&/@HEPReferencesReferenceAuthors[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceBookSeries[entry_]:=(#[["book_series"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>ObjectBookSeries;
			HEPReferencesReferenceBookSeriesTitle[entry_]:=(#[["title"]]&/@HEPReferencesReferenceBookSeries[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceBookSeriesVolume[entry_]:=(#[["volume"]]&/@HEPReferencesReferenceBookSeries[entry])/.Missing["KeyAbsent",x__]:>"";
				HEPReferencesReferenceBookSeriesArray[entry_]:=({#[["title"]],#[["volume"]]}&/@HEPReferencesReferenceBookSeries[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceCollaborations[entry_]:=(#[["collaborations"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{""};
		HEPReferencesReferenceDocumentType[entry_]:=(#[["document_type"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceDOIs[entry_]:=(#[["dois"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{""};
		HEPReferencesReferenceExternalSystemIdentifiers[entry_]:=(#[["external_system_identifiers"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{ObjectID};
			HEPReferencesReferenceExternalSystemIdentifiersSchema[entry_]:=((#[["schema"]]&/@#)&/@HEPReferencesReferenceExternalSystemIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceExternalSystemIdentifiersValue[entry_]:=((#[["value"]]&/@#)&/@HEPReferencesReferenceExternalSystemIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceExternalSystemIdentifiersArray[entry_]:=(({#[["schema"]],#[["value"]]}&/@#)&/@HEPReferencesReferenceExternalSystemIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceImprint[entry_]:=(#[["imprint"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>ObjectImprints;
			HEPReferencesReferenceImprintDate[entry_]:=(#[["date"]]&/@HEPReferencesReferenceImprint[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceImprintPlace[entry_]:=(#[["place"]]&/@HEPReferencesReferenceImprint[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceImprintPublisher[entry_]:=(#[["publisher"]]&/@HEPReferencesReferenceImprint[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceImprintArray[entry_]:=({#[["date"]],#[["place"]],#[["publisher"]]}&/@HEPReferencesReferenceImprint[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceISBN[entry_]:=(#[["isbn"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceLabel[entry_]:=(#[["label"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceMisc[entry_]:=(#[["misc"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{""};
		HEPReferencesReferencePersistentIdentifiers[entry_]:=(#[["persistent_identifiers"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{ObjectID};
			HEPReferencesReferencePersistentIdentifiersSchema[entry_]:=((#[["schema"]]&/@#)&/@HEPReferencesReferencePersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePersistentIdentifiersValue[entry_]:=((#[["value"]]&/@#)&/@HEPReferencesReferencePersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePersistentIdentifiersArray[entry_]:=(({#[["schema"]],#[["value"]]}&/@#)&/@HEPReferencesReferencePersistentIdentifiers[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferencePublicationInfo[entry_]:=(#[["publication_info"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>ObjectReferencePublicationInfo;
			HEPReferencesReferencePublicationInfoArtID[entry_]:=(#[["artid"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoCnum[entry_]:=(#[["cnum"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoJournalIssue[entry_]:=(#[["journal_issue"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoJournalRecord[entry_]:=(#[["journal_record"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoJournamTitle[entry_]:=(#[["journal_title"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoJournamVolume[entry_]:=(#[["journal_volume"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoMaterial[entry_]:=(#[["material"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoPageEnd[entry_]:=(#[["page_end"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoPageStart[entry_]:=(#[["page_start"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoPartentISBN[entry_]:=(#[["parent_isbn"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoParentReportNumber[entry_]:=(#[["parent_report_number"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoParentTitle[entry_]:=(#[["parent_title"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferencePublicationInfoYear[entry_]:=(#[["year"]]&/@HEPReferencesReferencePublicationInfo[entry])/.Missing["KeyAbsent",x__]:>0;HEPReferencesReferencePublicationInfoArray[entry_]:=Transpose@{HEPReferencesReferencePublicationInfoArtID[entry],HEPReferencesReferencePublicationInfoCnum[entry],HEPReferencesReferencePublicationInfoJournalIssue[entry],HEPReferencesReferencePublicationInfoJournalRecord[entry],HEPReferencesReferencePublicationInfoJournamTitle[entry],HEPReferencesReferencePublicationInfoJournamVolume[entry],HEPReferencesReferencePublicationInfoMaterial[entry],HEPReferencesReferencePublicationInfoPageEnd[entry],HEPReferencesReferencePublicationInfoPageStart[entry],HEPReferencesReferencePublicationInfoPartentISBN[entry],HEPReferencesReferencePublicationInfoParentReportNumber[entry],HEPReferencesReferencePublicationInfoParentTitle[entry],HEPReferencesReferencePublicationInfoYear[entry]};
		HEPReferencesReferenceReportNumbers[entry_]:=(#[["report_numbers"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{""};
		HEPReferencesReferenceTeXKey[entry_]:=(#[["texkey"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceTitle[entry_]:=(#[["title"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>ObjectTitle;
			HEPReferencesReferenceTitleSource[entry_]:=(#[["source"]]&/@HEPReferencesReferenceTitle[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceTitleSubtitle[entry_]:=(#[["subtitle"]]&/@HEPReferencesReferenceTitle[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceTitleTitle[entry_]:=(#[["title"]]&/@HEPReferencesReferenceTitle[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceTitleArray[entry_]:=({#[["source"]],#[["subtitle"]],#[["title"]]}&/@HEPReferencesReferenceTitle[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPReferencesReferenceURLs[entry_]:=(#[["urls"]]&/@HEPReferencesReference[entry])/.Missing["KeyAbsent",x__]:>{ObjectURL};
			HEPReferencesReferenceURLsDescription[entry_]:=((#[["description"]]&/@#)&/@HEPReferencesReferenceURLs[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceURLsValue[entry_]:=((#[["value"]]&/@#)&/@HEPReferencesReferenceURLs[entry])/.Missing["KeyAbsent",x__]:>"";
			HEPReferencesReferenceURLsArray[entry_]:=(({#[["description"]],#[["value"]]}&/@#)&/@HEPReferencesReferenceURLs[entry])/.Missing["KeyAbsent",x__]:>"";
(*HEPReferencesReferenceArray[entry_]:=Transpose@{HEPReferencesReferenceArXivEprint[entry],HEPReferencesReferenceAuthorsArray[entry],HEPReferencesReferenceBookSeriesArray[entry],HEPReferencesReferenceCollaborations[entry],HEPReferencesReferenceDocumentType[entry],HEPReferencesReferenceDOIs[entry],HEPReferencesReferenceExternalSystemIdentifiersArray[entry],HEPReferencesReferenceImprintArray[entry],HEPReferencesReferenceISBN[entry],HEPReferencesReferenceLabel[entry],HEPReferencesReferenceMisc[entry],HEPReferencesReferencePersistentIdentifiersArray[entry],HEPReferencesReferencePublicationInfoArray[entry],HEPReferencesReferenceReportNumbers[entry],HEPReferencesReferenceTeXKey[entry],HEPReferencesReferenceTitleArray[entry],HEPReferencesReferenceURLsArray[entry]};
HEPReferencesArray[entry_]:=Transpose@{HEPReferencesCuratedRelation[entry],HEPReferencesLegacyCurated[entry],HEPReferencesRawRefsArray[entry],HEPReferencesRecordRef[entry],HEPReferencesReferenceArray[entry]};
*)HEPRelatedRecords[entry_]:=entry[["metadata","related_records"]]/.Missing["KeyAbsent",x__]:>{ObjectRelatedRecord};
	HEPRelatedRecordsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPRelatedRecordsRecord[entry_]:=(#[["record"]]&/@HEPRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		HEPRelatedRecordsRecordRef[entry_]:=(#[["$ref"]]&/@HEPRelatedRecordsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPRelatedRecordsRelation[entry_]:=(#[["relation"]]&/@HEPRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPRelatedRecordsRelationFreetext[entry_]:=(#[["relation_freetext"]]&/@HEPRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPRelatedRecordsArray[entry_]:=Transpose@{HEPRelatedRecordsCuratedRelation[entry],HEPRelatedRecordsRecordRef[entry],HEPRelatedRecordsRelation[entry],HEPRelatedRecordsRelationFreetext[entry]};
HEPReportNumbers[entry_]:=entry[["metadata","report_numbers"]]/.Missing["KeyAbsent",x__]:>{ObjectReportNumber};
	HEPReportNumbersHidden[entry_]:=(#[["hidden"]]&/@HEPReportNumbers[entry])/.Missing["KeyAbsent",x__]:>False;
	HEPReportNumbersSource[entry_]:=(#[["source"]]&/@HEPReportNumbers[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPReportNumbersValue[entry_]:=(#[["value"]]&/@HEPReportNumbers[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPReportNumbersArray[entry_]:=Transpose@{HEPReportNumbersHidden[entry],HEPReportNumbersSource[entry],HEPReportNumbersValue[entry]};
HEPSelf[entry_]:=entry[["metadata","self"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	HEPSelfRef[entry_]:=HEPSelf[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
HEPTeXKeys[entry_]:=entry[["metadata","texkeys"]]/.Missing["KeyAbsent",x__]:>{""};
HEPThesisInfo[entry_]:=entry[["metadata","thesis_info"]]/.Missing["KeyAbsent",x__]:>ObjectThesisInfo;
	HEPThesisInfoDate[entry_]:=HEPThesisInfo[entry][["date"]]/.Missing["KeyAbsent",x__]:>"";
	HEPThesisInfoDefenseDate[entry_]:=HEPThesisInfo[entry][["defense_date"]]/.Missing["KeyAbsent",x__]:>"";
	HEPThesisInfoDegreeType[entry_]:=HEPThesisInfo[entry][["degree_type"]]/.Missing["KeyAbsent",x__]:>"";
	HEPThesisInfoInstitutions[entry_]:=HEPThesisInfo[entry][["institutions"]]/.Missing["KeyAbsent",x__]:>{ObjectInstitution};
		HEPThesisInfoInstitutionsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@HEPThesisInfoInstitutions[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPThesisInfoInstitutionsName[entry_]:=(#[["name"]]&/@HEPThesisInfoInstitutions[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPThesisInfoInstitutionsRecord[entry_]:=(#[["record"]]&/@HEPThesisInfoInstitutions[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
			HEPThesisInfoInstitutionsRecordRef[entry_]:=(#[["$ref"]]&/@HEPThesisInfoInstitutionsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
		HEPThesisInfoInstitutionsArray[entry_]:=Transpose@{HEPThesisInfoInstitutionsCuratedRelation[entry],HEPThesisInfoInstitutionsName[entry],HEPThesisInfoInstitutionsRecordRef[entry]};
	HEPThesisInfoArray[entry_]:={HEPThesisInfoDate[entry],HEPThesisInfoDefenseDate[entry],HEPThesisInfoDegreeType[entry],HEPThesisInfoInstitutionsArray[entry]};
HEPTitleTranslations[entry_]:=entry[["metadata","title_translations"]]/.Missing["KeyAbsent",x__]:>{ObjectTitleTranslation};
	HEPTitleTranslationsLanguage[entry_]:=(#[["language"]]&/@HEPTitleTranslations[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitleTranslationsSource[entry_]:=(#[["source"]]&/@HEPTitleTranslations[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitleTranslationsSubtitle[entry_]:=(#[["subtitle"]]&/@HEPTitleTranslations[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitleTranslationsTitle[entry_]:=(#[["title"]]&/@HEPTitleTranslations[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitleTranslationsArray[entry_]:=Transpose@{HEPTitleTranslationsLanguage[entry],HEPTitleTranslationsSource[entry],HEPTitleTranslationsSubtitle[entry],HEPTitleTranslationsTitle[entry]};
HEPTitles[entry_]:=entry[["metadata","titles"]]/.Missing["KeyAbsent",x__]:>{ObjectTitle};
	HEPTitlesSource[entry_]:=(#[["source"]]&/@HEPTitles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitlesSubtitle[entry_]:=(#[["subtitle"]]&/@HEPTitles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitlesTitle[entry_]:=(#[["title"]]&/@HEPTitles[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPTitlesTitleArray[entry_]:=Transpose@{HEPTitlesSource[entry],HEPTitlesSubtitle[entry],HEPTitlesTitle[entry]};
HEPURLs[entry_]:=entry[["metadata","urls"]]/.Missing["KeyAbsent",x__]:>{ObjectURL};
	HEPURLsDescription[entry_]:=(#[["description"]]&/@HEPURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPURLsValue[entry_]:=(#[["value"]]&/@HEPURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	HEPURLsArray[entry_]:=Transpose@{HEPURLsDescription[entry],HEPURLsValue[entry]};
HEPWithdrawn[entry_]:=entry[["metadata","withdrawn"]]/.Missing["KeyAbsent",x__]:>False;
HEPArray[entry_]:=#[entry]&/@{HEPSchema,HEPCollections,HEPDESYBookkeepingArray,HEPExportToArray,HEPFilesArray,HEPAbstractsArray,HEPAcceleratorExperimentsArray,HEPAcquisitionSourceArray,HEPArXivEprintsArray,HEPAuthorsArray,HEPBookSeriesArray,HEPCiteable,HEPCollaborationsArray,HEPControlNumber,HEPCopyrightArray,HEPCore,HEPCorporateAuthor,HEPCurated,HEPDeletedRecordsRef,HEPDocumentType,HEPDocumentsArray,HEPDOIsArray,HEPEarliestDate,HEPEditions,HEPEnergyRanges,HEPExternalSystemIdentifiersArray,HEPFiguresArray,HEPFundingInfoArray,HEPImprintsArray,HEPInspireCategoriesArray,HEPISBNsArray,HEPKeywordsArray,HEPLanguages,HEPLegacyCreationDate,HEPLegacyVersion,HEPLicenseArray,HEPNewRecord,HEPNumberOfPages,HEPPersistentIdentifiersArray,HEPPreprintDate,HEPPublicNotes,HEPPublicationInfoArray,HEPPublicationType,HEPRecordAffiliationsArray,HEPRefereed,HEPReferencesArray,HEPRelatedRecordsArray,HEPReportNumbersArray,HEPSelfRef,HEPTeXKeys,HEPThesisInfoArray,HEPTitleTranslationsArray,HEPTitlesTitleArray,HEPURLsArray,HEPWithdrawn}


(* ::Text:: *)
(*Literature: Functions to extract additional information contained in the brief JSON and not present in the Inspire Schema (number of authors, number of refs)*)


HEPNumberOfAuthors[entry_]:=entry[["metadata","number_of_authors"]]/.Missing["KeyAbsent",x__]:>0;
HEPNumberOfReferences[entry_]:=entry[["metadata","number_of_references"]]/.Missing["KeyAbsent",x__]:>0;
HEPDate[entry_]:=entry[["metadata","date"]]/.Missing["KeyAbsent",x__]:>0;


(* ::Subsubsection:: *)
(*Extract HEP records*)


ExtractHEPAbstract[entry_]:={HEPAbstractsValue[entry][[1]]}/.""->Null;
ExtractHEPArXivCategories[entry_]:=Flatten@HEPArXivEprintsCategories[entry]/.""->Null;
ExtractHEPArXivFirstCategory[entry_]:={ExtractHEPArXivCategories[entry][[1]]}/.""->Null;
ExtractHEPArXivIDs[entry_]:=HEPArXivEprintsValue[entry]/.""->Null;
ExtractHEPAuthorsAffiliationsIDs[entry_]:=ToExpression/@Flatten[StringCases[#,DigitCharacter..]/.{}->Null]&/@HEPAuthorsAffiliationsRecordRef[entry];
(*ExtractHEPAuthorsAffiliationsIDs[entry_]:=ToExpression/@StringDelete[#,Alternatives@@institutionsurls]]&/@HEPAuthorsAffiliationsRecordRef[entry];*)
ExtractHEPAuthorsAffiliationsNames[entry_]:=HEPAuthorsAffiliationsValue[entry]/.""->Null;
ExtractHEPAuthorsAll[entry_]:=Transpose@{ExtractHEPAuthorsIDs[entry],(*ExtractHEPAuthorsInspireNames[entry]*)(*(Cases[#,x_\[RuleDelayed]x\[LeftDoubleBracket]2\[RightDoubleBracket]]&/@HEPAuthorsIDsArray[entry])/.{{""}}\[Rule]Null*)HEPAuthorsIDsValue[entry]/.{""}->Null,ExtractHEPAuthorsFullNames[entry],ExtractHEPAuthorsAffiliationsIDs[entry]/.{Null}->Null,ExtractHEPAuthorsAffiliationsNames[entry]/.{Null}->Null};
ExtractHEPAuthorsCount[entry_]:={HEPNumberOfAuthors[entry]}/. 0->Null;(*to be used with brief JSON*)
ExtractHEPAuthorsFullNames[entry_]:=HEPAuthorsFullName[entry]/.""->Null;
ExtractHEPAuthorsIDs[entry_]:=ToExpression[Flatten[StringCases[HEPAuthorsRecordRef[entry],DigitCharacter..]/.{}->Null]];
(*ExtractHEPAuthorsIDs[entry_]:=ToExpression[StringDelete[HEPAuthorsRecordRef[entry],Alternatives@@authorsurls]];*)
ExtractHEPAuthorsInspireNames[entry_]:=(Cases[#,x_/;x[[1]]=="INSPIRE BAI":>x[[2]]]&/@HEPAuthorsIDsArray[entry])/.{}->{Null};
ExtractHEPCitations[entry_]:={HEPCitations[entry]};
ExtractHEPCitationsNoSelf[entry_]:={HEPCitationsNoSelf[entry]};
ExtractHEPCiteableFlag[entry_]:={HEPCiteable[entry]};
(*ExtractHEPCitationsCount[entry_]:=Quiet[Check[{entry\[LeftDoubleBracket]"metadata","citation_count"\[RightDoubleBracket]/.Missing["KeyAbsent",x__]\[RuleDelayed]Null},0]];*)
ExtractHEPCollaborationsIDs[entry_]:=ToExpression[Flatten[StringCases[HEPCollaborationsRecordRef[entry],DigitCharacter..]/.{}->Null]];
ExtractHEPCollaborationsValues[entry_]:=HEPCollaborationsValue[entry]/.""->Null;
ExtractHEPCollaborationsAll[entry_]:=Transpose@{ExtractHEPCollaborationsIDs[entry],ExtractHEPCollaborationsValues[entry]};
ExtractHEPCore[entry_]:={HEPCore[entry]};
ExtractHEPCurated[entry_]:={HEPCurated[entry]};
ExtractHEPDateCreated[entry_]:=RecordCreated[entry]/.""->{Null};
ExtractHEPDateUpdated[entry_]:=RecordUpdated[entry]/.""->{Null};
ExtractHEPDocumentTypes[entry_]:=HEPDocumentType[entry]/.""->Null;
ExtractHEPDOIs[entry_]:=HEPDOIsValue[entry]/.""->Null;
ExtractHEPEarliestDate[entry_]:=HEPEarliestDate[entry]/.""->{Null};
ExtractHEPExperimentsIDs[entry_]:=ToExpression[Flatten[StringCases[HEPAcceleratorExperimentsRecordRef[entry],DigitCharacter..]/.{}->Null]];
ExtractHEPExperimentsLegacyName[entry_]:=HEPAcceleratorExperimentsLegacyName[entry]/.""->Null;
ExtractHEPExperimentsAll[entry_]:= Transpose@{ExtractHEPExperimentsIDs[entry],ExtractHEPExperimentsLegacyName[entry]};
ExtractHEPExternalIDs[entry_]:=HEPExternalSystemIdentifiersArray[entry]/.""->Null;
ExtractHEPExternalURLs[entry_]:=HEPURLsArray[entry]/.""->Null;
ExtractHEPID[entry_]:={RecordID[entry]};
ExtractHEPInspireCategories[entry_]:=HEPInspireCategoriesTerm[entry]/.""->Null;
ExtractHEPISBNs[entry_]:=HEPISBNsValue[entry]/.""->Null;
ExtractHEPJournalArtID[entry_]:={HEPPublicationInfoArtID[entry]}/. ""->Null;
ExtractHEPJournalDate[entry_]:={HEPPublicationInfoYear[entry]/. ""->{Null}};
ExtractHEPJournalID[entry_]:={ToExpression[Flatten[StringCases[HEPPublicationInfoJournalRecordRef[entry],DigitCharacter..]/.{}->Null]]};
(*ExtractHEPJournalID[entry_]:={ToExpression[StringDelete[HEPPublicationInfoJournalRecordRef[entry],Alternatives@@journalsurls]]};*)
ExtractHEPJournalIssue[entry_]:={HEPPublicationInfoJournalIssue[entry]}/.""->Null;
ExtractHEPJournalName[entry_]:={HEPPublicationInfoJournalTitle[entry]}/.""->Null;
ExtractHEPJournalPageEnd[entry_]:={HEPPublicationInfoPageEnd[entry]}/.""->Null;
ExtractHEPJournalPageStart[entry_]:={HEPPublicationInfoPageStart[entry]}/.""->Null;
ExtractHEPJournalVolume[entry_]:={HEPPublicationInfoJournalVolume[entry]}/.""->Null;
ExtractHEPKeywords[entry_]:=HEPKeywordsValue[entry]/.""->Null;
ExtractHEPPreprintDate[entry_]:=HEPPreprintDate[entry]/.""->{Null};
ExtractHEPNumberofPages[entry_]:={HEPNumberOfPages[entry]}/. 0->Null;(*to be used with brief JSON*)
ExtractHEPNumberofFigures[entry_]:={Length[HEPFiguresArray[entry]/.{{"","","","","",""}}->Null]};
ExtractHEPPublicationType[entry_]:=HEPPublicationType[entry]/.""->Null;
ExtractHEPReferences[entry_]:=DeleteCases[ToExpression[Flatten[StringCases[DeleteCases[HEPReferencesRecordRef[entry],x_/;StringContainsQ[x,"data"]],DigitCharacter..]/.{}->Null]],Null];
(*ExtractHEPReferences[entry_]:=DeleteCases[ToExpression[StringDelete[DeleteCases[HEPReferencesRecordRef[entry],x_/;StringContainsQ[x,"data"]],Alternatives@@literatureurls]],Null];*)
ExtractHEPReferencesCount[entry_]:={HEPNumberOfReferences[entry]}; (*to be used with brief JSON*)
ExtractHEPReferencesCount2[entry_]:={ExtractHEPReferences[entry]//Length};
ExtractHEPRefereedFlag[entry_]:={HEPRefereed[entry]};
ExtractHEPReportNumbers[entry_]:=HEPReportNumbersValue[entry]/.""->Null;
ExtractHEPTeXKeys[entry_]:=HEPTeXKeys[entry]/.""->Null;
ExtractHEPThesisInfo[entry_]:=HEPThesisInfoArray[entry]/.""->Null/.{Null,Null,Null,{{False,Null,Null}}}->{Null};
ExtractHEPTitle[entry_]:={HEPTitlesTitle[entry][[1]]}/.""->Null;
ExtractHEPURL[entry_]:={HEPSelfRef[entry]}/.""->Null;
ExtractHEPWithdrawnFlag[entry_]:={HEPWithdrawn[entry]}/.False->Null;


(* ::Subsection:: *)
(*Authors records*)


(* ::Subsubsection:: *)
(*Schema: Authors records*)


(* ::Text:: *)
(*Authors: Functions to extract all necessary information from each JSON entry (exact replica of Inspire Schema)*)


AuthorsSchema[entry_]:=entry[["metadata","$schema"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsCollections[entry_]:=entry[["metadata","_collections"]]/.Missing["KeyAbsent",x__]:>{""};
AuthorsPrivateNotes[entry_]:=entry[["metadata","_private_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	AuthorsPrivateNotesSource[entry_]:=(#[["source"]]&/@AuthorsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsPrivateNotesValue[entry_]:=(#[["value"]]&/@AuthorsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsPrivateNotesArray[entry_]:=Transpose@{AuthorsPrivateNotesSource[entry],AuthorsPrivateNotesValue[entry]};
AuthorsAcquisitionSource[entry_]:=entry[["metadata","acquisition_source"]]/.Missing["KeyAbsent",x__]:>ObjectAcquisitionSource;
	AuthorsAcquisitionSourceDateTime[entry_]:=AuthorsAcquisitionSource[entry][["datetime"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsAcquisitionSourceEmail[entry_]:=AuthorsAcquisitionSource[entry][["email"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsAcquisitionSourceInternalUID[entry_]:=AuthorsAcquisitionSource[entry][["internal_uid"]]/.Missing["KeyAbsent",x__]:>0;
	AuthorsAcquisitionSourceMethod[entry_]:=AuthorsAcquisitionSource[entry][["method"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsAcquisitionSourceORCID[entry_]:=AuthorsAcquisitionSource[entry][["orcid"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsAcquisitionSourceSource[entry_]:=AuthorsAcquisitionSource[entry][["source"]]/.Missing["KeyAbsent",x__]:>"";	
	AuthorsAcquisitionSourceSubmissionNumber[entry_]:=AuthorsAcquisitionSource[entry][["submission_number"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsAcquisitionSourceArray[entry_]:={AuthorsAcquisitionSourceDateTime[entry],AuthorsAcquisitionSourceEmail[entry],AuthorsAcquisitionSourceInternalUID[entry],AuthorsAcquisitionSourceMethod[entry],AuthorsAcquisitionSourceORCID[entry],AuthorsAcquisitionSourceSource[entry],AuthorsAcquisitionSourceSubmissionNumber[entry]};
AuthorsAdvisors[entry_]:=entry[["metadata","advisors"]]/.Missing["KeyAbsent",x__]:>{ObjectAdvisors};
	AuthorsAdvisorsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@AuthorsAdvisors[entry])/.Missing["KeyAbsent",x__]:>False;
	AuthorsAdvisorsDegreeType[entry_]:=(#[["degree_type"]]&/@AuthorsAdvisors[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsAdvisorsIDs[entry_]:=(#[["ids"]]&/@AuthorsAdvisors[entry])/.Missing["KeyAbsent",x__]:>{ObjectID};
		AuthorsAdvisorsIDsSchema[entry_]:=((#[["schema"]]&/@#)&/@AuthorsAdvisorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsAdvisorsIDsValue[entry_]:=((#[["value"]]&/@#)&/@AuthorsAdvisorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsAdvisorsIDsArray[entry_]:=(({#[["schema"]],#[["value"]]}&/@#)&/@AuthorsAdvisorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsAdvisorsName[entry_]:=(#[["name"]]&/@AuthorsAdvisors[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsAdvisorsRecord[entry_]:=(#[["record"]]&/@AuthorsAdvisors[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		AuthorsAdvisorsRecordRef[entry_]:=#[["$ref"]]&/@AuthorsAdvisorsRecord[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsAdvisorsRecordArray[entry_]:=Transpose@{AuthorsAdvisorsCuratedRelation[entry],AuthorsAdvisorsDegreeType[entry],AuthorsAdvisorsIDsArray[entry],AuthorsAdvisorsName[entry],AuthorsAdvisorsRecordRef[entry]};
AuthorsArXivCategories[entry_]:=entry[["metadata","arxiv_categories"]]/.Missing["KeyAbsent",x__]:>{""};
AuthorsAwards[entry_]:=entry[["metadata","awards"]]/.Missing["KeyAbsent",x__]:>{ObjectAwards};
	AuthorsAwardsName[entry_]:=(#[["name"]]&/@AuthorsAwards[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsAwardsURL[entry_]:=(#[["url"]]&/@AuthorsAwards[entry])/.Missing["KeyAbsent",x__]:>ObjectURL;
		AuthorsAwardsURLDescription[entry_]:=(#[["description"]]&/@AuthorsAwardsURL[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsAwardsURLValue[entry_]:=(#[["value"]]&/@AuthorsAwardsURL[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsAwardsURLArray[entry_]:=({#[["description"]],#[["value"]]}&/@AuthorsAwardsURL[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsAwardsYear[entry_]:=(#[["year"]]&/@AuthorsAwards[entry])/.Missing["KeyAbsent",x__]:>0;
	AuthorsAwardsArray[entry_]:=Transpose@{AuthorsAwardsName[entry],AuthorsAwardsURLArray[entry],AuthorsAwardsYear[entry]};
AuthorsBirthDate[entry_]:=entry[["metadata","birth_date"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsControlNumber[entry_]:=entry[["metadata","control_number"]]/.Missing["KeyAbsent",x__]:>0;
AuthorsDeathDate[entry_]:=entry[["metadata","death_date"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsDeleted[entry_]:=entry[["metadata","deleted"]]/.Missing["KeyAbsent",x__]:>False;
AuthorsDeletedRecords[entry_]:=entry[["metadata","deleted_records"]]/.Missing["KeyAbsent",x__]:>{ObjectJSONReference};
	AuthorsDeletedRecordsRef[entry_]:=#[["$ref"]]&/@AuthorsDeletedRecords[entry]/.Missing["KeyAbsent",x__]:>"";
(*AuthorsEarliestDate[entry_]:=entry[["metadata","earliest_date"]]/.Missing["KeyAbsent",x__]:>"";*)
AuthorsEmailAddresses[entry_]:=entry[["metadata","email_addresses"]]/.Missing["KeyAbsent",x__]:>{ObjectEmailAddress};
	AuthorsEmailAddressesCurrent[entry_]:=(#[["current"]]&/@AuthorsEmailAddresses[entry])/.Missing["KeyAbsent",x__]:>False;
	AuthorsEmailAddressesHidden[entry_]:=(#[["hidden"]]&/@AuthorsEmailAddresses[entry])/.Missing["KeyAbsent",x__]:>False;
	AuthorsEmailAddressesValue[entry_]:=(#[["value"]]&/@AuthorsEmailAddresses[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsEmailAddressesArray[entry_]:=Transpose@{AuthorsEmailAddressesCurrent[entry],AuthorsEmailAddressesHidden[entry],AuthorsEmailAddressesValue[entry]};
AuthorsIDs[entry_]:=entry[["metadata","ids"]]/.Missing["KeyAbsent",x__]:>{ObjectID};
		AuthorsIDsSchema[entry_]:=(#[["schema"]]&/@AuthorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsIDsValue[entry_]:=(#[["value"]]&/@AuthorsIDs[entry])/.Missing["KeyAbsent",x__]:>"";
		AuthorsIDsArray[entry_]:=Transpose@{AuthorsIDsSchema[entry],AuthorsIDsValue[entry]};
AuthorsInspireCategories[entry_]:=entry[["metadata","inspire_categories"]]/.Missing["KeyAbsent",x__]:>{ObjectInspireField};
	AuthorsInspireCategoriesSource[entry_]:=#[["source"]]&/@AuthorsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsInspireCategoriesTerm[entry_]:=#[["term"]]&/@AuthorsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsInspireCategoriesArray[entry_]:={#[["source"]],#[["term"]]}&/@AuthorsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
AuthorsLegacyCreationDate[entry_]:=entry[["metadata","legacy_creation_date"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsLegacyVersion[entry_]:=entry[["metadata","legacy_version"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsName[entry_]:=entry[["metadata","name"]]/.Missing["KeyAbsent",x__]:>ObjectName;
	AuthorsNameNameVariants[entry_]:=AuthorsName[entry][["name_variants"]]/.Missing["KeyAbsent",x__]:>{""};
	AuthorsNameNativeNames[entry_]:=AuthorsName[entry][["native_names"]]/.Missing["KeyAbsent",x__]:>{""};
	AuthorsNameNumeration[entry_]:=AuthorsName[entry][["numeration"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsNamePreferredName[entry_]:=AuthorsName[entry][["preferred_name"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsNamePreviousNames[entry_]:=AuthorsName[entry][["previous_names"]]/.Missing["KeyAbsent",x__]:>{""};
	AuthorsNameTitle[entry_]:=AuthorsName[entry][["title"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsNameValue[entry_]:=AuthorsName[entry][["value"]]/.Missing["KeyAbsent",x__]:>"";
	AuthorsNameArray[entry_]:={AuthorsNameNameVariants[entry],AuthorsNameNativeNames[entry],AuthorsNameNumeration[entry],AuthorsNamePreferredName[entry],AuthorsNamePreviousNames[entry],AuthorsNameTitle[entry],AuthorsNameValue[entry]};
AuthorsNewRecord[entry_]:=entry[["metadata","new_record"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	AuthorsNewRecordRef[entry_]:=AuthorsNewRecord[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsPositions[entry_]:=entry[["metadata","positions"]]/.Missing["KeyAbsent",x__]:>{ObjectPosition};
	AuthorsPositionsCuratedRelation[entry_]:=#[["curated_relation"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>False;
	AuthorsPositionsCurrent[entry_]:=#[["current"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>False;
	AuthorsPositionsEndDate[entry_]:=#[["end_date"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsPositionsInstitution[entry_]:=#[["institution"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsPositionsRank[entry_]:=#[["rank"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsPositionsRecord[entry_]:=#[["record"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		AuthorsPositionsRecordRef[entry_]:=#[["$ref"]]&/@AuthorsPositionsRecord[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsPositionsStartDate[entry_]:=#[["start_date"]]&/@AuthorsPositions[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsPositionsArray[entry_]:=Transpose@{AuthorsPositionsCuratedRelation[entry],AuthorsPositionsCurrent[entry],AuthorsPositionsEndDate[entry],AuthorsPositionsInstitution[entry],AuthorsPositionsRank[entry],AuthorsPositionsRecordRef[entry],AuthorsPositionsStartDate[entry]};
AuthorsProjectMembership[entry_]:=entry[["metadata","project_membership"]]/.Missing["KeyAbsent",x__]:>{ObjectProjectMembership};
	AuthorsProjectMembershipCuratedRelation[entry_]:=#[["curated_relation"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>False;
	AuthorsProjectMembershipCurrent[entry_]:=#[["current"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>False;
	AuthorsProjectMembershipEndDate[entry_]:=#[["end_date"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsProjectMembershipName[entry_]:=#[["name"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsProjectMembershipRecord[entry_]:=#[["record"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		AuthorsProjectMembershipRecordRef[entry_]:=#[["$ref"]]&/@AuthorsProjectMembershipRecord[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsProjectMembershipStartDate[entry_]:=#[["start_date"]]&/@AuthorsProjectMembership[entry]/.Missing["KeyAbsent",x__]:>"";
	AuthorsProjectMembershipArray[entry_]:=Transpose@{AuthorsProjectMembershipCuratedRelation[entry],AuthorsProjectMembershipCurrent[entry],AuthorsProjectMembershipEndDate[entry],AuthorsProjectMembershipName[entry],AuthorsProjectMembershipRecordRef[entry],AuthorsProjectMembershipStartDate[entry]};
AuthorsPublicNotes[entry_]:=entry[["metadata","public_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	AuthorsPublicNotesSource[entry_]:=(#[["source"]]&/@AuthorsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsPublicNotesValue[entry_]:=(#[["value"]]&/@AuthorsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsPublicNotesArray[entry_]:=Transpose@{AuthorsPublicNotesSource[entry],AuthorsPublicNotesValue[entry]};
AuthorsSelf[entry_]:=entry[["metadata","self"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	AuthorsSelfRef[entry_]:=AuthorsSelf[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsStatus[entry_]:=entry[["metadata","status"]]/.Missing["KeyAbsent",x__]:>"";
AuthorsStub[entry_]:=entry[["metadata","stub"]]/.Missing["KeyAbsent",x__]:>False;
AuthorsURLs[entry_]:=entry[["metadata","urls"]]/.Missing["KeyAbsent",x__]:>{ObjectURL};
	AuthorsURLsDescription[entry_]:=(#[["description"]]&/@AuthorsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsURLsValue[entry_]:=(#[["value"]]&/@AuthorsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	AuthorsURLsArray[entry_]:=Transpose@{AuthorsURLsDescription[entry],AuthorsURLsValue[entry]};


(* ::Subsubsection:: *)
(*Extract Authors records*)


ExtractAuthorsID[entry_]:=RecordID[entry];
ExtractAuthorsDateCreated[entry_]:=RecordCreated[entry]/.""->{Null};
ExtractAuthorsDateUpdated[entry_]:=RecordUpdated[entry]/.""->{Null};
(*ExtractAuthorsEarliestDate[entry_]:=AuthorsEarliestDate[entry]/.""->Null;*)(*{AuthorsEarliestDate[entry]}/.""\[Rule]Null;*)
ExtractAuthorsHEPNames[entry_]:=AuthorsIDsArray[entry]/.""->Null;
ExtractAuthorsName[entry_]:=AuthorsNameValue[entry]/.""->Null;(*{AuthorsNamePreferredName[entry],AuthorsNameValue[entry]}/.""\[Rule]Null;*)
ExtractAuthorsPreferredName[entry_]:=AuthorsNamePreferredName[entry]/.""->Null;
ExtractAuthorsNativeNames[entry_]:=DeleteCases[AuthorsNameNativeNames[entry],""];(*{AuthorsNamePreferredName[entry],AuthorsNameValue[entry]}/.""\[Rule]Null;*)
ExtractAuthorsAdvisors[entry_]:=Transpose@{AuthorsAdvisorsDegreeType[entry],AuthorsAdvisorsName[entry]}/.""->Null/.{{Null,Null}}->{Null,Null}
ExtractAuthorsArxivCategories[entry_]:=AuthorsArXivCategories[entry]/.{""}->{};
ExtractAuthorsAuthorsLegacyCreationDate[entry_]:=AuthorsLegacyCreationDate[entry]/.""->{Null};
ExtractAuthorsPositions[entry_]:=If[AuthorsPositions[entry]!={<|"curated_relation"->False,"current"->False,"end_date"->"","institution"->"","rank"->"","record"-><|"$ref"->""|>,"start_date"->""|>},Transpose@{StringDelete[AuthorsPositionsRecordRef[entry],Alternatives@@institutionsurls]/.""->{}(*/.{""}\[Rule]{{}}*),AuthorsPositionsInstitution[entry]/.""->Null,AuthorsPositionsStartDate[entry]/.""->Null,AuthorsPositionsEndDate[entry]/.""->Null,AuthorsPositionsRank[entry]/.""->Null,ConstantArray[Null,Length[AuthorsPositionsRecordRef[entry]]],AuthorsPositionsCurrent[entry]},{{Null,Null,Null,Null,Null,{Null},Null}}];
ExtractAuthorsStatus[entry_]:=AuthorsStatus[entry]/.""->Null;
ExtractAuthorsStub[entry_]:=AuthorsStub[entry]/.""->Null;
ExtractAuthorsURLs[entry_]:=AuthorsURLsValue[entry]/.{""}->{};


(* ::Subsection:: *)
(*Journals records*)


(* ::Subsubsection:: *)
(*Schema: Journals records*)


(* ::Text:: *)
(*Journals: Functions to extract all necessary information from each JSON entry (exact replica of Inspire Schema)*)


JournalsSchema[entry_]:=entry[["metadata","$schema"]]/.Missing["KeyAbsent",x__]:>"";
JournalsCollections[entry_]:=entry[["metadata","_collections"]]/.Missing["KeyAbsent",x__]:>{""};
JournalsHarvestingInfo[entry_]:=entry[["metadata","_harvesting_info"]]/.Missing["KeyAbsent",x__]:>ObjectHarvestingInfo;
	JournalsHarvestingInfoCoverage[entry_]:=JournalsHarvestingInfo[entry][["coverage"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsHarvestingInfoDateLastHarvest[entry_]:=JournalsHarvestingInfo[entry][["date_last_harvest"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsHarvestingInfoLastSeenItem[entry_]:=JournalsHarvestingInfo[entry][["last_seen_item"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsHarvestingInfoMethod[entry_]:=JournalsHarvestingInfo[entry][["method"]]/.Missing["KeyAbsent",x__]:>"";
JournalsHarvestingInfoArray[entry_]:={JournalsHarvestingInfoCoverage[entry],JournalsHarvestingInfoDateLastHarvest[entry],JournalsHarvestingInfoLastSeenItem[entry],JournalsHarvestingInfoMethod[entry]};
JournalsPrivateNotes[entry_]:=entry[["metadata","_private_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	JournalsPrivateNotesSource[entry_]:=(#[["source"]]&/@JournalsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsPrivateNotesValue[entry_]:=(#[["value"]]&/@JournalsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsPrivateNotesArray[entry_]:=Transpose@{JournalsPrivateNotesSource[entry],JournalsPrivateNotesValue[entry]};
JournalsBookSeries[entry_]:=entry[["metadata","book_series"]]/.Missing["KeyAbsent",x__]:>False;
JournalsControlNumber[entry_]:=entry[["metadata","control_number"]]/.Missing["KeyAbsent",x__]:>0;
JournalsDateEnded[entry_]:=entry[["metadata","date_ended"]]/.Missing["KeyAbsent",x__]:>"";
JournalsDateStarted[entry_]:=entry[["metadata","date_started"]]/.Missing["KeyAbsent",x__]:>"";
JournalsDeleted[entry_]:=entry[["metadata","deleted"]]/.Missing["KeyAbsent",x__]:>False;
JournalsDOIPrefixes[entry_]:=entry[["metadata","doi_prefixes"]]/.Missing["KeyAbsent",x__]:>{""};
JournalsEarliestDate[entry_]:=entry[["metadata","earliest_date"]]/.Missing["KeyAbsent",x__]:>"";
JournalsInspireCategories[entry_]:=entry[["metadata","inspire_categories"]]/.Missing["KeyAbsent",x__]:>{ObjectInspireField};
	JournalsInspireCategoriesSource[entry_]:=#[["source"]]&/@JournalsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	JournalsInspireCategoriesTerm[entry_]:=#[["term"]]&/@JournalsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	JournalsInspireCategoriesArray[entry_]:={#[["source"]],#[["term"]]}&/@JournalsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
JournalsISSNs[entry_]:=entry[["metadata","issns"]]/.Missing["KeyAbsent",x__]:>{ObjectISSN};
	JournalsISSNsMedium[entry_]:=(#[["medium"]]&/@JournalsISSNs[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsISSNsValue[entry_]:=(#[["value"]]&/@JournalsISSNs[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsISSNsArray[entry_]:=Transpose@{JournalsISSNsMedium[entry],JournalsISSNsValue[entry]};
JournalsTitle[entry_]:=entry[["metadata","title"]]/.Missing["KeyAbsent",x__]:>ObjectTitle;
	JournalsTitleSource[entry_]:=JournalsTitle[entry][["source"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsTitleSubtitle[entry_]:=JournalsTitle[entry][["subtitle"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsTitleTitle[entry_]:=JournalsTitle[entry][["title"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsTitleArray[entry_]:={JournalsTitleSource[entry],JournalsTitleSubtitle[entry],JournalsTitleTitle[entry]};
JournalsLegacyCreationDate[entry_]:=entry[["metadata","legacy_creation_date"]]/.Missing["KeyAbsent",x__]:>"";
JournalsLegacyVersion[entry_]:=entry[["metadata","legacy_version"]]/.Missing["KeyAbsent",x__]:>"";
JournalsLicense[entry_]:=entry[["metadata","license"]]/.Missing["KeyAbsent",x__]:>ObjectLicenseJournal;
	JournalsLicenseLicense[entry_]:=JournalsLicense[entry][["license"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsLicenseURL[entry_]:=JournalsLicense[entry][["url"]]/.Missing["KeyAbsent",x__]:>"";
	JournalsLicenseArray[entry_]:={JournalsLicenseLicense[entry],JournalsLicenseLicense[entry]};
JournalsNewRecord[entry_]:=entry[["metadata","new_record"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	JournalsNewRecordRef[entry_]:=JournalsNewRecord[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
JournalsProceedings[entry_]:=entry[["metadata","proceedings"]]/.Missing["KeyAbsent",x__]:>False;
JournalsPublicNotes[entry_]:=entry[["metadata","public_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	JournalsPublicNotesSource[entry_]:=(#[["source"]]&/@JournalsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsPublicNotesValue[entry_]:=(#[["value"]]&/@JournalsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsPublicNotesArray[entry_]:=Transpose@{JournalsPublicNotesSource[entry],JournalsPublicNotesValue[entry]};
JournalsPublisher[entry_]:=entry[["metadata","publisher"]]/.Missing["KeyAbsent",x__]:>{""};
JournalsRefereed[entry_]:=entry[["metadata","refereed"]]/.Missing["KeyAbsent",x__]:>False;
JournalsRelatedRecords[entry_]:=entry[["metadata","related_records"]]/.Missing["KeyAbsent",x__]:>{ObjectRelatedRecord};
	JournalsRelatedRecordsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@JournalsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>False;
	JournalsRelatedRecordsRecord[entry_]:=(#[["record"]]&/@JournalsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		JournalsRelatedRecordsRecordRef[entry_]:=(#[["$ref"]]&/@JournalsRelatedRecordsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsRelatedRecordsRelation[entry_]:=(#[["relation"]]&/@JournalsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsRelatedRecordsRelationFreetext[entry_]:=(#[["relation_freetext"]]&/@JournalsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
JournalsRelatedRecordsArray[entry_]:=Transpose@{JournalsRelatedRecordsCuratedRelation[entry],JournalsRelatedRecordsRecordRef[entry],JournalsRelatedRecordsRelation[entry],JournalsRelatedRecordsRelationFreetext[entry]};
JournalsSelf[entry_]:=entry[["metadata","self"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	JournalsSelfRef[entry_]:=JournalsSelf[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
JournalsShortTitle[entry_]:=entry[["metadata","short_title"]]/.Missing["KeyAbsent",x__]:>"";
JournalsTitleVariants[entry_]:=entry[["metadata","title_variants"]]/.Missing["KeyAbsent",x__]:>{""};
JournalsURLs[entry_]:=entry[["metadata","urls"]]/.Missing["KeyAbsent",x__]:>{ObjectURL};
	JournalsURLsDescription[entry_]:=(#[["description"]]&/@JournalsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsURLsValue[entry_]:=(#[["value"]]&/@JournalsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	JournalsURLsArray[entry_]:=Transpose@{JournalsURLsDescription[entry],JournalsURLsValue[entry]};


(* ::Subsubsection:: *)
(*Extract Journals records*)


ExtractJournalsID[entry_]:={RecordID[entry]};
ExtractJournalsDateCreated[entry_]:={RecordCreated[entry]}/.""->Null;
ExtractJournalsDateUpdated[entry_]:={RecordUpdated[entry]}/.""->Null;
ExtractJournalsEarliestDate[entry_]:={JournalsEarliestDate[entry]}/.""->Null;
ExtractJournalsShortTitle[entry_]:={JournalsShortTitle[entry]}/.""->Null;


(* ::Subsection:: *)
(*Institutions records*)


(* ::Subsubsection:: *)
(*Schema: Institutions records*)


(* ::Text:: *)
(*Institutions: Functions to extract all necessary information from each JSON entry (exact replica of Inspire Schema)*)


InstitutionsSchema[entry_]:=entry[["metadata","$schema"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsICN[entry_]:=entry[["metadata","ICN"]]/.Missing["KeyAbsent",x__]:>{""};
InstitutionsCollections[entry_]:=entry[["metadata","_collections"]]/.Missing["KeyAbsent",x__]:>{""};
InstitutionsPrivateNotes[entry_]:=entry[["metadata","_private_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	InstitutionsPrivateNotesSource[entry_]:=(#[["source"]]&/@InstitutionsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsPrivateNotesValue[entry_]:=(#[["value"]]&/@InstitutionsPrivateNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsPrivateNotesArray[entry_]:=Transpose@{InstitutionsPrivateNotesSource[entry],InstitutionsPrivateNotesValue[entry]};
InstitutionAddresses[entry_]:=entry[["metadata","addresses"]]/.Missing["KeyAbsent",x__]:>{ObjectAddress};
	InstitutionAddressesCities[entry_]:=(#[["cities"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>{""};
	InstitutionAddressesCountryCode[entry_]:=(#[["country_code"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionAddressesLatitude[entry_]:=(#[["latitude"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>0.;
	InstitutionAddressesLongitude[entry_]:=(#[["longitude"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>0.;
	InstitutionAddressesPlaceName[entry_]:=(#[["place_name"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionAddressesPostalAddress[entry_]:=(#[["postal_address"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>{""};
	InstitutionAddressesPostalCode[entry_]:=(#[["postal_code"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionAddressesState[entry_]:=(#[["state"]]&/@InstitutionAddresses[entry])/.Missing["KeyAbsent",x__]:>"";
InstitutionAddressesArray[entry_]:=Transpose@{InstitutionAddressesCities[entry],InstitutionAddressesCountryCode[entry],InstitutionAddressesLatitude[entry],InstitutionAddressesLongitude[entry],InstitutionAddressesPlaceName[entry],InstitutionAddressesPostalAddress[entry],InstitutionAddressesPostalCode[entry],InstitutionAddressesState[entry]};
InstitutionsControlNumber[entry_]:=entry[["metadata","control_number"]]/.Missing["KeyAbsent",x__]:>0;
InstitutionsCore[entry_]:=entry[["metadata","core"]]/.Missing["KeyAbsent",x__]:>False;
InstitutionsDeleted[entry_]:=entry[["metadata","deleted"]]/.Missing["KeyAbsent",x__]:>False;
InstitutionsDeletedRecords[entry_]:=entry[["metadata","deleted_records"]]/.Missing["KeyAbsent",x__]:>{ObjectJSONReference};
	InstitutionsDeletedRecordsRef[entry_]:=#[["$ref"]]&/@InstitutionsDeletedRecords[entry]/.Missing["KeyAbsent",x__]:>"";
InstitutionsEarliestDate[entry_]:=entry[["metadata","earliest_date"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsExternalSystemIdentifiers[entry_]:=entry[["metadata","external_system_identifiers"]]/.Missing["KeyAbsent",x__]:>{ObjectID};
	InstitutionsExternalSystemIdentifiersSchema[entry_]:=#[["schema"]]&/@InstitutionsExternalSystemIdentifiers[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsExternalSystemIdentifiersValue[entry_]:=#[["value"]]&/@InstitutionsExternalSystemIdentifiers[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsExternalSystemIdentifiersArray[entry_]:={#[["schema"]],#[["value"]]}&/@InstitutionsExternalSystemIdentifiers[entry]/.Missing["KeyAbsent",x__]:>"";
InstitutionsExtraWords[entry_]:=entry[["metadata","extra_words"]]/.Missing["KeyAbsent",x__]:>{""};
InstitutionsHistoricalData[entry_]:=entry[["metadata","historical_data"]]/.Missing["KeyAbsent",x__]:>{""};
InstitutionsInactive[entry_]:=entry[["metadata","inactive"]]/.Missing["KeyAbsent",x__]:>False;
InstitutionsInspireCategories[entry_]:=entry[["metadata","inspire_categories"]]/.Missing["KeyAbsent",x__]:>{ObjectInspireField};
	InstitutionsInspireCategoriesSource[entry_]:=#[["source"]]&/@InstitutionsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsInspireCategoriesTerm[entry_]:=#[["term"]]&/@InstitutionsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsInspireCategoriesArray[entry_]:={#[["source"]],#[["term"]]}&/@InstitutionsInspireCategories[entry]/.Missing["KeyAbsent",x__]:>"";
InstitutionsInstitutionHierarchy[entry_]:=entry[["metadata","institution_hierarchy"]]/.Missing["KeyAbsent",x__]:>{ObjectInstitutionHierarchy};
	InstitutionsInstitutionHierarchyAcronym[entry_]:=#[["acronym"]]&/@InstitutionsInstitutionHierarchy[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsInstitutionHierarchyName[entry_]:=#[["name"]]&/@InstitutionsInstitutionHierarchy[entry]/.Missing["KeyAbsent",x__]:>"";
	InstitutionsInstitutionHierarchyArray[entry_]:=Transpose@{InstitutionsInstitutionHierarchyAcronym[entry],InstitutionsInstitutionHierarchyName[entry]};
InstitutionsInstitutionType[entry_]:=entry[["metadata","institution_type"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsLegacyICN[entry_]:=entry[["metadata","legacy_ICN"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsLegacyCreationDate[entry_]:=entry[["metadata","legacy_creation_date"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsLegacyVersion[entry_]:=entry[["metadata","legacy_version"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsNameVariants[entry_]:=entry[["metadata","name_variants"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	InstitutionsNameVariantsSource[entry_]:=(#[["source"]]&/@InstitutionsNameVariants[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsNameVariantsValue[entry_]:=(#[["value"]]&/@InstitutionsNameVariants[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsNameVariantsArray[entry_]:=Transpose@{InstitutionsNameVariantsSource[entry],InstitutionsNameVariantsValue[entry]};
InstitutionsNewRecord[entry_]:=entry[["metadata","new_records"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	InstitutionsNewRecordRef[entry_]:=InstitutionsNewRecord[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsPublicNotes[entry_]:=entry[["metadata","public_notes"]]/.Missing["KeyAbsent",x__]:>{ObjectSourcedValue};
	InstitutionsPublicNotesSource[entry_]:=(#[["source"]]&/@InstitutionsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsPublicNotesValue[entry_]:=(#[["value"]]&/@InstitutionsPublicNotes[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsPublicNotesArray[entry_]:=Transpose@{InstitutionsPublicNotesSource[entry],InstitutionsPublicNotesValue[entry]};
InstitutionsRelatedRecords[entry_]:=entry[["metadata","related_records"]]/.Missing["KeyAbsent",x__]:>{ObjectRelatedRecord};
	InstitutionsRelatedRecordsCuratedRelation[entry_]:=(#[["curated_relation"]]&/@InstitutionsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>False;
	InstitutionsRelatedRecordsRecord[entry_]:=(#[["record"]]&/@InstitutionsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
		InstitutionsRelatedRecordsRecordRef[entry_]:=(#[["$ref"]]&/@InstitutionsRelatedRecordsRecord[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsRelatedRecordsRelation[entry_]:=(#[["relation"]]&/@InstitutionsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsRelatedRecordsRelationFreetext[entry_]:=(#[["relation_freetext"]]&/@InstitutionsRelatedRecords[entry])/.Missing["KeyAbsent",x__]:>"";
InstitutionsSelf[entry_]:=entry[["metadata","self"]]/.Missing["KeyAbsent",x__]:>ObjectJSONReference;
	InstitutionsSelfRef[entry_]:=InstitutionsSelf[entry][["$ref"]]/.Missing["KeyAbsent",x__]:>"";
InstitutionsURLs[entry_]:=entry[["metadata","urls"]]/.Missing["KeyAbsent",x__]:>{ObjectURL};
	InstitutionsURLsDescription[entry_]:=(#[["description"]]&/@InstitutionsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsURLsValue[entry_]:=(#[["value"]]&/@InstitutionsURLs[entry])/.Missing["KeyAbsent",x__]:>"";
	InstitutionsURLsArray[entry_]:=Transpose@{InstitutionsURLsDescription[entry],InstitutionsURLsValue[entry]};


(* ::Subsubsection:: *)
(*Extract Institutions records*)


ExtractInstitutionsID[entry_]:={RecordID[entry]};
ExtractInstitutionsDateCreated[entry_]:={RecordCreated[entry]}/.""->Null;
ExtractInstitutionsDateUpdated[entry_]:={RecordUpdated[entry]}/.""->Null;
ExtractInstitutionsEarliestDate[entry_]:={InstitutionsEarliestDate[entry]}/.""->Null;
ExtractInstitutionAddressesCities[entry_]:=InstitutionAddressesCities[entry];
ExtractInstitutionAddressesCountryCode[entry_]:=InstitutionAddressesCountryCode[entry];
ExtractInstitutionAddressesLatitude[entry_]:=InstitutionAddressesLatitude[entry];
ExtractInstitutionAddressesLongitude[entry_]:=InstitutionAddressesLongitude[entry];
ExtractInstitutionAddressesPlaceName[entry_]:=InstitutionAddressesPlaceName[entry];
ExtractInstitutionAddressesPostalAddress[entry_]:=InstitutionAddressesPostalAddress[entry];
ExtractInstitutionAddressesPostalCode[entry_]:=InstitutionAddressesPostalCode[entry];
ExtractInstitutionAddressesState[entry_]:=InstitutionAddressesState[entry];
ExtractInstitutionsInstitutionAddress[entry_]:=InstitutionAddressesArray[entry]
ExtractLatitudeLongitude[entry_]:=Flatten[DeleteCases[(Transpose@{ExtractInstitutionAddressesLatitude[#],ExtractInstitutionAddressesLongitude[#]})/.{0.,0.}->{},{}]]&@entry;
ExtractCountryCodeAndState[entry_]:=Transpose@{CountryData/@ExtractInstitutionAddressesCountryCode[#],ExtractInstitutionAddressesCountryCode[#],ExtractInstitutionAddressesState[#]/.""->Null,ExtractInstitutionAddressesCities[#]/.""->Null}&@entry


(* ::Subsection:: *)
(*Extract records and generates Mathematica records*)


(* ::Text:: *)
(*Literature: Convert each JSON entry to a Mathematica Record with format RecordLegend*)


HEPEntryToRecord[JSON_,JSONbrief_]:=If[ToString[JSONbrief]!="Null",{ExtractHEPID[JSON],ExtractHEPDateCreated[JSON],ExtractHEPEarliestDate[JSONbrief],ExtractHEPDateUpdated[JSON],ExtractHEPTitle[JSON],ExtractHEPAbstract[JSON],ExtractHEPExperimentsAll[JSON],ExtractHEPArXivCategories[JSON],ExtractHEPArXivFirstCategory[JSON],ExtractHEPArXivIDs[JSON],ExtractHEPAuthorsCount[JSONbrief],ExtractHEPAuthorsAll[JSON],ExtractHEPCitations[JSON],ExtractHEPCitationsNoSelf[JSON],ExtractHEPCiteableFlag[JSON],ExtractHEPReferencesCount[JSONbrief],ExtractHEPCollaborationsAll[JSON],ExtractHEPCore[JSON],ExtractHEPCurated[JSON],ExtractHEPDocumentTypes[JSON],ExtractHEPDOIs[JSON],ExtractHEPExternalIDs[JSON],ExtractHEPNumberofPages[JSONbrief],ExtractHEPNumberofFigures[JSON],ExtractHEPInspireCategories[JSON],ExtractHEPISBNs[JSON],ExtractHEPKeywords[JSON],ExtractHEPPreprintDate[JSON],ExtractHEPJournalArtID[JSON],ExtractHEPJournalID[JSON],ExtractHEPJournalName[JSON],ExtractHEPJournalVolume[JSON],ExtractHEPJournalIssue[JSON],ExtractHEPJournalPageStart[JSON],ExtractHEPJournalPageEnd[JSON],ExtractHEPJournalDate[JSON],ExtractHEPPublicationType[JSON],ExtractHEPRefereedFlag[JSON],ExtractHEPReferences[JSON],ExtractHEPReportNumbers[JSON],ExtractHEPURL[JSON],ExtractHEPTeXKeys[JSON],ExtractHEPThesisInfo[JSON],ExtractHEPExternalURLs[JSON],ExtractHEPWithdrawnFlag[JSON]},{ExtractHEPID[JSON],ExtractHEPDateCreated[JSON],ExtractHEPEarliestDate[JSON],ExtractHEPDateUpdated[JSON],ExtractHEPTitle[JSON],ExtractHEPAbstract[JSON],ExtractHEPExperimentsAll[JSON],ExtractHEPArXivCategories[JSON],ExtractHEPArXivFirstCategory[JSON],ExtractHEPArXivIDs[JSON],ExtractHEPAuthorsCount[JSON],ExtractHEPAuthorsAll[JSON],ExtractHEPCitations[JSON],ExtractHEPCitationsNoSelf[JSON],ExtractHEPCiteableFlag[JSON],ExtractHEPReferencesCount[JSON],ExtractHEPCollaborationsAll[JSON],ExtractHEPCore[JSON],ExtractHEPCurated[JSON],ExtractHEPDocumentTypes[JSON],ExtractHEPDOIs[JSON],ExtractHEPExternalIDs[JSON],ExtractHEPNumberofPages[JSON],ExtractHEPNumberofFigures[JSON],ExtractHEPInspireCategories[JSON],ExtractHEPISBNs[JSON],ExtractHEPKeywords[JSON],ExtractHEPPreprintDate[JSON],ExtractHEPJournalArtID[JSON],ExtractHEPJournalID[JSON],ExtractHEPJournalName[JSON],ExtractHEPJournalVolume[JSON],ExtractHEPJournalIssue[JSON],ExtractHEPJournalPageStart[JSON],ExtractHEPJournalPageEnd[JSON],ExtractHEPJournalDate[JSON],ExtractHEPPublicationType[JSON],ExtractHEPRefereedFlag[JSON],ExtractHEPReferences[JSON],ExtractHEPReportNumbers[JSON],ExtractHEPURL[JSON],ExtractHEPTeXKeys[JSON],ExtractHEPThesisInfo[JSON],ExtractHEPExternalURLs[JSON],ExtractHEPWithdrawnFlag[JSON]}];
HEPRecordLegend=Table[ToString[i]<>". "<>ToExpression[StringReplace[DeleteDuplicates[StringDelete[StringSplit[StringSplit[StringSplit[ToString[Definition[HEPEntryToRecord]],"Null, "][[2]],"}"][[1]],", "],{"[","]","{","}"}]],{"ExtractHEP"->"\"","JSONbrief"->"\"","JSON"->"\""}]][[i]],{i,1,Quiet[HEPEntryToRecord[a,b]//Length]}];


(* ::Text:: *)
(*Authors: Convert each JSON entry to a Mathematica Record with format RecordLegend*)


AuthorsEntryToRecord[entry_]:={ExtractAuthorsID[#],ExtractAuthorsDateCreated[#],ExtractAuthorsAuthorsLegacyCreationDate[#],ExtractAuthorsHEPNames[#],ExtractAuthorsName[#],ExtractAuthorsPreferredName[#],ExtractAuthorsNativeNames[#],ExtractAuthorsAdvisors[#],ExtractAuthorsArxivCategories[#],ExtractAuthorsPositions[#],ExtractAuthorsStatus[#],ExtractAuthorsStub[#],ExtractAuthorsURLs[#]}&@entry
AuthorsRecordLegend=Table[ToString[i]<>". "<>ToExpression[StringDelete[StringReplace[StringSplit[ToString[Definition[AuthorsEntryToRecord]],{":= ("," &"}][[2]],{"ExtractAuthors"->"\"","[#1]"->"\""}],"AuthorsDB"]][[i]],{i,1,ToExpression[StringDelete[StringReplace[StringSplit[ToString[Definition[AuthorsEntryToRecord]],{":= ("," &"}][[2]],{"ExtractAuthors"->"\"","[#1]"->"\""}],"AuthorsDB"]]//Length}]


(* ::Subsection:: *)
(*Search and import*)


Clear[ImportInspireRecIDSearch,ImportInspireRecord]
ImportInspireRecIDSearch[str_,n_]:=Module[{out,existing,number,split,recidlist},out=Import["https://inspirehep.net/api/literature?sort=mostrecent&size=25&q="<>StringRiffle[StringSplit[str],"+"],"RawJSON"];existing=out[["hits",2]];If[existing==0,Print["The search did not match any result."],If[n>existing,Print["The number of records found is ",existing," and is less than ",n,". Search reduced to ",existing," records."];number=existing,number=n];split=If[IntegerQ[number/100],split=number/100,IntegerPart[number/100]+1];
recidlist=Sort[Flatten[(ExtractHEPID/@(Import["https://inspirehep.net/api/literature?sort=mostrecent&q="<>StringRiffle[StringSplit[str],"+"]<>"&page="<>ToString@#<>"&size=100","RawJSON"][["hits","hits"]]))&/@Range[split]]];Take[recidlist,number]]];
URLRecord[recid_]:="https://inspirehep.net/api/literature/"<>ToString@recid;
ImportInspireRecord[recidd___]:=Module[{bibnjsonbrief,bibnjson,recid},recid=Flatten@{recidd};
bibnjson=Quiet[Check[Import[URLRecord[#],"RawJSON"],Null]]&/@recid;
bibnjsonbrief=Quiet[Check[Import[HTTPRequest[URLRecord[#],<|"Headers"->{"Accept"->"application/vnd+inspire.record.ui+json"}|>],"RawJSON"],Null]]&/@recid;Prepend[MapThread[Quiet[HEPEntryToRecord[#1,#2]]&,{bibnjson,bibnjsonbrief}],HEPRecordLegend]]

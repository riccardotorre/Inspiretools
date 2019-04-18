## HEP RECORDS
## https://labs.inspirehep.net/schemas/records/hep.json
class HEP:
    """Class that defines all Objects and Attributes of HEP records
    """
    ## INIT PARENT CLASS
    class InitParent(object):
        """Class to initialize the object
        """
        def __init__(self, data):
            self.data = data
    ## HEP CLASS OBJECTS APPEARING IN PARENT CLASSES
    class JSONReferenceObject(InitParent):
        """Class containing the object HEP.JSONReferenceObject defined by the
        HEP.HEPObject.DeletedRecords, HEP.HEPObject.NewRecord, HEP.HEPObject.Self methods of the HEP.HEPObject class and by the
        HEP.PublicationInfoObject.ConferenceRecord, HEP.PublicationInfoObject.ParentRecord methods of the HEP.PublicationInfoObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.JSONReferenceObject.JSONReference
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/json_reference.html#json-reference-json
        """
        #   __init__ method inherited from InitParent
        def JSONReference(self, default=None):
            """HEP.JSONReferenceObject.JSONReference
            Returns a string containing the value corresponding to the key '$ref'
            Type: string
            Format: uri
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/json_reference.html#json-reference-json
            """
            return self.data.get('$ref', default)
    ## OTHER PARENT CLASSES
    class CuratedRelationParent(InitParent):
        """Class used to define the method CuratedRelation, inherited by the classes
        HEP.AuthorObject
        HEP.AcceleratorExperimentObject
        HEP.AffiliationObject
        HEP.PublicationInfoObject
        HEP.ReferenceObject
        HEP.RelatedRecordObject
        """
        def CuratedRelation(self, default=False):
            """Method inherited by different object classes:
            HEP.AuthorObject
            HEP.AcceleratorExperimentObject
            HEP.AffiliationObject
            HEP.PublicationInfoObject
            HEP.ReferenceObject
            HEP.RelatedRecordObject

            Returns a boolean with the value corresponding to the key 'curated_relation'
            Type: boolean
            Default: False
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=schema#hep-json-properties-accelerator-experiments-items-properties-curated-relation
            """
            return self.data.get('curated_relation', default)
    class HiddenParent(InitParent):
        """Class used to define the method Hidden, inherited by the classes
        HEP.DocumentObject
        HEP.PublicationInfoObject
        HEP.ReportNumberObject
        """
        def Hidden(self, default=False):
            """Method inherited by different object classes:
            HEP.DocumentObject
            HEP.PublicationInfoObject
            HEP.ReportNumberObject

            Returns a boolean with the value corresponding to the key 'hidden'
            Type: boolean
            Default: False (this differs from Inspire schema)
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=schema#hep-json-properties-documents-items-properties-hidden
            """
            return self.data.get('hidden', default)
    class KeyParent(InitParent):
        """Class used to define the method Key, inherited by the classes
        HEP.DocumentObject
        HEP.FigureObject
        """
        def Key(self, default=None):
            """Method inherited by different object classes:
            HEP.DocumentObject
            HEP.FigureObject

            Returns a string containing the value corresponding to the key 'key'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-documents-items-properties-key
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-figures-items-properties-key
            """
            return self.data.get('key', default)
    class MaterialParent(InitParent):
        """Class used to define the method Material, inherited by the classes
        HEP.DocumentObject
        HEP.DOIObject
        HEP.FigureObject
        HEP.LicenseObject
        HEP.PersistentIdentifierObject
        HEP.PublicationInfoObject
        HEP.PublicationInfoReducedObject
        """
        def Material(self, default=None):
            """Method inherited by different object classes:
            HEP.DocumentObject
            HEP.DOIObject
            HEP.FigureObject
            HEP.LicenseObject
            HEP.PersistentIdentifierObject
            HEP.PublicationInfoObject
            HEP.PublicationInfoReducedObject

            Returns a string containing the value corresponding to the key 'material'
            Type: string
            Default: None
            Allowed values: 'addendum'
                            'additional material'
                            'data'
                            'erratum'
                            'editorial note'
                            'preprint'
                            'publication'
                            'reprint'
                            'software'
                            'translation'
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/material.html#material-json
            """
            return self.data.get('material', default)
    class RecidParent(InitParent):
        """Class used to define the method Recid, inherited by the classes
        HEP.AuthorObject
        HEP.CollaborationObject
        HEP.AcceleratorExperimentObject
        HEP.HEPObject
        HEP.AffiliationObject
        HEPself.ReferenceObject
        """
        def Recid(self, default=None):
            """"Method inherited by different object classes:
            HEP.AuthorObject
            HEP.CollaborationObject
            HEP.AcceleratorExperimentObject
            HEP.HEPObject
            HEP.AffiliationObject
            HEPself.ReferenceObject

            Returns an integer with the value corresponding to the key 'id' or,
            if absent, to the key 'recid'
            Type: integer
            Documentation:
            not available (in the schema documentation recid is never mentioned (e.g for authors, institutes, etc.))
            """
            if self.data.get('id', default) != default:
                return self.data.get('id', default)
            else:
                return self.data.get('recid', default)
    class RecordParent(InitParent):
        """Class used to define the method Record, inherited by the classes
        HEP.AuthorObject
        HEP.CollaborationObject
        HEP.AcceleratorExperimentObject
        HEP.AffiliationObject
        HEP.ReferenceObject
        HEP.RelatedRecordObject
        """
        def Record(self, default=None):
            """Method inherited by different object classes:
            HEP.AuthorObject
            HEP.CollaborationObject
            HEP.AcceleratorExperimentObject
            HEP.AffiliationObject
            HEP.ReferenceObject
            HEP.RelatedRecordObject

            Returns a JSONReferenceObject containing the value corresponding to the key 'record'
            Type: HEP.JSONReferenceObject
            Default: empty object
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=schema#hep-json-properties-authors-items-properties-record
            """
            return HEP.JSONReferenceObject(self.data.get('record', {}))
    class SchemaParent(InitParent):
        """Class used to define the method Schema, inherited by the classes
        HEP.KeywordObject
        HEP.IDObject
        HEP.PersistentIdentifierObject
        HEP.ReferenceHEPObject
        HEP.RawReferenceObject
        """
        def Schema(self, default=None):
            """Method inherited by different object classes:
            HEP.KeywordObject
            HEP.IDObject
            HEP.PersistentIdentifierObject
            HEP.ReferenceHEPObject
            HEP.RawReferenceObject

            Returns a string with the value corresponding to the key 'schema'
            Not to be confused with the attribute JSONSchema, which extracts the
            value of the ['metadata']['$schema']
            Type: string
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=schema#hep-json-properties-external-system-identifiers-items-properties-schema
            """
            return self.data.get('schema', default)
    class SourceParent(InitParent):
        """Class used to define the method Source, inherited by the classes
        HEP.SourcedValueObject
        HEP.AcquisitionSourceObject
        HEP.ocumentObject
        HEP.FigureObject
        HEP.InspireFieldObject
        HEP.TitleObject
        and indirectly by the classes inheriting HEP.SourcedValueObject
        HEP.DOIObject
        HEP.KeywordObject
        HEP.PersistentIdentifierObject
        HEP.ReportNumberObject
        HEP.RawReferenceObject
        """
        def Source(self, default=None):
            """Method inherited by different object classes:
            HEP.SourcedValueObject
            HEP.AcquisitionSourceObject
            HEP.ocumentObject
            HEP.FigureObject
            HEP.InspireFieldObject
            HEP.TitleObject
            and indirectly by the classes inheriting HEP.SourcedValueObject
            HEP.DOIObject
            HEP.KeywordObject
            HEP.PersistentIdentifierObject
            HEP.ReportNumberObject
            HEP.RawReferenceObject

            Returns a string containing the value corresponding to the key 'source'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/source.html#source-json
            """
            return self.data.get('source', default)
    class URLParent(InitParent):
        """Class used to define the method URL, inherited by the classes
        HEP.DocumentObject
        HEP.FigureObject
        HEP.LicenseObject
        """
        def URL(self, default=None):
            """Method inherited by different object classes:
            HEP.DocumentObject
            HEP.FigureObject
            HEP.LicenseObject

            Returns a string containing the value corresponding to the key 'url'
            Type: string
            Format: uri
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-copyright-items-properties-url
            """
            return self.data.get('url', default)
    class ValueParent(InitParent):
        """Class used to define the method Value, inherited by the classes
        HEP.SourcedValueObject
        HEP.ArXivObject
        HEP.CollaborationObject
        HEP.IDObject
        HEP.AffiliationObject
        HEP.ISBNObject
        HEP.ReferenceHEPObject
        HEP.URLObject
        and indirectly by the classes inheriting HEP.SourcedValueObject
        HEP.DOIObject
        HEP.KeywordObject
        HEP.PersistentIdentifierObject
        HEP.ReportNumberObject
        HEP.RawReferenceObject
        """
        def Value(self, default=None):
            """Method inherited by different object classes:
            HEP.SourcedValueObject
            HEP.ArXivObject
            HEP.CollaborationObject
            HEP.IDObject
            HEP.AffiliationObject
            HEP.ISBNObject
            HEP.ReferenceHEPObject
            HEP.URLObject
            and indirectly by the classes inheriting HEP.SourcedValueObject
            HEP.DOIObject
            HEP.KeywordObject
            HEP.PersistentIdentifierObject
            HEP.ReportNumberObject
            HEP.RawReferenceObject

            Returns a string containing the value corresponding to the key 'value'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/sourced_value.html#sourced-value-json-properties-value
            """
            return self.data.get('value', default)
    class TitleParent(InitParent):
        """Class used to define the methods Title and Subtitle, inherited by the classes
        HEP.TitleObject
        HEP.TitleTranslationObject
        """
        def Subtitle(self, default=[None]):
            """Method inherited by different object classes:
            HEP.TitleObject
            HEP.TitleTranslationObject

            Returns a string containing the value corresponding to the key 'subtitle'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#title-translations
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#titles
            """
            return self.data.get('subtitle', default)
        def Title(self, default=[None]):
            """Method inherited by different object classes:
            HEP.TitleObject
            HEP.TitleTranslationObject

            Returns a string containing the value corresponding to the key 'title'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#title-translations
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#titles
            """
            return self.data.get('title', default)
    class SourcedValueObject(SourceParent,ValueParent):
        """Class used to distribute the methods Source and Value, inherited by the classes
        HEP.DOIObject
        HEP.KeywordObject
        HEP.PersistentIdentifierObject
        HEP.RawReferenceObject
        HEP.ReportNumberObject
        """
        #   __init__ method inherited from InitParent
        #   Source method inherited from SourceParent
        #   Value method inherited from ValueParent
        pass
    ## HEP CLASS OBJECTS
    class HEPObject(RecidParent):
        """Class containing the object HEP.HEPObject defining a full
        record in the HEP database
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.RecidParent
        Contains the methods
        HEP.HEPObject.Recid
        HEP.HEPObject.Link
        HEP.HEPObject.JSONSchema
        HEP.HEPObject.Collections
        HEP.HEPObject.DesyBookkeeping
        HEP.HEPObject.DateCreated
        HEP.HEPObject.DateUpdated
        HEP.HEPObject.EarliestDate
        HEP.HEPObject.Files
        HEP.HEPObject.Abstracts
        HEP.HEPObject.Abstract
        HEP.HEPObject.AcceleratorExperiments
        HEP.HEPObject.AcquisitionSource
        HEP.HEPObject.ArXivEprints
        HEP.HEPObject.AuthorsCount
        HEP.HEPObject.Authors
        HEP.HEPObject.BookSeries
        HEP.HEPObject.CiteableFlag
        HEP.HEPObject.Collaborations
        HEP.HEPObject.ControlNumber
        HEP.HEPObject.Copyright
        HEP.HEPObject.Core
        HEP.HEPObject.CorporateAuthor
        HEP.HEPObject.Curated
        HEP.HEPObject.Deleted
        HEP.HEPObject.DeletedRecords
        HEP.HEPObject.DocumentType
        HEP.HEPObject.Documents
        HEP.HEPObject.DOIs
        HEP.HEPObject.Editions
        HEP.HEPObject.EnergyRanges
        HEP.HEPObject.ExternalSystemIdentifiers
        HEP.HEPObject.FacetInspireDocType
        HEP.HEPObject.Figures
        HEP.HEPObject.FiguresCount
        HEP.HEPObject.FundingInfo
        HEP.HEPObject.Imprints
        HEP.HEPObject.InspireCategories
        HEP.HEPObject.ISBNs
        HEP.HEPObject.Keywords
        HEP.HEPObject.Languages
        HEP.HEPObject.LegacyCreationDate
        HEP.HEPObject.Licenses
        HEP.HEPObject.NewRecord
        HEP.HEPObject.PagesCount
        HEP.HEPObject.PersistentIdentifiers
        HEP.HEPObject.PreprintDate
        HEP.HEPObject.PublicNotes
        HEP.HEPObject.PublicationInfo
        HEP.HEPObject.RecordAffiliations
        HEP.HEPObject.Refereed
        HEP.HEPObject.References
        HEP.HEPObject.RelatedRecords
        HEP.HEPObject.ReportNumbers
        HEP.HEPObject.Self
        HEP.HEPObject.TeXKeys
        HEP.HEPObject.ThesisInfo
        HEP.HEPObject.TitleTranslations
        HEP.HEPObject.Titles
        HEP.HEPObject.URLs
        HEP.HEPObject.Withdrawn
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-keywords
        """
        #   __init__ method inherited from InitParent
        def Abstracts(self, default=[{}]):
            """HEP.HEPObject.Abstracts
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['abstracts']
            Type: array
            Elements: HEP.SourcedValueObject
            Structure: [HEP.SourcedValueObject,...,HEP.SourcedValueObject]
            Default: [HEP.SourcedValueObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-abstracts
            """
            tmp = self.data.get('metadata', {}).get('abstracts', default)
            return [HEP.SourcedValueObject(i) for i in tmp]
        def Abstract(self, default=None):
            """HEP.HEPObject.Abstract
            Returns a string with the value of the first available abstract in HEP.HEPObject.Abstracts
            Type: string
            Default: None
            Documentation:
            This function is defined for convenience, is redundant and does not correspond to a key in the Inspire Schema
            """
            tmp = self.data.get('metadata', {}).get('abstracts', [{}])[0]
            return tmp.get('value', default)
        def AcceleratorExperiments(self, default=[{}]):
            """HEP.HEPObject.AcceleratorExperiments
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['accelerator_experiments']
            Type: array
            Elements: HEP.AcceleratorExperimentObject
            Structure: [HEP.AcceleratorExperimentObject,...,HEP.AcceleratorExperimentObject]
            Default: [HEP.AcceleratorExperimentObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#accelerator-experiments
            """
            tmp = self.data.get('metadata', {}).get('accelerator_experiments', default)
            return [HEP.AcceleratorExperimentObject(i) for i in tmp]
        def AcquisitionSource(self, default={}):
            """HEP.HEPObject.AcquisitionSource
            Returns an objects containing the value corresponding to the key hepjsonrecord['metadata']['acquisition_source']
            Type: HEP.AcquisitionSourceObject
            Default: HEP.AcceleratorExperimentObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json
            """
            tmp = self.data.get('metadata', {}).get('acquisition_source', default)
            return HEP.AcquisitionSourceObject(tmp)
        def ArXivEprints(self, default=[{}]):
            """HEP.HEPObject.ArXivEprints
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['arxiv_eprints']
            Type: array
            Elements: HEP.ArXivObject
            Structure: [HEP.ArXivObject,...,HEP.ArXivObject]
            Default: [HEP.ArXivObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#arxiv-eprints
            """
            tmp = self.data.get('metadata', {}).get('arxiv_eprints', default)
            return [HEP.ArXivObject(i) for i in tmp]
        def Authors(self, default=[{}]):
            """HEP.HEPObject.Authors
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['authors']
            Type: array
            Elements: HEP.AuthorObject
            Structure: [HEP.AuthorObject,...,HEP.AuthorObject]
            Default: [HEP.AuthorObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors
            """
            tmp = self.data.get('metadata', {}).get('authors', default)
            return [HEP.AuthorObject(i) for i in tmp]
        def AuthorsCount(self, default=None):
            """HEP.HEPObject.AuthorsCount
            Returns an integer with the value corresponding to the key hepjsonrecord['metadata']['author_count']
            Type: integer
            Default: None
            Documentation:
            This key appears in the JSON HEP records but is not documented in the Inspire Schema
            """
            return self.data.get('metadata', {}).get('author_count', default)
        def BookSeries(self, default=[{}]):
            """HEP.HEPObject.BookSeries
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['book_series']
            Type: array
            Elements: HEP.BookSeriesObject
            Structure: [HEP.BookSeriesObject,...,HEP.BookSeriesObject]
            Default: [HEP.BookSeriesObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-book-series
            """
            tmp = self.data.get('metadata', {}).get('book_series', default)
            return [HEP.BookSeriesObject(i) for i in tmp]
        def CiteableFlag(self, default=None):
            """HEP.HEPObject.CiteableFlag
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['citeable']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#citeable
            """
            return self.data.get('metadata', {}).get('citeable', default)
        def Collaborations(self, default=[{}]):
            """HEP.HEPObject.Collaborations
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['collaborations']
            Type: array
            Elements: HEP.CollaborationObject
            Structure: [HEP.CollaborationObject,...,HEP.CollaborationObject]
            Default: [HEP.CollaborationObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#collaborations
            """
            tmp = self.data.get('metadata', {}).get('collaborations', default)
            return [HEP.CollaborationObject(i) for i in tmp]
        def Collections(self, default=[None]):
            """HEP.HEPObject.Collections
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['_collections']
            Type: array
            Elements: strings
            Allowed elements values:    BABAR Analysis Documents
                                        BABAR Internal BAIS
                                        BABAR Internal Notes
                                        CDF Internal Notes
                                        CDF Notes
                                        CDS Hidden
                                        D0 Internal Notes
                                        D0 Preliminary Notes
                                        Fermilab
                                        H1 Internal Notes
                                        H1 Preliminary Notes
                                        HAL Hidden
                                        HEP Hidden
                                        HERMES Internal Notes
                                        LArSoft Internal Notes
                                        LArSoft Notes
                                        Literature
                                        ZEUS Internal Notes
                                        ZEUS Preliminary Notes
            Format: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-collections
            """
            return self.data.get('metadata', {}).get('_collections', default)
        def ControlNumber(self, default=None):
            """HEP.HEPObject.ControlNumber
            Returns an integer with the value corresponding to the key hepjsonrecord['metadata']['control_number']
            Type: integer
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#control-number
            """
            return self.data.get('metadata', {}).get('control_number', default)
        def Copyright(self, default=[{}]):
            """HEP.HEPObject.Copyright
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['copyright']
            Type: array
            Elements: HEP.CopyrightObject
            Structure: [HEP.CopyrightObject,...,HEP.CopyrightObject]
            Default: [HEP.CopyrightObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-copyright
            """
            tmp = self.data.get('metadata', {}).get('copyright', default)
            return [HEP.CopyrightObject(i) for i in tmp]
        def Core(self, default=None):
            """HEP.HEPObject.Core
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['core']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#core
            """
            return self.data.get('metadata', {}).get('core', default)
        def CorporateAuthor(self, default=[None]):
            """HEP.HEPObject.CorporateAuthor
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['corporate_author']
            Type: array
            Elements: strings
            Format: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#corporate-author
            """
            return self.data.get('metadata', {}).get('corporate_author', default)
        def Curated(self, default=None):
            """HEP.HEPObject.Curated
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['curated']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-curated
            """
            return self.data.get('metadata', {}).get('curated', default)
        def DateCreated(self, default=None):
            """HEP.HEPObject.DateCreated
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['_created']
            Type: string
            Format: ISO
            Default: None
            Documentation:
            This key appears in the JSON HEP records but is not documented in the Inspire Schema
            """
            return self.data.get('metadata', {}).get('_created', default)
        def DateUpdated(self, default=None):
            """HEP.HEPObject.DateUpdated
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['_updated']
            Type: string
            Format: ISO
            Default: None
            Documentation:
            This key appears in the JSON HEP records but is not documented in the Inspire Schema
            """
            return self.data.get('metadata', {}).get('_updated', default)
        def Deleted(self, default=None):
            """HEP.HEPObject.Deleted
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['deleted']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#deleted
            """
            return self.data.get('metadata', {}).get('deleted', default)
        def DeletedRecords(self, default=[{}]):
            """HEP.HEPObject.DeletedRecords
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['deleted_records']
            Type: array
            Elements: HEP.JSONReferenceObject
            Structure: [HEP.JSONReferenceObject,...,HEP.JSONReferenceObject]
            Default: [HEP.JSONReferenceObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#deleted-records
            """
            tmp = self.data.get('metadata', {}).get('deleted_records', default)
            return [HEP.JSONReferenceObject(i) for i in tmp]
        def DesyBookkeeping(self, default=[{}]):
            """HEP.HEPObject.DesyBookkeeping
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['_desy_bookkeeping']
            Type: array
            Elements: HEP.DesyBookkeepingObject
            Structure: [HEP.DesyBookkeepingObject,...,HEP.DesyBookkeepingObject]
            Default: [HEP.DesyBookkeepingObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping
            """
            tmp = self.data.get('metadata', {}).get('_desy_bookkeeping', default)
            return [HEP.DesyBookkeepingObject(i) for i in tmp]
        def Documents(self, default=[{}]):
            """HEP.HEPObject.Documents
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['documents']
            Type: array
            Elements: HEP.DocumentObject
            Structure: [HEP.DocumentObject,...,HEP.DocumentObject]
            Default: [HEP.DocumentObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#documents
            """
            tmp = self.data.get('metadata', {}).get('documents', default)
            return [HEP.DocumentObject(i) for i in tmp]
        def DocumentType(self, default=[None]):
            """HEP.HEPObject.DocumentType
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['document_type']
            Type: array
            Elements: strings
            Allowed elements values:    activity report
                                        article
                                        book
                                        book chapter
                                        conference paper
                                        note
                                        proceedings
                                        report
                                        thesis
            Format: [string,...,string]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#document-type
            """
            return self.data.get('metadata', {}).get('document_type', default)
        def DOIs(self, default=[{}]):
            """HEP.HEPObject.DOIs
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['dois']
            Type: array
            Elements: HEP.DOIObject
            Structure: [HEP.DOIObject,...,HEP.DOIObject]
            Default: [HEP.DOIObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#dois
            """
            tmp = self.data.get('metadata', {}).get('dois', default)
            return [HEP.DOIObject(i) for i in tmp]
        def EarliestDate(self, default=None):
            """HEP.HEPObject.EarliestDate
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['earliest_date']
            Type: string
            Format: ISO
            Default: None
            Documentation:
            This key appears in the JSON HEP records but is not documented in the Inspire Schema
            """
            return self.data.get('metadata', {}).get('earliest_date', default)
        def Editions(self, default=[None]):
            """HEP.HEPObject.Editions
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['editions']
            Type: array
            Elements: strings
            Format: [string,...,string]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#editions
            """
            return self.data.get('metadata', {}).get('editions', default)
        def EnergyRanges(self, default=[None]):
            """HEP.HEPObject.EnergyRanges
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['energy_ranges']
            Type: array
            Elements: strings
            Allowerd elements values:   0-3 GeV
                                        3-10 GeV
                                        10-30 GeV
                                        30-100 GeV
                                        100-300 GeV
                                        300-1000 GeV
                                        1-10 TeV
                                        > 10 TeV
            Format: [string,...,string]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#energy-ranges
            """
            return self.data.get('metadata', {}).get('energy_ranges', default)
        def ExternalSystemIdentifiers(self, default=[{}]):
            """HEP.HEPObject.ExternalSystemIdentifiers
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['external_system_identifiers']
            Type: array
            Elements: HEP.IDObject
            Structure: [HEP.IDObject,...,HEP.IDObject]
            Default: [HEP.IDObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#external-system-identifiers
            """
            tmp = self.data.get('metadata', {}).get('external_system_identifiers', default)
            return [HEP.IDObject(i) for i in tmp]
        def FacetInspireDocType(self, default=None):
            """HEP.HEPObject.FacetInspireDocType
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['facet_inspire_doc_type']
            Type: array
            Elements: string
            Format: [string,...,string]
            Documentation:
            This key appears in the JSON HEP records but is not documented in the Inspire Schema
            """
            return self.data.get('metadata', {}).get('facet_inspire_doc_type', [default])
        def Figures(self, default=[{}]):
            """HEP.HEPObject.Figures
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['figures']
            Type: array
            Elements: HEP.FigureObject
            Structure: [HEP.FigureObject,...,HEP.FigureObject]
            Default: [HEP.FigureObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#figures
            """
            tmp = self.data.get('metadata', {}).get('figures', default)
            return [HEP.FigureObject(i) for i in tmp]
        def FiguresCount(self, default=[]):
            """HEP.HEPObject.FiguresCount
            Returns an integer with the value of the length of the array corresponding to the key hepjsonrecord['metadata']['figures']
            Type: integer
            Default value: 0
            Documentation:
            This function is defined for convenience, is redundant and does not correspond to a key in the Inspire Schema
            """
            return len(self.data.get('metadata', {}).get('figures', default))
        def Files(self, default=[{}]):
            """HEP.HEPObject.Files
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['_files']
            Type: array
            Elements: HEP.RecordFile
            Structure: [HEP.RecordFile,...,HEP.RecordFile]
            Default: [HEP.RecordFile({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#files
            """
            tmp = self.data.get('metadata', {}).get('_files', default)
            return [HEP.RecordFile(i) for i in tmp]
        def FundingInfo(self, default=[{}]):
            """HEP.HEPObject.FundingInfo
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['funding_info']
            Type: array
            Elements: HEP.FundingObject
            Structure: [HEP.FundingObject,...,HEP.FundingObject]
            Default: [HEP.FundingObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#funding-info
            """
            tmp = self.data.get('metadata', {}).get('funding_info', default)
            return [HEP.FundingObject(i) for i in tmp]
        def Imprints(self, default=[{}]):
            """HEP.HEPObject.Imprints
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['imprints']
            Type: array
            Elements: HEP.ImprintObject
            Structure: [HEP.ImprintObject,...,HEP.ImprintObject]
            Default: [HEP.ImprintObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#imprints
            """
            tmp = self.data.get('metadata', {}).get('imprints', default)
            return [HEP.ImprintObject(i) for i in tmp]
        def InspireCategories(self, default=[{}]):
            """HEP.HEPObject.InspireCategories
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['inspire_categories']
            Type: array
            Elements: HEP.InspireFieldObject
            Structure: [HEP.InspireFieldObject,...,HEP.InspireFieldObject]
            Default: [HEP.InspireFieldObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#inspire-categories
            """
            tmp = self.data.get('metadata', {}).get('inspire_categories', default)
            return [HEP.InspireFieldObject(i) for i in tmp]
        def ISBNs(self, default=[{}]):
            """HEP.HEPObject.ISBNs
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['isbns']
            Type: array
            Elements: HEP.ISBNObject
            Structure: [HEP.ISBNObject,...,HEP.ISBNObject]
            Default: [HEP.ISBNObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#isbns
            """
            tmp = self.data.get('metadata', {}).get('isbns', default)
            return [HEP.ISBNObject(i) for i in tmp]
        def JSONSchema(self, default=None):
            """HEP.HEPObject.JSONSchema
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['$schema']
            Type: string
            Format: uri
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-schema
            """
            return self.data.get('metadata', {}).get('$schema', default)
        def Keywords(self, default=[{}]):
            """HEP.HEPObject.Keywords
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['keywords']
            Type: array
            Elements: HEP.KeywordObject
            Structure: [HEP.KeywordObject,...,HEP.KeywordObject]
            Default: [HEP.KeywordObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#keywords
            """
            tmp = self.data.get('metadata', {}).get('keywords', default)
            return [HEP.KeywordObject(i) for i in tmp]
        def Languages(self, default=["en"]):
            """HEP.HEPObject.Languages
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['languages']
            Type: array
            Elements: strings (with exactly 2 characters)
            Allowed elements values: see documentation
            Structure: [string,...,string]
            Default: ['en']
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#languages
            """
            return self.data.get('metadata', {}).get('languages', default)
        def LegacyCreationDate(self, default=None):
            """HEP.HEPObject.LegacyCreationDate
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['legacy_creation_date']
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#legacy-creation-date
            """
            return self.data.get('metadata', {}).get('legacy_creation_date', default)
        def Licenses(self, default=[{}]):
            """HEP.HEPObject.Licenses
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['license']
            Type: array
            Elements: HEP.LicenseObject
            Structure: [HEP.LicenseObject,...,HEP.LicenseObject]
            Default: [HEP.LicenseObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#license
            """
            tmp = self.data.get('metadata', {}).get('license', default)
            return [HEP.LicenseObject(i) for i in tmp]
        def Link(self, default=None):
            """HEP.HEPObject.Link
            Returns a string containing the value corresponding to the key hepjsonrecord['links']['self']
            Type: string
            Format: uri
            Default: None
            Documentation:
            This entry is not documented in the Inspire Schema, but is present in the JSON records
            """
            return self.data.get('links', {}).get('self', default)
        def NewRecord(self, default={}):
            """HEP.HEPObject.NewRecord
            Returns an object containing the value corresponding to the key hepjsonrecord['metadata']['new_record']
            Type: HEP.JSONReferenceObject
            Default: HEP.JSONReferenceObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#new-record
            """
            return HEP.JSONReferenceObject(self.data.get('metadata', {}).get('new_record', default))
        def PagesCount(self, default=None):
            """HEP.HEPObject.PagesCount
            Returns an integer with the value corresponding to the key hepjsonrecord['metadata']['number_of_pages']
            Type: integer
            Default value: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#number-of-pages
            """
            return self.data.get('metadata', {}).get('number_of_pages', default)
        def PersistentIdentifiers(self, default=[{}]):
            """HEP.HEPObject.PersistentIdentifiers
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['persistent_identifiers']
            Type: array
            Elements: HEP.PersistentIdentifierObject
            Structure: [HEP.PersistentIdentifierObject,...,HEP.PersistentIdentifierObject]
            Default: [HEP.PersistentIdentifierObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#persistent-identifiers
            """
            tmp = self.data.get('metadata', {}).get('persistent_identifiers', default)
            return [HEP.PersistentIdentifierObject(i) for i in tmp]
        def PreprintDate(self, default=None):
            """HEP.HEPObject.PreprintDate
            Returns a string containing the value corresponding to the key hepjsonrecord['metadata']['preprint_date']
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#preprint-date
            """
            return self.data.get('metadata', {}).get('preprint_date', default)
        def PublicationInfo(self, default=[{}]):
            """HEP.HEPObject.PublicationInfo
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['publication_info']
            Type: array
            Elements: HEP.PublicationInfoObject
            Structure: [HEP.PublicationInfoObject,...,HEP.PublicationInfoObject]
            Default: [HEP.PublicationInfoObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#publication-info
            """
            tmp = self.data.get('metadata', {}).get('publication_info', default)
            return [HEP.PublicationInfoObject(i) for i in tmp]
        def PublicationType(self, default=None):
            """HEP.HEPObject.PublicationType
            Returns an array of strings containing the value corresponding to the key hepjsonrecord['metadata']['publication_type']
            Type: array
            Elements: strings
            Allowed elements values:    introductory
                                        lectures
                                        manual
                                        review
            Format: [string,...,string]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#publication-type
            """
            return self.data.get('metadata', {}).get('publication_type', default)
        def PublicNotes(self, default=[{}]):
            """HEP.HEPObject.PublicNotes
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['public_notes']
            Type: array
            Elements: HEP.SourcedValueObject
            Structure: [HEP.SourcedValueObject,...,HEP.SourcedValueObject]
            Default: [HEP.SourcedValueObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#public-notes
            """
            tmp = self.data.get('metadata', {}).get('public_notes', default)
            return [HEP.SourcedValueObject(i) for i in tmp]
        #   Recid method inherited from RecidParent
        def RecordAffiliations(self, default=[{}]):
            """HEP.HEPObject.RecordAffiliations
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['record_affiliations']
            Type: array
            Elements: HEP.RecordAffiliationObject
            Structure: [HEP.RecordAffiliationObject,...,HEP.RecordAffiliationObject]
            Default: [HEP.RecordAffiliationObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#record-affiliations
            """
            tmp = self.data.get('metadata', {}).get('record_affiliations', default)
            return [HEP.RecordAffiliationObject(i) for i in tmp]
        def Refereed(self, default=None):
            """HEP.HEPObject.Refereed
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['refereed']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#refereed
            """
            return self.data.get('metadata', {}).get('refereed', default)
        def References(self, default=[{}]):
            """HEP.HEPObject.References
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['references']
            Type: array
            Elements: HEP.ReferenceObject
            Structure: [HEP.ReferenceObject,...,HEP.ReferenceObject]
            Default: [HEP.ReferenceObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#references
            """
            tmp = self.data.get('metadata', {}).get('references', default)
            return [HEP.ReferenceObject(i) for i in tmp]
        def RelatedRecords(self, default=[{}]):
            """HEP.HEPObject.RelatedRecords
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['related_records']
            Type: array
            Elements: HEP.RelatedRecordObject
            Structure: [HEP.RelatedRecordObject,...,HEP.RelatedRecordObject]
            Default: [HEP.RelatedRecordObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#related-records
            """
            tmp = self.data.get('metadata', {}).get('related_records', default)
            return [HEP.RelatedRecordObject(i) for i in tmp]
        def ReportNumbers(self, default=[{}]):
            """HEP.HEPObject.ReportNumbers
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['report_numbers']
            Type: array
            Elements: HEP.ReportNumberObject
            Structure: [HEP.ReportNumberObject,...,HEP.ReportNumberObject]
            Default: [HEP.ReportNumberObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#related-records
            """
            tmp = self.data.get('metadata', {}).get('report_numbers', default)
            return [HEP.ReportNumberObject(i) for i in tmp]
        def Self(self, default={}):
            """HEP.HEPObject.Self
            Returns an object containing the value corresponding to the key hepjsonrecord['metadata']['self']
            Type: HEP.JSONReferenceObject
            Default: HEP.JSONReferenceObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#self
            """
            return HEP.JSONReferenceObject(self.data.get('metadata', {}).get('self', default))
        def TeXKeys(self, default=[None]):
            """HEP.HEPObject.TeXKeys
            Returns an array of string containing the value corresponding to the key hepjsonrecord['metadata']['texkeys']
            Type: array
            Elements: strings
            Format: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#texkeys
            """
            return self.data.get('metadata', {}).get('texkeys', default)
        def ThesisInfo(self, default={}):
            """HEP.HEPObject.ThesisInfo
            Returns an object containing the value corresponding to the key hepjsonrecord['metadata']['thesis_info']
            Type: HEP.ThesisInfoObject
            Default: HEP.ThesisInfoObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#thesis-info
            """
            return HEP.ThesisInfoObject(self.data.get('metadata', {}).get('thesis_info', default))
        def Titles(self, default=[{}]):
            """HEP.HEPObject.Titles
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['titles']
            Type: array
            Elements: HEP.TitleObject
            Structure: [HEP.TitleObject,...,HEP.TitleObject]
            Default: [HEP.TitleObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#titles
            """
            tmp = self.data.get('metadata', {}).get('titles', default)
            return [HEP.TitleObject(i) for i in tmp]
        def TitleTranslations(self, default=[{}]):
            """HEP.HEPObject.TitleTranslations
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['title_translations']
            Type: array
            Elements: HEP.TitleTranslationObject
            Structure: [HEP.TitleTranslationObject,...,HEP.TitleTranslationObject]
            Default: [HEP.TitleTranslationObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#title-translations
            """
            tmp = self.data.get('metadata', {}).get('title_translations', default)
            return [HEP.TitleTranslationObject(i) for i in tmp]
        def URLs(self, default=[{}]):
            """HEP.HEPObject.URLs
            Returns an array of objects containing the value corresponding to the key hepjsonrecord['metadata']['urls']
            Type: array
            Elements: HEP.URLObject
            Structure: [HEP.URLObject,...,HEP.URLObject]
            Default: [HEP.URLObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-urls
            """
            tmp = self.data.get('metadata', {}).get('urls', default)
            return [HEP.URLObject(i) for i in tmp]
        def Withdrawn(self, default=[None]):
            """HEP.HEPObject.Refereed
            Returns a boolean with the value corresponding to the key hepjsonrecord['metadata']['withdrawn']
            Type: boolean
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#withdrawn
            """
            return self.data.get('metadata', {}).get('withdrawn', default)
    class AcceleratorExperimentObject(CuratedRelationParent,RecidParent,RecordParent):
        """Class containing the object HEP.AcceleratorExperimentObject defined by the
        HEP.HEPObject.Experiments method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecidParent
        HEP.RecordParent
        Contains the methods
        HEP.AcceleratorExperimentObject.Accelerator
        HEP.AcceleratorExperimentObject.CuratedRelation
        HEP.AcceleratorExperimentObject.Experiment
        HEP.AcceleratorExperimentObject.Institution
        HEP.AcceleratorExperimentObject.LegacyName
        HEP.AcceleratorExperimentObject.Recid
        HEP.AcceleratorExperimentObject.Record
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-accelerator-experiments
        """
        #   __init__ method inherited from InitParent
        def Accelerator(self, default=None):
            """HEP.AcceleratorExperimentObject.Accelerator
            Returns a string containing the value corresponding to the key 'accelerator'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-accelerator-experiments-items-properties-accelerator
            """
            return self.data.get('accelerator', default)
        #   CuratedRelation method inherited from CuratedRelationParent
        def Experiment(self, default=None):
            """HEP.AcceleratorExperimentObject.Experiment
            Returns a string containing the value corresponding to the key 'experiment'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-accelerator-experiments-items-properties-experiment
            """
            return self.data.get('experiment', default)
        def Institution(self, default=None):
            """HEP.AcceleratorExperimentObject.Institution
            Returns a string containing the value corresponding to the key 'institution'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-accelerator-experiments-items-properties-institution
            """
            return self.data.get('institution', default)
        def LegacyName(self, default=None):
            """HEP.AcceleratorExperimentObject.LegacyName
            Returns a string containing the value corresponding to the key 'legacy_name'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-accelerator-experiments-items-properties-legacy-name
            """
            return self.data.get('legacy_name', default)
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
    class AcquisitionSourceObject(SourceParent):
        """Class containing the object HEP.AcquisitionSourceObject defined by the
        HEP.HEPObject.AcquisitionSource method of the HEP.HEPObject class
        Inherits the Parent Class
        HEP.InitParent (indirectly)
        HEP.SourceParent
        Contains the methods
        HEP.AcquisitionSourceObject.DateTime
        HEP.AcquisitionSourceObject.Email
        HEP.AcquisitionSourceObject.InternalUID
        HEP.AcquisitionSourceObject.Method
        HEP.AcquisitionSourceObject.ORCID
        HEP.AcquisitionSourceObject.Source
        HEP.AcquisitionSourceObject.SubmissionNumber
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html
        """
        #   __init__ method inherited from InitParent
        def DateTime(self, default=None):
            """HEP.AcquisitionSourceObject.DateTime
            Returns a string containing the value corresponding to the key 'datetime'
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-datetime
            """
            return self.data.get('datetime', default)
        def Email(self, default=None):
            """HEP.AcquisitionSourceObject.Email
            Returns a string containing the value corresponding to the key 'email'
            Type: string
            Format: email
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-email
            """
            return self.data.get('email', default)
        def InternalUID(self, default=None):
            """HEP.AcquisitionSourceObject.InternalUID
            Returns an integer containing the value corresponding to the key 'internal_uid'
            Type: integer
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-internal-uid
            """
            return self.data.get('internal_uid', default)
        def Method(self, default=None):
            """HEP.AcquisitionSourceObject.Method
            Returns a string containing the value corresponding to the key 'method'
            Type: string
            Default: None
            Allowed values: submitter
                            oai
                            batchuploader
                            hepcrawl
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-method
            """
            return self.data.get('method', default)
        def ORCID(self, default=None):
            """HEP.AcquisitionSourceObject.ORCID
            Returns a string containing the value corresponding to the key 'orcid'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-orcid
            """
            return self.data.get('orcid', default)
        #   Source method inherited from SourceParent
        def SubmissionNumber(self, default=None):
            """HEP.AcquisitionSourceObject.SubmissionNumber
            Returns a string containing the value corresponding to the key 'submission_number'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/acquisition_source.html#acquisition-source-json-properties-submission-number
            """
            return self.data.get('submission_number', default)
    class AffiliationObject(CuratedRelationParent,RecidParent,RecordParent,ValueParent):
        """Class containing the object HEP.AffiliationObject defined by the
        HEP.AuthorObject.Affiliations method of the HEP.AuthorObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecidParent
        HEP.RecordParent
        HEP.ValueParent
        Contains the methods
        HEP.AffiliationObject.CuratedRelation
        HEP.AffiliationObject.Recid
        HEP.AffiliationObject.Record
        HEP.AffiliationObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=affiliations#hep-json-properties-authors-items-properties-affiliations
        """
        #   __init__ method inherited from InitParent
        #   CuratedRelation method inherited from CuratedRelationParent
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
        #   Value method inherited from ValueParent
        pass
    class ArXivObject(ValueParent):
        """Class containing the object HEP.ArXivObject defined by the
        HEP.HEPObject.ArXivEprints method of the HEP.HEPObject class
        Inherits the Parent Class
        HEP.InitParent (indirectly)
        HEP.ValueParent
        Contains the methods
        HEP.ArXivObject.Categories
        HEP.ArXivObject.PrimaryCategory (this differs from the Inspire-Schema)
        HEP.ArXivObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-arxiv-eprints
        """
        #   __init__ method inherited from InitParent
        def Categories(self, default=[None]):
            """HEP.ArXivObject.Categories
            Returns an array of strings containing the value corresponding to the key 'categories'
            Type: array
            Elements: strings
            Structure: [string,...,string]
            Allowed element values: see documentation
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/arxiv_categories.html#arxiv-categories-json
            """
            return self.data.get('categories', default)
        def PrimaryCategory(self, default=None):
            """HEP.ArXivObject.PrimaryCategory
            Returns the first element of the array HEP.ArXivObject.Categories
            Type: string
            Allowed values: see documentation
            Default: None
            Documentation:
            This function is defined for convenience, but is 'redundant' and it does not correspond to any key in the Inspire Schema
            """
            return self.data.get('categories', [default])[0]
        #   Value method inherited from ValueParent
    class IDObject(SchemaParent,ValueParent):
        """Class containing the object HEP.IDObject defined by the
        HEP.HEPObject.ExternalSystemIdentifiers method of the HEP.HEPObject class and by the
        HEP.ReferenceHEPObject.ExternalSystemIdentifiers method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SchemaParent
        HEP.ValueParent
        Contains the methods
        HEP.IDObject.Schema
        HEP.IDObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-external-system-identifiers
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-external-system-identifiers
        """
        #   __init__ method inherited from InitParent
        #   Schema method inherited from SchemaParent
        #   Value method inherited from ValueParent
        pass
    class AuthorObject(CuratedRelationParent,RecidParent,RecordParent):
        """Class containing the object HEP.AuthorObject defined by the
        HEP.HEPObject.Authors method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.RecidParent
        HEP.CuratedRelationParent
        HEP.RecordParent
        Contains the methods
        HEP.AuthorObject.Affiliations
        HEP.AuthorObject.AlternativeNames
        HEP.AuthorObject.CreditRoles
        HEP.AuthorObject.CuratedRelation
        HEP.AuthorObject.Emails
        HEP.AuthorObject.FullName
        HEP.AuthorObject.IDs
        HEP.AuthorObject.InspireRoles
        HEP.AuthorObject.RawAffiliations
        HEP.AuthorObject.Record
        HEP.AuthorObject.SignatureBlock
        HEP.AuthorObject.UUID
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors
        """
        #   __init__ method inherited from InitParent
        #   Recid method inherited from InitParent
        def Affiliations(self, default=[{}]):
            """HEP.AuthorObject.Affiliations
            Returns an array of objects containing the value corresponding to the key 'affiliations'
            Type: array
            Elements: HEP.AffiliationObject
            Structure: [HEP.AffiliationObject,...,HEP.AffiliationObject]
            Default: [HEP.AffiliationObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-affiliations
            """
            tmp = self.data.get('affiliations', default)
            return [HEP.AffiliationObject(i) for i in tmp]
        def AlternativeNames(self, default=[None]):
            """HEP.AuthorObject.AlternativeNames
            Returns an array of strings containing the value corresponding to the key 'alternative_names'
            Type: array
            Elements: strings
            Structure: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-alternative-names
            """
            return self.data.get('alternative_names', default)
        def CreditRoles(self, default=[None]):
            """HEP.AuthorObject.CreditRoles
            Returns an array of strings containing the value corresponding to the key 'credit_roles'
            Type: array
            Elements: strings
            Structure: [string,...,string]
            Default: [None]
            Allowed element values: Conceptualization
                                    Data curation
                                    Formal analysis
                                    Funding acquisition
                                    Investigation
                                    Methodology
                                    Project administration
                                    Resources
                                    Software
                                    Supervision
                                    Validation
                                    Visualization
                                    Writing - original draft
                                    Writing - review & editing
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-credit-roles
            """
            return self.data.get('credit_roles', default)
        #   CuratedRelation method inherited from CuratedRelationParent
        def Emails(self, default=[None]):
            """HEP.AuthorObject.Emails
            Returns an array of strings containing the value corresponding to the key 'emails'
            Type: array
            Elements: strings
            Structure: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-emails
            """
            return self.data.get('emails', default)
        def FullName(self, default=None):
            """HEP.AuthorObject.FullName
            Returns a string containing the value corresponding to the key 'full_name'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-full-name
            """
            return self.data.get('full_name', default)
        def IDs(self, default=[{}]):
            """HEP.AuthorObject.IDs
            Returns an array of objects containing the value corresponding to the key 'ids'
            Type: array
            Elements: HEP.IDObject
            Structure: [HEP.IDObject,...,HEP.IDObject]
            Default: [HEP.IDObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-ids
            """
            tmp = self.data.get('ids', default)
            return [HEP.IDObject(i) for i in tmp]
        def InspireRoles(self, default=[None]):
            """HEP.AuthorObject.InspireRoles
            Returns an array of strings containing the value corresponding to the key 'inspire_roles'
            Type: array
            Elements: strings
            Structure: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-inspire-roles
            """
            return self.data.get('inspire_roles', default)
        def RawAffiliations(self, default=None):
            """HEP.AuthorObject.RawAffiliations
            Returns an array of pairs [string,string] containing the value corresponding to the key 'raw_affiliations'
            Type: array
            Elements: [string,string]
            Structure: [[string,string],...,[string,string]]
            Default: [[None,None]]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-raw-affiliations
            """
            tmp = self.data.get('raw_affiliations', [{}])
            return [[i.get('source',default),i.get('value',default)] for i in tmp]
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
        def SignatureBlock(self, default=None):
            """HEP.AuthorObject.SignatureBlock
            Returns a string containing the value corresponding to the key 'signature_block'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-signature-block
            """
            return self.data.get('signature_block', default)
        def UUID(self, default=None):
            """HEP.AuthorObject.UUID
            Returns a string containing the value corresponding to the key 'uuid'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-authors-items-properties-uuid
            """
            return self.data.get('uuid', default)
    class AuthorReducedObject(InitParent):
        """Class containing the object HEP.AuthorReducedObject defined by the
        HEP.ReferenceHEPObject.Authors method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.AuthorReducedObject.FullName
        HEP.AuthorReducedObject.InspireRole
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-authors
        """
        #   __init__ method inherited from InitParent
        def FullName(self, default=None):
            """HEP.AuthorReducedObject.FullName
            Returns a string containing the value corresponding to the key 'full_name'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-authors-items-properties-full-name
            """
            return self.data.get('full_name', default)
        def InspireRole(self, default=None):
            """HEP.AuthorReducedObject.InspireRole
            Returns a string containing the value corresponding to the key 'inspire_role'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-authors-items-properties-inspire-role
            """
            return self.data.get('inspire_role', default)
    class BookSeriesObject(InitParent):
        """Class containing the object HEP.BookSeriesObject defined by the
        HEP.ReferenceHEPObject.BookSeries method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.BookSeriesObject.Title
        HEP.BookSeriesObject.Volume
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#book-series
        """
        #   __init__ method inherited from InitParent
        def Title(self, default=None):
            """HEP.BookSeriesObject.Title
            Returns a string containing the value corresponding to the key 'title'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-book-series-properties-title
            """
            return self.data.get('title', default)
        def Volume(self, default=None):
            """HEP.BookSeriesObject.Volume
            Returns a string containing the value corresponding to the key 'volume'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-book-series-properties-volume
            """
            return self.data.get('volume', default)
    class CollaborationObject(RecidParent,RecordParent,ValueParent):
        """Class containing the object HEP.CollaborationObject defined by the
        HEP.HEPObject.Collaborations method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.RecidParent
        HEP.RecordParent
        HEP.ValueParent
        Contains the methods
        HEP.CollaborationObject.Recid
        HEP.CollaborationObject.Record
        HEP.CollaborationObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-collaborations
        """
        #   __init__ method inherited from InitParent
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
        #   Value method inherited from ValueParent
        pass
    class CopyrightObject(MaterialParent,URLParent):
        """Class containing the object HEP.CopyrightObject defined by the
        HEP.HEPObject.Copyright method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.MaterialParent
        HEP.URLParent
        Contains the methods
        HEP.CollaborationObject.Holder
        HEP.CollaborationObject.Material
        HEP.CollaborationObject.Statement
        HEP.CollaborationObject.URL
        HEP.CollaborationObject.Year
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-copyright
        """
        #   __init__ method inherited from InitParent
        def Holder(self, default=None):
            """HEP.CopyrightObject.Holder
            Returns a string containing the value corresponding to the key 'holder'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#holder
            """
            return self.data.get('holder', default)
        #   Material method inherited from MaterialParent
        def Statement(self, default=None):
            """HEP.CopyrightObject.Statement
            Returns a string containing the value corresponding to the key 'statement'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#statement
            """
            return self.data.get('statement', default)
        #   URL method inherited from URLParent
        def Year(self, default=None):
            """HEP.CopyrightObject.Year
            Returns a string containing the value corresponding to the key 'year'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#year
            """
            return self.data.get('year', default)
    class DesyBookkeepingObject(InitParent):
        """Class containing the object HEP.DesyBookkeepingObject defined by the
        HEP.HEPObject.DesyBookkeeping method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.DesyBookkeepingObject.Date
        HEP.DesyBookkeepingObject.Expert
        HEP.DesyBookkeepingObject.Ientifier
        HEP.DesyBookkeepingObject.Status
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping
        """
        #   __init__ method inherited from InitParent
        def Date(self, default=None):
            """HEP.DesyBookkeepingObject.Date
            Returns a string containing the value corresponding to the key 'date'
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping-items-properties-date
            """
            return self.data.get('date', default)
        def Expert(self, default=None):
            """HEP.DesyBookkeepingObject.Expert
            Returns a string containing the value corresponding to the key 'expert'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping-items-properties-expert
            """
            return self.data.get('expert', default)
        def Ientifier(self, default=None):
            """HEP.DesyBookkeepingObject.Ientifier
            Returns a string containing the value corresponding to the key 'identifier'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping-items-properties-identifier
            """
            return self.data.get('identifier', default)
        def Status(self, default=None):
            """HEP.DesyBookkeepingObject.Status
            Returns a string containing the value corresponding to the key 'status'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping-items-properties-status
            """
            return self.data.get('status', default)
    class DocumentObject(HiddenParent,KeyParent,MaterialParent,SourceParent,URLParent):
        """Class containing the object HEP.DocumentObject defined by the
        HEP.HEPObject.Documents method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.HiddenParent
        HEP.KeyParent
        HEP.MaterialParent
        HEP.SourceParent
        HEP.URLParent
        Contains the methods
        HEP.DocumentObject.Description
        HEP.DocumentObject.FullText
        HEP.DocumentObject.Hidden
        HEP.DocumentObject.Key
        HEP.DocumentObject.Material
        HEP.DocumentObject.OriginalURL
        HEP.DocumentObject.Source
        HEP.DocumentObject.URL
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-desy-bookkeeping
        """
        #   __init__ method inherited from InitParent
        def Description(self, default=None):
            """HEP.DocumentObject.Description
            Returns a string containing the value corresponding to the key 'description'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-documents-items-properties-description
            """
            return self.data.get('description', default)
        def FullText(self, default=None):
            """HEP.DocumentObject.FullText
            Returns a string containing the value corresponding to the key 'fulltext'
            Type: boolean
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-documents-items-properties-fulltext
            """
            return self.data.get('fulltext', default)
        #   Hidden method inherited from HiddenParent
        #   Key method inherited from KeyParent
        #   Material method inherited from MaterialParent
        def OriginalURL(self, default=None):
            """HEP.DocumentObject.OriginalURL
            Returns a string containing the value corresponding to the key 'original_url'
            Type: string
            Format: uri
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-documents-items-properties-original-url
            """
            return self.data.get('original_url', default)
        #   Source method inherited from SourceParent
        #   URL method inherited from URLParent
    class DOIObject(MaterialParent,SourcedValueObject):
        """Class containing the object HEP.DOIObject defined by the
        HEP.HEPObject.DOIs method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.MaterialParent
        HEP.SourcedValueObject
        HEP.SourceParent (indirectly)
        HEP.ValueParent (indirectly)
        Contains the methods
        HEP.DOIObject.Material
        HEP.DOIObject.Source
        HEP.DOIObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-dois
        """
        #   __init__ method inherited from InitParent
        #   Material method inherited from MaterialParent
        #   Source method inherited from SourcedValueObject
        #   Value method inherited from SourcedValueObject
        pass
    class FigureObject(KeyParent,MaterialParent,SourceParent,URLParent):
        """Class containing the object HEP.FigureObject defined by the
        HEP.HEPObject.Figures method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.KeyParent
        HEP.MaterialParent
        HEP.SourceParent
        HEP.URLParent
        Contains the methods
        HEP.FigureObject.Caption
        HEP.FigureObject.Key
        HEP.FigureObject.Label
        HEP.FigureObject.Material
        HEP.FigureObject.Source
        HEP.FigureObject.URL
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-figures
        """
        #   __init__ method inherited from InitParent
        def Caption(self, default=None):
            """HEP.FigureObject.Caption
            Returns a string containing the value corresponding to the key 'caption'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-figures-items-properties-caption
            """
            return self.data.get('caption', default)
        #   Key method inherited from KeyParent
        def Label(self, default=None):
            """HEP.FigureObject.Label
            Returns a string containing the value corresponding to the key 'label'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-figures-items-properties-label
            """
            return self.data.get('label', default)
        #   Material method inherited from MaterialParent
        #   Source method inherited from SourceParent
        #   URL method inherited from URLParent
    class FundingObject(InitParent):
        """Class containing the object HEP.FundingObject defined by the
        HEP.HEPObject.FundingInfo method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.FundingObject.Agency
        HEP.FundingObject.GrantNumber
        HEP.FundingObject.ProjectNumber
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-funding-info
        """
        #   __init__ method inherited from InitParent
        def Agency(self, default=None):
            """HEP.FundingObject.Agency
            Returns a string containing the value corresponding to the key 'agency'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-funding-info-items-properties-agency
            """
            return self.data.get('agency', default)
        def GrantNumber(self, default=None):
            """HEP.FundingObject.GrantNumber
            Returns a string containing the value corresponding to the key 'grant_number'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-funding-info-items-properties-grant-number
            """
            return self.data.get('grant_number', default)
        def ProjectNumber(self, default=None):
            """HEP.FundingObject.ProjectNumber
            Returns a string containing the value corresponding to the key 'project_number'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-funding-info-items-properties-project-number
            """
            return self.data.get('project_number', default)
    class KeywordObject(SchemaParent,SourcedValueObject):
        """Class containing the object HEP.KeywordObject defined by the
        HEP.HEPObject.Keywords method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SchemaParent
        HEP.SourcedValueObject
        HEP.SourceParent (indirectly)
        HEP.ValueParent (indirectly)
        Contains the methods
        HEP.KeywordObject.Schema
        HEP.KeywordObject.Source
        HEP.KeywordObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-keywords
        """
        #   __init__ method inherited from InitParent
        #   Schema method inherited from SchemaParent
        #   Source method inherited from SourcedValueObject
        #   Value method inherited from SourcedValueObject
        pass
    class ImprintObject(InitParent):
        """Class containing the object HEP.ImprintObject defined by the
        HEP.HEPObject.Imprints method of the HEP.HEPObject class and by the class
        HEP.ReferenceHEPObject.Imprint method of the HEP.ReferenceHEPObject
        Inherits the Parent Class
        HEP.InitParent
        Contains the methods
        HEP.ImprintObject.Date
        HEP.ImprintObject.Place
        HEP.ImprintObject.Publisher
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-imprints
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-imprint
        """
        #   __init__ method inherited from InitParent
        def Date(self, default=None):
            """HEP.ImprintObject.Date
            Returns a string containing the value corresponding to the key 'date'
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-imprints-items-properties-date
            """
            return self.data.get('date', default)
        def Place(self, default=None):
            """HEP.ImprintObject.Place
            Returns a string containing the value corresponding to the key 'place'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-imprints-items-properties-place
            """
            return self.data.get('place', default)
        def Publisher(self, default=None):
            """HEP.ImprintObject.Publisher
            Returns a string containing the value corresponding to the key 'publisher'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-imprints-items-properties-publisher
            """
            return self.data.get('publisher', default)
    class InspireFieldObject(SourceParent):
        """Class containing the object HEP.InspireFieldObject defined by the
        HEP.HEPObject.InspireCategories method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SourceParent
        Contains the methods
        HEP.InspireFieldObject.Source
        HEP.InspireFieldObject.Term
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#inspire-categories
        """
        #   __init__ method inherited from InitParent
        #   Source method inherited from SourceParent
        def Term(self, default=None):
            """HEP.InspireFieldObject.Term
            Returns a string containing the value corresponding to the key 'term'
            Type: string
            Allowed values: Accelerators
                            Astrophysics
                            Computing
                            Data Analysis and Statistics
                            Experiment-HEP
                            Experiment-Nucl
                            General Physics
                            Gravitation and Cosmology
                            Instrumentation
                            Lattice
                            Math and Math Physics
                            Other
                            Phenomenology-HEP
                            Theory-HEP
                            Theory-Nucl
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/inspire_field.html#inspire-field-json-properties-term
            """
            return self.data.get('term', default)
    class InstitutionObject(CuratedRelationParent,RecidParent,RecordParent,ValueParent):
        """Class containing the object HEP.AffiliationObject defined by the
        HEP.ThesisInfoObject.Institutions method of the HEP.ThesisInfoObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecidParent
        HEP.RecordParent
        HEP.ValueParent
        Contains the methods
        HEP.InstitutionObject.CuratedRelation
        HEP.InstitutionObject.Name
        HEP.InstitutionObject.Recid
        HEP.InstitutionObject.Record
        HEP.InstitutionObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=affiliations#hep-json-properties-thesis-info-properties-institutions
        """
        #   __init__ method inherited from InitParent
        #   CuratedRelation method inherited from CuratedRelationParent
        def Name(self, default=None):
            """HEP.InstitutionObject.Name
            Returns a string containing the value corresponding to the key 'name'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=affiliations#hep-json-properties-thesis-info-properties-institutions-items-properties-name
            """
            return self.data.get('name', default)
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
        #   Value method inherited from ValueParent
    class ISBNObject(ValueParent):
        """Class containing the object HEP.ISBNObject defined by the
        HEP.HEPObject.ISBNs method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.ValueParent
        Contains the methods
        HEP.ISBNObject.Medium
        HEP.ISBNObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=affiliations#hep-json-properties-isbns
        """
        #   __init__ method inherited from InitParent
        def Medium(self, default=None):
            """HEP.ISBNObject.Medium
            Returns a string containing the value corresponding to the key 'medium'
            Type: string
            Allowed values: hardcover
                            online
                            print
                            softcover
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html?highlight=affiliations#hep-json-properties-isbns-items-properties-medium
            """
            return self.data.get('medium', default)
        #   Value method inherited from ValueParent
    class LicenseObject(MaterialParent,URLParent):
        """Class containing the object HEP.LicenseObject defined by the
        HEP.HEPObject.Licenses method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.MaterialParent
        HEP.URLParent
        Contains the methods
        HEP.LicenseObject.Imposing
        HEP.LicenseObject.License
        HEP.LicenseObject.Material
        HEP.LicenseObject.URL
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-license
        """
        #   __init__ method inherited from InitParent
        def Imposing(self, default=None):
            """HEP.LicenseObject.Imposing
            Returns a string containing the value corresponding to the key 'imposing'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-license-items-properties-imposing
            """
            return self.data.get('imposing', default)
        def License(self, default=None):
            """HEP.LicenseObject.License
            Returns a string containing the value corresponding to the key 'license'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-license-items-properties-license
            """
            return self.data.get('license', default)
        #   Material method inherited from MaterialParent
        #   URL  method inherited from URLParent
    class PersistentIdentifierObject(MaterialParent,SchemaParent,SourcedValueObject):
        """Class containing the object HEP.PersistentIdentifierObject defined by the
        HEP.HEPObject.PersistentIdentifiers method of the HEP.HEPObject class and by the
        HEP.ReferenceHEPObject.PersistentIdentifiers method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.MaterialParent
        HEP.SchemaParent
        HEP.SourcedValueObject
        Contains the methods
        HEP.PersistentIdentifierObject.Material
        HEP.PersistentIdentifierObject.Schema
        HEP.PersistentIdentifierObject.Source
        HEP.PersistentIdentifierObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-persistent-identifiers
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-persistent-identifiers
        """
        #   __init__ method inherited from InitParent
        #   Material method inherited from MaterialParent
        #   Schema method inherited from SchemaParent
        #   Source  method inherited from SourcedValueObject
        #   Value  method inherited from SourcedValueObject
        pass
    class PublicationInfoObject(CuratedRelationParent,HiddenParent,MaterialParent):
        """Class containing the object HEP.PublicationInfoObject defined by the
        HEP.HEPObject.PublicationInfo method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.HiddenParent
        HEP.MaterialParent
        Contains the methods
        HEP.PublicationInfoObject.ArtID
        HEP.PublicationInfoObject.Cnum
        HEP.PublicationInfoObject.ConfAcronym
        HEP.PublicationInfoObject.ConferenceRecord
        HEP.PublicationInfoObject.CuratedRelation
        HEP.PublicationInfoObject.JournalIssue
        HEP.PublicationInfoObject.JournalRecord
        HEP.PublicationInfoObject.JournalTitle
        HEP.PublicationInfoObject.JournalVolume
        HEP.PublicationInfoObject.Material
        HEP.PublicationInfoObject.PageEnd
        HEP.PublicationInfoObject.PageStart
        HEP.PublicationInfoObject.ParentISBN
        HEP.PublicationInfoObject.ParentRecord
        HEP.PublicationInfoObject.ParentReportNumber
        HEP.PublicationInfoObject.PubInfoFreeText
        HEP.PublicationInfoObject.Year
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info
        """
        #   __init__ method inherited from InitParent
        def ArtID(self, default=None):
            """HEP.PublicationInfoObject.ArtID
            Returns a string containing the value corresponding to the key 'artid'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-artid
            """
            return self.data.get('artid', default)
        def Cnum(self, default=None):
            """HEP.PublicationInfoObject.Cnum
            Returns a string containing the value corresponding to the key 'cnum'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-cnum
            """
            return self.data.get('cnum', default)
        def ConfAcronym(self, default=None):
            """HEP.PublicationInfoObject.ConfAcronym
            Returns a string containing the value corresponding to the key 'conf_acronym'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-conf-acronym
            """
            return self.data.get('conf_acronym', default)
        def ConferenceRecord(self, default={}):
            """HEP.PublicationInfoObject.ConferenceRecord
            Returns an object containing the value corresponding to the key 'conference_record'
            Type: HEP.JSONReferenceObject
            Default: HEP.JSONReferenceObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-conference-record
            """
            return HEP.JSONReferenceObject(self.data.get('conference_record', default))
        #   CuratedRelation method inherited from CuratedRelationParent
        #   Hidden method inherited from HiddenParent
        def JournalIssue(self, default=None):
            """HEP.PublicationInfoObject.JournalIssue
            Returns a string containing the value corresponding to the key 'journal_issue'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-journal-issue
            """
            return self.data.get('journal_issue', default)
        def JournalRecord(self, default={}):
            """HEP.PublicationInfoObject.JournalRecord
            Returns an object containing the value corresponding to the key 'journal_record'
            Type: HEP.JSONReferenceObject
            Default: HEP.JSONReferenceObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-journal-record
            """
            return HEP.JSONReferenceObject(self.data.get('journal_record', default))
        def JournalTitle(self, default=None):
            """HEP.PublicationInfoObject.JournalTitle
            Returns a string containing the value corresponding to the key 'journal_title'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-journal-title
            """
            return self.data.get('journal_title', default)
        def JournalVolume(self, default=None):
            """HEP.PublicationInfoObject.JournalVolume
            Returns a string containing the value corresponding to the key 'journal_volume'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-journal-volume
            """
            return self.data.get('journal_volume', default)
        #   Material method inherited from MaterialParent
        def PageEnd(self, default=None):
            """HEP.PublicationInfoObject.PageEnd
            Returns a string containing the value corresponding to the key 'page_end'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-page-end
            """
            return self.data.get('page_end', default)
        def PageStart(self, default=None):
            """HEP.PublicationInfoObject.PageStart
            Returns a string containing the value corresponding to the key 'page_start'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-page-start
            """
            return self.data.get('page_start', default)
        def ParentISBN(self, default=None):
            """HEP.PublicationInfoObject.ParentISBN
            Returns a string containing the value corresponding to the key 'parent_isbn'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-parent-isbn
            """
            return self.data.get('parent_isbn', default)
        def ParentRecord(self, default={}):
            """HEP.PublicationInfoObject.ParentRecord
            Returns an object containing the value corresponding to the key 'parent_record'
            Type: HEP.JSONReferenceObject
            Default: HEP.JSONReferenceObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-parent-record
            """
            return HEP.JSONReferenceObject(self.data.get('parent_record', default))
        def ParentReportNumber(self, default=None):
            """HEP.PublicationInfoObject.ParentReportNumber
            Returns a string containing the value corresponding to the key 'parent_report_number'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-parent-report-number
            """
            return self.data.get('parent_report_number', default)
        def PubInfoFreeText(self, default=None):
            """HEP.PublicationInfoObject.PubInfoFreeText
            Returns a string containing the value corresponding to the key 'pubinfo_freetext'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-pubinfo-freetext
            """
            return self.data.get('pubinfo_freetext', default)
        def Year(self, default=None):
            """HEP.PublicationInfoObject.Year
            Returns a string containing the value corresponding to the key 'year'
            Type: integer
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-publication-info-items-properties-year
            """
            return self.data.get('year', default)
    class PublicationInfoReducedObject(MaterialParent):
        """Class containing the object HEP.PublicationInfoReducedObject defined by the
        HEP.ReferenceHEPObject.PublicationInfo method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.MaterialParent
        Contains the methods
        HEP.PublicationInfoReducedObject.ArtID
        HEP.PublicationInfoReducedObject.Cnum
        HEP.PublicationInfoReducedObject.JournalIssue
        HEP.PublicationInfoReducedObject.JournalTitle
        HEP.PublicationInfoReducedObject.JournalVolume
        HEP.PublicationInfoReducedObject.Material
        HEP.PublicationInfoReducedObject.PageEnd
        HEP.PublicationInfoReducedObject.PageStart
        HEP.PublicationInfoReducedObject.ParentISBN
        HEP.PublicationInfoReducedObject.ParentReportNumber
        HEP.PublicationInfoReducedObject.ParentTitle
        HEP.PublicationInfoReducedObject.Year
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info
        """
        #   __init__ method inherited from InitParent
        def ArtID(self, default=None):
            """HEP.PublicationInfoReducedObject.ArtID
            Returns a string containing the value corresponding to the key 'artid'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-artid
            """
            return self.data.get('artid', default)
        def Cnum(self, default=None):
            """HEP.PublicationInfoReducedObject.Cnum
            Returns a string containing the value corresponding to the key 'cnum'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-cnum
            """
            return self.data.get('cnum', default)
        def JournalIssue(self, default=None):
            """HEP.PublicationInfoReducedObject.JournalIssue
            Returns a string containing the value corresponding to the key 'journal_issue'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-journal-issue
            """
            return self.data.get('journal_issue', default)
        def JournalTitle(self, default=None):
            """HEP.PublicationInfoReducedObject.JournalTitle
            Returns a string containing the value corresponding to the key 'journal_title'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-journal-title
            """
            return self.data.get('journal_title', default)
        def JournalVolume(self, default=None):
            """HEP.PublicationInfoReducedObject.JournalVolume
            Returns a string containing the value corresponding to the key 'journal_volume'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-journal-volume
            """
            return self.data.get('journal_volume', default)
        #   Material method inherited from MaterialParent
        def PageEnd(self, default=None):
            """HEP.PublicationInfoReducedObject.PageEnd
            Returns a string containing the value corresponding to the key 'page_end'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-page-end
            """
            return self.data.get('page_end', default)
        def PageStart(self, default=None):
            """HEP.PublicationInfoReducedObject.PageStart
            Returns a string containing the value corresponding to the key 'page_start'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-page-start
            """
            return self.data.get('page_start', default)
        def ParentISBN(self, default=None):
            """HEP.PublicationInfoReducedObject.ParentISBN
            Returns a string containing the value corresponding to the key 'parent_isbn'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-parent-isbn
            """
            return self.data.get('parent_isbn', default)
        def ParentReportNumber(self, default=None):
            """HEP.PublicationInfoReducedObject.ParentReportNumber
            Returns a string containing the value corresponding to the key 'parent_report_number'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-parent-report-number
            """
            return self.data.get('parent_report_number', default)
        def ParentTitle(self, default=None):
            """HEP.PublicationInfoReducedObject.ParentTitle
            Returns a string containing the value corresponding to the key 'parent_title'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-parent-title
            """
            return self.data.get('parent_title', default)
        def Year(self, default=None):
            """HEP.PublicationInfoReducedObject.Year
            Returns a string containing the value corresponding to the key 'year'
            Type: integer
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info-properties-year
            """
            return self.data.get('year', default)
    class RawReferenceObject(SchemaParent,SourcedValueObject):
        """Class containing the object HEP.RawReferenceObject defined by the
        HEP.ReferenceObject.RawRefs method of the HEP.ReferenceObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SchemaParent
        HEP.SourcedValueObject
        HEP.SourceParent (indirectly)
        HEP.ValueParent (indirectly)
        Contains the methods
        HEP.RawReferenceObject.Schema
        HEP.RawReferenceObject.Source
        HEP.RawReferenceObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-references-items-properties-raw-refs
        """
        #   __init__ method inherited from InitParent
        #   Schema method inherited from SchemaParent
        #   Source method inherited from SourcedValueObject
        #   Value method inherited from SourcedValueObject
        pass
    class RecordAffiliationObject(CuratedRelationParent,RecordParent,ValueParent):
        """Class containing the object HEP.RecordAffiliationObject defined by the
        HEP.HEPObject.RecordAffiliations method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecordParent
        HEP.ValueParent
        Contains the methods
        HEP.RecordAffiliationObject.CuratedRelation
        HEP.RecordAffiliationObject.Record
        HEP.RecordAffiliationObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-record-affiliations
        """
        #   __init__ method inherited from InitParent
        #   CuratedRelation method inherited from CuratedRelationParent
        #   Record method inherited from RecordParent
        #   Value method inherited from ValueParent
        pass
    class RecordFile(KeyParent):
        """Class containing the object HEP.RecordFile defined by the
        HEP.HEPObject.Files method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.KeyParent
        Contains the methods
        HEP.RecordFile.Bucket
        HEP.RecordFile.Checksum
        HEP.RecordFile.Key
        HEP.RecordFile.Size
        HEP.RecordFile.VersionID
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-files
        """
        #   __init__ method inherited from InitParent
        def Bucket(self, default=None):
            """HEP.RecordFile.Bucket
            Returns a string containing the value corresponding to the key 'bucket'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/records-files.html#records-files-json-properties-bucket
            """
            return self.data.get('bucket', default)
        def Checksum(self, default=None):
            """HEP.RecordFile.Checksum
            Returns a string containing the value corresponding to the key 'checksum'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/records-files.html#records-files-json-properties-checksum
            """
            return self.data.get('checksum', default)
        #   Key method inherited from KeyParent
        def Size(self, default=None):
            """HEP.RecordFile.Size
            Returns an integer with the value corresponding to the key 'size'
            Type: integer
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/records-files.html#records-files-json-properties-size
            """
            return self.data.get('size', default)
        def VersionID(self, default=None):
            """HEP.RecordFile.VersionID
            Returns a string containing the value corresponding to the key 'version_id'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/records-files.html#records-files-json-properties-version-id
            """
            return self.data.get('version_id', default)
    class TitleObject(SourceParent,TitleParent):
        """Class containing the object HEP.TitleObject defined by the
        HEP.HEPObject.Titles method of the HEP.HEPObject class and by the
        HEP.ReferenceHEPObject.Title method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SourceParent
        HEP.TitleParent
        Contains the methods
        HEP.ThesisInfoObject.Source
        HEP.ThesisInfoObject.Subtitle
        HEP.ThesisInfoObject.Title
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-titles
        """
        #   __init__ method inherited from InitParent
        #   Source method inherited from SourceParent
        #   Subtitle method inherited from TitleParent
        #   Title method inherited from TitleParent
        pass
    class URLObject(ValueParent):
        """Class containing the object HEP.URLObject defined by the
        HEP.HEPObject.URLs method of the HEP.HEPObject class and by the
        HEP.ReferenceHEPObject.URLs method of the HEP.ReferenceHEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.ValueParent
        Contains the methods
        HEP.URLObject.Description
        HEP.URLObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-urls
        """
        #   __init__ method inherited from InitParent
        def Description(self, default=None):
            """HEP.URLObject.Description
            Returns a string containing the value corresponding to the key 'description'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/url.html#url-json-properties-description
            """
            return self.data.get('description', default)
        #   Value method inherited from ValueParent
    class ReferenceHEPObject(SchemaParent,ValueParent):
        """Class containing the object HEP.ReferenceHEPObject defined by the
        HEP.ReferenceObject.Reference method of the HEP.ReferenceObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SchemaParent
        HEP.ValueParent
        Contains the methods
        HEP.ReferenceHEPObject.ArXivEprint
        HEP.ReferenceHEPObject.Authors
        HEP.ReferenceHEPObject.BookSeries
        HEP.ReferenceHEPObject.Collaborations
        HEP.ReferenceHEPObject.DocumentType
        HEP.ReferenceHEPObject.DOIs
        HEP.ReferenceHEPObject.ExternalSystemIdentifiers
        HEP.ReferenceHEPObject.Schema
        HEP.ReferenceHEPObject.Value
        HEP.ReferenceHEPObject.Imprints
        HEP.ReferenceHEPObject.ISBN
        HEP.ReferenceHEPObject.Label
        HEP.ReferenceHEPObject.Misc
        HEP.ReferenceHEPObject.PersistentIdentifiers
        HEP.ReferenceHEPObject.PublicationInfo
        HEP.ReferenceHEPObject.ReportNumbers
        HEP.ReferenceHEPObject.TeXKey
        HEP.ReferenceHEPObject.Title
        HEP.ReferenceHEPObject.URLs
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json
        """
        #   __init__ method inherited from InitParent
        def ArXivEprint(self, default=None):
            """HEP.ReferenceHEPObject.ArXivEprint
            Returns a string containing the value corresponding to the key 'arxiv_eprint'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-arxiv-eprint
            """
            return self.data.get('arxiv_eprint', default)
        def Authors(self, default=[{}]):
            """HEP.ReferenceHEPObject.Authors
            Returns an array of objects containing the value corresponding to the key 'authors'
            Type: array
            Elements: HEP.AuthorReducedObject
            Structure: [HEP.AuthorReducedObject,...,HEP.AuthorReducedObject]
            Default: [HEP.AuthorReducedObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-authors
            """
            tmp = self.data.get('authors', default)
            return [HEP.AuthorReducedObject(i) for i in tmp]
        def BookSeries(self, default={}):
            """HEP.ReferenceHEPObject.BookSeries
            Returns an object containing the value corresponding to the key 'book_series'
            Type: HEP.BookSeriesObject
            Default: HEP.BookSeriesObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-book-series
            """
            return HEP.BookSeriesObject(self.data.get('book_series', default))
        def Collaborations(self, default=[None]):
            """HEP.ReferenceHEPObject.Collaborations
            Returns an array of strings containing the value corresponding to the key 'collaborations'
            Type: array
            Elements: strings
            Format: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-collaborations
            """
            return self.data.get('collaborations', default)
        def DocumentType(self, default='article'):
            """HEP.ReferenceHEPObject.DocumentType
            Returns a string containing the value corresponding to the key 'document_type'
            Type: string
            Default: 'article'
            Allowed values: activity report
                            article
                            book
                            book chapter
                            conference paper
                            note
                            proceedings
                            report
                            thesis
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-document-type
            """
            return self.data.get('document_type', [{}])
        def DOIs(self, default=[None]):
            """HEP.ReferenceHEPObject.DOIs
            Returns an array of strings containing the value corresponding to the key 'DOIs'
            Type: array
            Elements: strings
            Format: [string,...,string]
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-dois
            """
            return self.data.get('dois', default)
        def ExternalSystemIdentifiers(self, default=[{}]):
            """HEP.ReferenceHEPObject.ExternalSystemIdentifiers
            Returns an array of objects containing the value corresponding to the key 'external_system_identifiers'
            Type: array
            Elements: HEP.IDObject
            Format: [HEP.IDObject,...,HEP.IDObject]
            Default: [HEP.IDObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-external-system-identifiers
            """
            tmp = self.data.get('external_system_identifiers', default)
            return [HEP.IDObject(i) for i in tmp]
        #   Schema method inherited from SchemaParent
        #   Value method inherited from ValueParent
        def Imprint(self, default={}):
            """HEP.ReferenceHEPObject.Imprint
            Returns an object containing the value corresponding to the key 'imprint'
            Type: HEP.ImprintObject
            Default: HEP.ImprintObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-imprint
            """
            return HEP.ImprintObject(self.data.get('imprint', default))
        def ISBN(self, default=None):
            """HEP.ReferenceHEPObject.ISBN
            Returns a string containing the value corresponding to the key 'isbn'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-isbn
            """
            return self.data.get('isbn', default)
        def Label(self, default=None):
            """HEP.ReferenceHEPObject.Label
            Returns a string containing the value corresponding to the key 'label'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-label
            """
            return self.data.get('label', default)
        def Misc(self, default=[None]):
            """HEP.ReferenceHEPObject.Misc
            Returns an array of strings containing the value corresponding to the key 'misc'
            Type: string
            Default: [None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-misc
            """
            return self.data.get('misc', default)
        def PersistentIdentifiers(self, default=[{}]):
            """HEP.ReferenceHEPObject.PersistentIdentifiers
            Returns an array of objects containing the value corresponding to the key 'persistent_identifiers'
            Type: array
            Elements: HEP.PersistentIdentifierObject
            Format: [HEP.PersistentIdentifierObject,...,HEP.PersistentIdentifierObject]
            Default: [HEP.PersistentIdentifierObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-persistent-identifiers
            """
            tmp = self.data.get('persistent_identifiers', default)
            return [HEP.PersistentIdentifierObject(i) for i in tmp]
        def PublicationInfo(self, default={}):
            """HEP.ReferenceHEPObject.PublicationInfo
            Returns an object containing the value corresponding to the key 'publication_info'
            Type: HEP.PublicationInfoReducedObject
            Default: HEP.PublicationInfoReducedObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-publication-info
            """
            return HEP.PublicationInfoReducedObject(self.data.get('publication_info', default))
        def ReportNumbers(self, default=[None]):
            """HEP.ReferenceHEPObject.ReportNumbers
            Returns an array of strings containing the value corresponding to the key 'report_numbers'
            Type: array
            Elements: strings
            Format: [string,...,string]
            Default:[None]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-report-numbers
            """
            return self.data.get('report_numbers', default)
        def TeXKey(self, default=None):
            """HEP.ReferenceHEPObject.TeXKey
            Returns a string containing the value corresponding to the key 'texkey'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-texkey
            """
            return self.data.get('texkey', default)
        def Title(self, default={}):
            """HEP.ReferenceHEPObject.Title
            Returns an object containing the value corresponding to the key 'title'
            Type: HEP.TitleObject
            Default: HEP.TitleObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-title
            """
            return HEP.TitleObject(self.data.get('title', default))
        def URLs(self, default=[{}]):
            """HEP.ReferenceHEPObject.URLs
            Returns an array of objects containing the value corresponding to the key 'urls'
            Type: array
            Elements: HEP.URLObject
            Structure: [HEP.URLObject,...,HEP.URLObject]
            Default: [HEP.URLObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/reference.html#reference-json-properties-authors
            """
            tmp = self.data.get('urls', default)
            return [HEP.URLObject(i) for i in tmp]
    class ReferenceObject(CuratedRelationParent,RecidParent,RecordParent):
        """Class containing the object HEP.ReferenceObject defined by the
        HEP.HEPObject.References method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecidParent
        HEP.RecordParent
        Contains the methods
        HEP.ReferenceObject.CuratedRelation
        HEP.ReferenceObject.LegacyCurated
        HEP.ReferenceObject.RawRefs
        HEP.ReferenceObject.Recid
        HEP.ReferenceObject.Record
        HEP.ReferenceObject.Reference
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-references
        """
        #   __init__ method inherited from InitParent
        #   CuratedRelation method inherited from CuratedRelationParent
        def LegacyCurated(self, default=None):
            """HEP.ReferenceObject.LegacyCurated
            Returns a boolean True/False corresponding to the key 'legacy_curated'
            Type: boolean
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-references-items-properties-legacy-curated
            """
            return self.data.get('legacy_curated', default)
        def RawRefs(self, default=[{}]):
            """HEP.ReferenceObject.RawRefs
            Returns an array of objects containing the value corresponding to the key 'raw_refs'
            Type: array
            Elements: HEP.RawReferenceObject
            Structure: [HEP.RawReferenceObject,...,HEP.RawReferenceObject]
            Default: [HEP.RawReferenceObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-references-items-properties-raw-refs
            """
            tmp = self.data.get('raw_refs', default)
            return [HEP.RawReferenceObject(i) for i in tmp]
        #   Recid method inherited from RecidParent
        #   Record method inherited from RecordParent
        def Reference(self, default={}):
            """HEP.ReferenceObject.Reference
            Returns an object containing the value corresponding to the key 'reference'
            Type: HEP.ReferenceHEPObject
            Default: HEP.ReferenceHEPObject({})
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-references-items-properties-raw-refs
            """
            return HEP.ReferenceHEPObject(self.data.get('reference', default))
    class ReportNumberObject(HiddenParent,SourcedValueObject):
        """Class containing the object HEP.ReportNumberObject defined by the
        HEP.HEPObject.ReportNumbers method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.HiddenParent
        HEP.SourcedValueObject
        HEP.Source (indirectly)
        HEP.Value (indirectly)
        Contains the methods
        HEP.ReportNumberObject.Hidden
        HEP.ReportNumberObject.LegacyCurated
        HEP.ReportNumberObject.Source
        HEP.ReportNumberObject.Value
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-report-numbers
        """
        #   __init__ method inherited from InitParent
        #   Hidden method inherited from HiddenParent
        #   Source method inherited from SourcedValueObject
        #   Value method inherited from SourcedValueObject
        pass
    class RelatedRecordObject(CuratedRelationParent,RecidParent,RecordParent):
        """Class containing the object HEP.RelatedRecordObject defined by the
        HEP.HEPObject.RelatedRecords method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.CuratedRelationParent
        HEP.RecidParent
        HEP.RecordParent
        Contains the methods
        HEP.RelatedRecordObject.CuratedRelation
        HEP.RelatedRecordObject.Recid
        HEP.RelatedRecordObject.Record
        HEP.RelatedRecordObject.Relation
        HEP.RelatedRecordObject.RelationFreeText
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-related-records
        """
        #   __init__ method inherited from InitParent
        #   CuratedRelation method inherited from CuratedRelationParent
        #   Recid method inherited from RecordParent
        #   Record method inherited from RecordParent
        def Relation(self, default=None):
            """HEP.RelatedRecordObject.Relation
            Returns a string containing the value corresponding to the key 'relation'
            Type: string
            Allowed values: predecessor
                            successor
                            parent
                            commented
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/related_record.html#related-record-json-properties-relation
            """
            return self.data.get('relation', default)
        def RelationFreeText(self, default=None):
            """HEP.RelatedRecordObject.RelationFreeText
            Returns a string containing the value corresponding to the key 'relation_freetext'
            Type: string
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/elements/related_record.html#related-record-json-properties-relation
            """
            return self.data.get('relation_freetext', default)
    class ThesisInfoObject(InitParent):
        """Class containing the object HEP.ThesisInfoObject defined by the
        HEP.HEPObject.ThesisInfo method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent
        Contains the methods
        HEP.ThesisInfoObject.Date
        HEP.ThesisInfoObject.DefenceDate
        HEP.ThesisInfoObject.DegreeType
        HEP.ThesisInfoObject.Institutions
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-thesis-info
        """
        #   __init__ method inherited from InitParent
        def Date(self, default=None):
            """HEP.ThesisInfoObject.Date
            Returns a string containing the value corresponding to the key 'date'
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-thesis-info-properties-date
            """
            return self.data.get('date', default)
        def DefenceDate(self, default=None):
            """HEP.ThesisInfoObject.DefenceDate
            Returns a string containing the value corresponding to the key 'defense_date'
            Type: string
            Format: ISO
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-thesis-info-properties-defense-date
            """
            return self.data.get('defense_date', default)
        def DegreeType(self, default=None):
            """HEP.ThesisInfoObject.DegreeType
            Returns a string containing the value corresponding to the key 'degree_type'
            Type: string
            Allowed values: other
                            diploma
                            bachelor
                            laurea
                            master
                            phd
                            habilitation
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-thesis-info-properties-degree-type
            """
            return self.data.get('degree_type', default)
        def Institutions(self, default=[{}]):
            """HEP.ThesisInfoObject.Institutions
            Returns an array of objects containing the value corresponding to the key 'institutions'
            Type: array
            Elements: HEP.InstitutionObject
            Format: [HEP.InstitutionObject,...,HEP.InstitutionObject]
            Default: [HEP.InstitutionObject({})]
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-thesis-info-properties-date
            """
            tmp = self.data.get('institutions', default)
            return [HEP.InstitutionObject(i) for i in tmp]
    class TitleTranslationObject(SourceParent,TitleParent):
        """Class containing the object HEP.TitleTranslationObject defined by the
        HEP.HEPObject.TitleTranslations method of the HEP.HEPObject class
        Inherits the Parent Classes
        HEP.InitParent (indirectly)
        HEP.SourceParent
        HEP.TitleParent
        Contains the methods
        HEP.ThesisInfoObject.Language
        HEP.ThesisInfoObject.Source
        HEP.ThesisInfoObject.Subtitle
        HEP.ThesisInfoObject.Title
        Documentation:
        http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-titles
        """
        #   __init__ method inherited from InitParent
        def Language(self, default=None):
            """HEP.TitleTranslationObject.Language
            Returns a string containing the value corresponding to the key 'language'
            Type: string (with exactly 2 characters)
            Allowed values: see documentation
            Default: None
            Documentation:
            http://inspire-schemas.readthedocs.io/en/latest/schemas/records/hep.html#hep-json-properties-title-translations-items-properties-language
            """
            return self.data.get('language', default)
        #   Source method inherited from SourceParent
        #   Subtitle method inherited from TitleParent
        #   Title method inherited from TitleParent
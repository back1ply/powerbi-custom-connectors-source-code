[Version = "4.1.0"]
section BitSightSecurityRatings;


//
// Constants and Variables
// 

// Configuration
page_size = Number.ToText(250);
BaseUrl = "https://api.bitsighttech.com/";
rvhistory_period = "monthly";
rvlatest_period = "latest";
myInfrastructure_format = "csv";
myInfrastructure_type_IP = "ip";
myInfrastructure_type_domain = "domain";
helpURL = "https://overviewdocs.bitsighttech.com/BitSightForPowerBIAppTerms.pdf";
default_affects_rating_findings = "all";

// API Key Setup
apiKey = Binary.ToText(Text.ToBinary(Extension.CurrentCredential()[Key] & ":"), BinaryEncoding.Base64);

// URL Assemble
companyURL = BaseUrl & "ratings/v1/companies/";
findingsURL = BaseUrl & "ratings/v1/companies/company_guid/findings?expand=remediation_history,attributed_companies&limit=" & page_size;
rvhistoryURL = BaseUrl & "v1/portfolio/risk-vectors/grades?period=" & rvhistory_period & "&limit=" & page_size & "&company.guid=";
alertsURL = BaseUrl & "ratings/v2/alerts";
myinfrastructureURL_IP = BaseUrl & "ratings/v1/companies/company_guid/reports/infrastructure?format=" & myInfrastructure_format & "&type=" & myInfrastructure_type_IP;
myinfrastructureURL_domain = BaseUrl & "ratings/v1/companies/company_guid/reports/infrastructure?format=" & myInfrastructure_format & "&type=" & myInfrastructure_type_domain;
guidUrl = "https://api.bitsighttech.com/v1/users/current";
//addcontent
//group1
portfolioURL = BaseUrl & "ratings/v2/portfolio/";
portfolio2URL = BaseUrl & "ratings/v2/portfolio/";
portfolio3URL = BaseUrl & "ratings/v2/portfolio/";
rvlatestportURL=BaseUrl & "v1/portfolio/risk-vectors/grades?period=" & rvlatest_period & "&limit=" & page_size;
rvhistoryportURL=BaseUrl & "v1/portfolio/risk-vectors/grades?period=" & rvhistory_period & "&limit=" & page_size;
foldersURL=BaseUrl & "v1/folders";
tiersURL=BaseUrl & "v1/tiers";
ratingsURL=BaseUrl & "v1/portfolio/ratings?period=" & rvhistory_period;
//group2
breachesURL=BaseUrl & "v1/portfolio/breaches";
ratingchURL=BaseUrl & "v1/insights/rating_changes";
//group3
industryURL= BaseUrl & "ratings/v1/industries";
company_name = GetMyCompanyName();
//newImplementation
infrastructureURL= BaseUrl & "ratings/v1/companies/company_guid/infrastructure";
assetsURL= BaseUrl & "ratings/v1/companies/company_guid/assets?expand=tag_details";

// VRM Implementation
BaseUrl_VRM = "https://service.bitsighttech.com/customer-api/vrm/v1/";
// Vendor Portfolio Details
allVendorsURL = BaseUrl_VRM & "vendors/query";
monitoredVendorsDetailsURL = BaseUrl_VRM & "vendors/monitored/{vendor_guid}";
managedVendorsDetailsURL = BaseUrl_VRM & "vendors/managed/{vendor_guid}";
vendorsRatingURL = BaseUrl_VRM & "companies/{bst_entity_guid}/rating";
vendorsInfoURL = BaseUrl_VRM & "company/{vendor_guid}";
vendorsContactsURL = BaseUrl_VRM & "vendors/{vendor_guid}/contacts";
internalContactsURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal-contacts";
internalQuestionnairesURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal_questionnaires";
internalQuestionnairesInfoURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal_questionnaires/{questionnaire_guid}";
internalQuestionnairesInfoQURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal_questionnaires/categories/{category_guid}/questions";
internalQuestionnairesInfoAURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal_questionnaires/categories/{category_guid}/answers";
internalQuestionnairesProgressURL = BaseUrl_VRM & "vendors/{vendor_guid}/internal_questionnaires/{questionnaire_guid}/progress";

questionnairesFullURL = BaseUrl_VRM & "questionnaires/optional";
questionnairesCategoriesURL = BaseUrl_VRM & "questionnaires/{questionnaire_guid}";
externalQuestionnairesURL = BaseUrl_VRM & "vendors/{vendor_guid}/questionnaires";
externalQuestionnairesInfoURL = BaseUrl_VRM & "vendors/{vendor_guid}/questionnaires/{questionnaire_guid}";
externalQuestionnairesInfoQURL = BaseUrl_VRM & "vendors/{vendor_guid}/questionnaires/categories/{category_guid}/questions";
externalQuestionnairesInfoAURL = BaseUrl_VRM & "vendors/{vendor_guid}/questionnaires/categories/{category_guid}/answers";
externalQuestionnairesProgressURL = BaseUrl_VRM & "vendors/{vendor_guid}/questionnaires/{questionnaire_guid}/progress";
allVendorFindingsURL = BaseUrl_VRM & "vendors/findings/query";
findingDetailsURL = BaseUrl_VRM & "vendors/findings/{finding_guid}";
requirementsURL = BaseUrl_VRM & "vendors/requirements";
requirementsDetailsURL = BaseUrl_VRM & "vendors/{vendor_guid}/requirements/{requirement_guid}";
lifeCycleURL = BaseUrl_VRM & "life-cycle-stages";

// HTTP Headers
FirstRequestHeaders = [
    Authorization = "Basic " & apiKey,
    Accept = "application/json",
    #"Content-Type" = "application/json",
    #"X-BITSIGHT-CONNECTOR-NAME-VERSION" = "Security Ratings Connector v4.0.0",
    #"X-BITSIGHT-CALLING-PLATFORM-VERSION" = "PowerBI",
    #"X-BITSIGHT-CUSTOMER" = "GET Customer Name"
];

DefaultRequestHeaders = [
    Authorization = "Basic " & apiKey,
    Accept = "application/json",
    #"Content-Type" = "application/json",
    #"X-BITSIGHT-CONNECTOR-NAME-VERSION" = "Security Ratings Connector v4.0.0",
    #"X-BITSIGHT-CALLING-PLATFORM-VERSION" = "PowerBI",
    #"X-BITSIGHT-CUSTOMER" = company_name
];

DefaultVRMRequestHeaders = [
    Authorization = "Basic " & apiKey,
    Accept = "application/json",
    #"Content-Type" = "application/json",
    #"X-BITSIGHT-CONNECTOR-NAME-VERSION" = "VRM Connector v4.0.0",
    #"X-BITSIGHT-CALLING-PLATFORM-VERSION" = "PowerBI",
    #"X-BITSIGHT-CUSTOMER" = company_name
];

// Entities List for the Navigation Table
RootEntities = #table({"entity_order","entity_name","endpoint","flag","url"}, {
    {0,"Details","company","d",companyURL},
    {1,"Ratings History","company","h",companyURL},
    {2,"Current Risk Vector Grades","company","g",companyURL},
    {3,"Findings","findings","a",findingsURL},
    {4,"Risk Vector History","rvhistory","a",rvhistoryURL},
    {5,"Alerts","alerts","a",alertsURL},
    {6,"IPs","myinfrastructure","i",myinfrastructureURL_IP},
    {7,"Domains","myinfrastructure","d",myinfrastructureURL_domain},
    {8,"Portfolio Companies","portfolio","a",portfolioURL},
    {9,"Portfolio Risk Vector History","rvhistoryport","a",rvhistoryportURL},
    {10,"Portfolio Risk Vector Latest","rvlatestport","a",rvlatestportURL},
    {11,"Folders","folders","a",foldersURL},
    {12,"Tiers", "tiers","a",tiersURL},
    {13,"Portfolio Ratings History", "ratings","a",ratingsURL},
    {14,"Breaches","breaches","a",breachesURL},
    {15,"Rating Changes", "ratingch","a",ratingchURL},
    {16,"Industries", "industry","a",industryURL},
    {17,"Infrastructure", "infrastructure","a",infrastructureURL},
    {18,"Assets", "assets","a",assetsURL},
    // VRM Implementation
    {19,"Vendors", "vendors","a",allVendorsURL},
    {19,"Vendors Details", "vendors","d","dynamic"},
    {24,"Vendor Rating", "vendors","r",vendorsRatingURL},
    {25,"Vendor Information", "vendors","i",vendorsInfoURL},
    {26,"Vendor Contacts", "contacts","v",vendorsContactsURL},
    {27,"Internal Contacts", "contacts","i",internalContactsURL},
    {28,"Vendor Findings", "vfindings","a",allVendorFindingsURL},
    {29,"Vendor Findings Details", "vfindings","d",findingDetailsURL},
    {30,"Vendor Internal Questionnaires", "iquestionnaires","a",internalQuestionnairesURL},
    {31,"Vendor Internal Questionnaire Categories", "iquestionnaires","c",questionnairesCategoriesURL},
    {32,"Vendor Internal Questionnaire Questions", "iquestionnaires","q",internalQuestionnairesInfoQURL},
    {33,"Vendor Internal Questionnaire Answers", "iquestionnaires","w",internalQuestionnairesInfoAURL},
    {34,"Vendor Internal Questionnaire Progress", "iquestionnaires","p",internalQuestionnairesProgressURL},
    {35,"Vendor External Questionnaires", "equestionnaires","a",externalQuestionnairesURL},
    {36,"Vendor External Questionnaire Categories", "equestionnaires","c",questionnairesCategoriesURL},
    {37,"Vendor External Questionnaire Questions", "equestionnaires","q",externalQuestionnairesInfoQURL},
    {38,"Vendor External Questionnaire Answers", "equestionnaires","w",externalQuestionnairesInfoAURL},
    {39,"Vendor External Questionnaire Progress", "equestionnaires","p",externalQuestionnairesProgressURL},
    {40,"Vendors Requirements Progress", "requirements","a",requirementsURL},
    {41,"Vendors Requirements Details", "requirements","d",requirementsDetailsURL},
    {42,"Lifecycle Stages", "lifecycle","a",lifeCycleURL}
  });



SchemaTable = #table({"Entity", "SchemaTable"}, {
    {"Details", #table({"Name", "Type"}, {
		{"guid", type text},
		{"custom_id", type text},
		{"name", type text},
		{"description", type text},
		{"ipv4_count", type number},
		{"people_count", type number},
		{"shortname", type text},
		{"industry", type text},
		{"industry_slug", type text},
		{"sub_industry", type text},
		{"sub_industry_slug", type text},
		{"homepage", type text},
		{"primary_domain", type text},
		{"type", type text},
		{"display_url", type text},
		{"search_count", type number},
		{"subscription_type", type text},
		{"sparkline", type text},
		{"subscription_type_key", type text},
		{"subscription_end_date", type date},
		{"bulk_email_sender_status", type text},
		{"service_provider", type logical},
		{"customer_monitoring_count", type number},
		{"available_upgrade_types", type list},
		{"has_company_tree", type logical},
		{"has_preferred_contact", type logical},
		{"is_bundle", type logical},
		{"rating_industry_median", type text},
		{"primary_company", type record},
		{"permissions", type record},
		{"is_primary", type logical},
		{"in_spm_portfolio", type logical},
		{"is_mycomp_mysubs_bundle", type logical},
		{"company_features", type list}
	})},

	{"Ratings History", #table({"Name", "Type"}, {
        {"guid", type text},
		{"rating_date", type date},
		{"rating", type number},
		{"range", type text},
		{"rating_color", type text}
	})},

    {"Current Risk Vector Grades", #table({"Name", "Type"}, {
		{"category", type text},
		{"rating", type number},
		{"beta", type logical},
		{"percentile", type number},
		{"name", type text},
		{"display_url", type text},
		{"grade", type text},
		{"category_order", type number},
		{"order", type number},
		{"grade_color", type text}
    })},

    {"Findings", #table({"Name", "Type"}, {
		{"affects_rating", type logical},
		{"assets", type list},
		{"details", type record},
		{"evidence_key", type text},
		{"first_seen", type date},
		{"last_seen", type date},
		{"risk_category", type text},
		{"risk_vector", type text},
		{"risk_vector_label", type text},
		{"rolledup_observation_id", type text},
		{"severity", type number},
		{"severity_category", type text},
		{"tags", type list},
		{"remediation_history", type any},
		{"comments", type text},
		{"attributed_companies", type list},
        {"message", type text}
    })},    

    {"Risk Vector History", #table({"Name", "Type"}, {
        {"date", type date},
        {"risk_vectors", type list}
    })},

    {"Alerts", #table({"Name", "Type"}, {
		{"guid", type text},
		{"alert_type", type text},
		{"alert_date", type date},
		{"start_date", type date},
		{"company_name", type text},
		{"company_guid", type text},
		{"company_url", type text},
		{"folder_guid", type text},
		{"folder_name", type text},
		{"severity", type text},
		{"trigger", type text}
    })},

    {"IPs", #table({"Name", "Type"}, {
		{"CIDR Block", type text},
		{"Country", type text},
		{"Start Date", type date},
		{"End Date", type text},
		{"Attributed To", type text},
		{"IP Count", Int64.Type},
		{"Tags", type text},
		{"Source", type text},
		{"Link", type text},
		{"AS Number", type text},
		{"Reasons", type text},
		{"Notes", type text},
		{"SSIDS", type text}
    })},

    {"Domains", #table({"Name", "Type"}, {
		{"Domain Name", type text},
		{"Start Date", type date},
		{"End Date", type text},
		{"Attributed To", type text},
		{"Tags", type text}
    })},

    {"Portfolio Companies", #table({"Name", "Type"}, {
        {"guid", type text},
        {"custom_id", type any}, 
        {"name", type text},  
        {"rating", type number},
        {"rating_date", type date}, 
        {"industry", type record},
        {"sub_industry", type record}, 
        {"type", type list},
        {"subscription_type", type record},
        {"primary_domain", type text},
        {"tier", type text}, 
        {"tier_name", type text}, 
        {"life_cycle", type any}, 
        {"relationship", type record}
    })}, 

    {"Portfolio Risk Vector Latest", #table({"Name", "Type"}, {
       {"company", type record},
       {"grades", type list}
       
    })},

    {"Portfolio Risk Vector History", #table({"Name", "Type"}, {
       {"company", type record},
       {"grades", type list}
    })},

    {"Folders", #table({"Name", "Type"}, {
       {"guid", type text},
       {"name", type text}, 
       {"description", type any},
       {"companies", type list}

    })},

     {"Tiers", #table({"Name", "Type"}, {
       {"rank", type number},
       {"guid", type text},
       {"name", type text},
       {"description", type text},
       {"companies", type list}

    })},

    {"Portfolio Ratings History", #table({"Name", "Type"}, {
       {"guid", type text},
       {"ratings", type list},
       {"name", type text},
       {"current_rating", type number}

    })},

    {"Breaches", #table({"Name", "Type"}, {
       {"date", type date},
       {"date_created", type date},
       {"severity", type number},
       {"text", type text}, 
       {"preview_url", type text},
       {"event_type", type text}, 
       {"event_type_description", type text},
       {"category_slug", type text}, 
       {"category_name", type text}, 
       {"breached_company", type record}, 
       {"affected_portfolio_company", type record}
    })},

    {"Rating Changes", #table({"Name", "Type"}, {
       {"date", type date}, 
       {"start_score", type number}, 
       {"end_score",  type number}, 
       {"reasons", type list},
       {"type", type text}, 
       {"company", type text}

    })},

    {"Industries", #table({"Name", "Type"}, {
       {"rating_date", type date},
       {"industries", type record}

    })},

    {"Infrastructure", #table({"Name", "Type"}, {
       {"value", type text},
       {"source", type record},
       {"tags", type list},
       {"country", type record},
       {"start_date", type date},
       {"end_date", type date},
       {"is_active", type logical},
       {"attributed_to", type record},
       {"asn", type record},
       {"ip_count", type number},
       {"is_suppressed", type logical}
    })},

    {"Assets", #table({"Name", "Type"}, {
       {"asset", type text}, 
       {"asset_type", type text}, 
       {"tag_details",  type text}, 
       {"combined_overrides", type text},
       {"app_grade", type text}, 
       {"country", type text},
       {"services", type text},
       {"products", type text},
       {"hosted_by", type text},
       {"findings.count_by_severity", type text},
       {"findings.total_count", type text},
       {"origin_subsidiary", type text}

    })},

    {"Vendors", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"name", type text},
        {"type", type text}
    })},

    {"Vendors Details", #table({"Name", "Type"}, {
        {"vendor_guid", type text}, //added to match Vendor
        {"impact_score", Int64.Type},
        {"risk_score", Int64.Type},
        {"trust_score", Int64.Type},
        {"review_year", Int32.Type},
        {"life_cycle_stage_guid", type text},
        {"bst_entity_guid", type text}
    })},

    {"Vendor Rating", #table({"Name", "Type"}, {
        {"bst_entity_guid", type text}, //added to match Vendor
        {"rating_date", type date},
        {"rating", Int64.Type}
    })},

    {"Vendor Contacts", #table({"Name", "Type"}, {
        {"vendor_guid", type text}, //added to match Vendor
        {"email", type text},
        {"phone_number", type text}
    })},

    {"Vendor Findings", #table({"Name", "Type"}, {
        {"guid", type text},
        {"review_status", type text},
        {"vendor_guid", type text},
        {"created_at", type text},
        {"criticality", type text},
        {"reported_on", type text},
        {"will_remediate_by", type text}
    })},

    {"Vendor Findings Details", #table({"Name", "Type"}, {
        {"guid", type text},
        {"review_status", type text},
        {"vendor_guid", type text},
        {"created_at", type text},
        {"criticality", type text},
        {"reported_on", type text},
        {"will_remediate_by", type text},
        {"artifact_question", type record} // questions
    })},

    {"Internal Contacts", #table({"Name", "Type"}, {
        {"vendor_guid", type text}, //added to match Vendor
        {"email", type text},
        {"phone_number", type text}
    })},

    {"Vendor Information", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"industry", type text}
    })},

    {"Vendor Internal Questionnaires", #table({"Name", "Type"}, {
        {"progress", Int64.Type},
        {"score", Int64.Type},
        {"questionnaire_guid", type text},
        {"name", type text},
        {"vendor_guid", type text} //added to match Vendor
    })},

    {"Vendor Internal Questionnaire Categories", #table({"Name", "Type"}, {
        {"questionnaire_guid", type text},
        {"category_guid", type text},
        {"name", type text}
    })},

    {"Vendor External Questionnaire Categories", #table({"Name", "Type"}, {
        {"questionnaire_guid", type text},
        {"category_guid", type text},
        {"name", type text}
    })},

    {"Vendor Internal Questionnaire Questions", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"category_guid", type text},
        {"question_guid", type text},
        {"question", type text}
    })},

    {"Vendor External Questionnaire Questions", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"category_guid", type text},
        {"question_guid", type text},
        {"question", type text}
    })},

    {"Vendor Internal Questionnaire Answers", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"category_guid", type text},
        {"question_guid", type text},
        {"unanswered", type logical},
        {"value", type text}
    })},

    {"Vendor External Questionnaire Answers", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"category_guid", type text},
        {"unanswered", type logical},
        {"question_guid", type text},
        {"value", type text}
    })},

    {"Vendor Internal Questionnaire Progress", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"questionnaire_guid", type text},
        {"progress", Int64.Type},
        {"score", Int64.Type}
    })},

    {"Vendor External Questionnaire Progress", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"questionnaire_guid", type text},
        {"progress", Int64.Type},
        {"score", Int64.Type}
    })},

    {"Vendor External Questionnaires", #table({"Name", "Type"}, {
        {"progress", Int64.Type},
        {"score", Int64.Type},
        {"questionnaire_guid", type text},
        {"name", type text},
        {"vendor_guid", type text} //added to match Vendor
    })},

    {"Vendors Requirements Progress", #table({"Name", "Type"}, {
        {"vendor_guid", type text},
        {"total_requirement_completion", Int64.Type},
        {"number_of_requirements", Int64.Type},
        {"requirement_guid", type text},
        {"requirement_name", type text},
        {"is_completed", type logical}
    })},

    {"Vendors Requirements Details", #table({"Name", "Type"}, {
        {"requirement_guid", type text},
        {"vendor_guid", type text},
        {"requirement_name", type text},
        {"segment_type", type text},
        {"artifact_enabled", type logical},
        {"artifact_name", type text},
        {"artifact_score", Int64.Type},
        {"artifact_progress", Int64.Type},
        {"artifact_reviewed", type logical},
        {"artifact_expires_on", type date},
        {"artifact_achieved_on", type date},
        {"artifact_status", type text}
    })},

    {"Lifecycle Stages", #table({"Name", "Type"}, {
        {"guid", type text},
        {"name", type text}
    })}

});


GetSchemaForEntity = (entity as text) as table => try SchemaTable{[Entity=entity]}[SchemaTable] otherwise error "Couldn't find entity: '" & entity &"'";

//
// Implementation
// 
[DataSource.Kind="BitSightSecurityRatings", Publish="BitSightSecurityRatings.Publish"]
shared BitSightSecurityRatings.Contents = (optional company_guid as text, optional affects_rating_findings as logical) => 
    BitSightSecurityRatings.Navigation(company_guid, affects_rating_findings) as table;

// Data Source Kind Description
BitSightSecurityRatings = [
    // TestConnection is required to enable the connector through the Gateway
    TestConnection = (dataSourcePath) =>  { "BitSightSecurityRatings.Contents"},
    Authentication = [
        Key = [
            KeyLabel = Extension.LoadString("TokenFormLabel"),
            Label = Extension.LoadString("AuthenticationLabel")
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI Publishing Description
BitSightSecurityRatings.Publish = [
    Beta = false,
    Category = "Other",
    LearnMoreUrl = helpURL,
    ButtonText = { Extension.LoadString("Title"), Extension.LoadString("FormulaHelp") },
    SourceImage = BitSightSecurityRatings.Icons,
    SourceTypeImage = BitSightSecurityRatings.Icons
];

// Build top level navitation bar
BitSightSecurityRatings.Navigation = (optional company_guid as text, optional affects_rating_findings as logical) as table =>
    let
       
        company_guid = if (company_guid <> null) then company_guid else GetMyCompanyGUID(),
        far = if(affects_rating_findings <> null) then if affects_rating_findings then "true" else "false" else default_affects_rating_findings,
        
        
        // Define items for "Bitsight Security Ratings API
        BitsightSecurityRatingsAPIItems = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {"My Company","My Company",CompanyNavTable(company_guid, far),"Folder","My Company",false},
            {"Others","Others",OthersNavTable(company_guid, far),"Folder","Others",false},
            {"My Infrastructure","My Infrastructure",MyInfrastructureNavTable(company_guid, far),"Folder","My Infrastructure",false},
            {"Portfolio","Portfolio",PortfolioNavTable(company_guid, far),"Folder","Portfolio",false},
            {"Bitsight Vendor Risk Management API", "Bitsight Vendor Risk Management API", BitsightSecurityRatingsVendorAPITable, "Folder", "Bitsight Vendor Risk Management API", false}
        }),
        /*
        BitsightSecurityRatingsAPIItems = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            {"My Company","My Company",CompanyNavTable(company_guid, far),"Folder","My Company",false},
            {"Others","Others",OthersNavTable(company_guid, far),"Folder","Others",false},
            {"My Infrastructure","My Infrastructure",MyInfrastructureNavTable(company_guid, far),"Folder","My Infrastructure",false},
            {"Portfolio","Portfolio",PortfolioNavTable(company_guid, far),"Folder","Portfolio",false}
        }),*/
        BitsightSecurityRatingsAPITable = Table.ToNavigationTable(BitsightSecurityRatingsAPIItems,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf"),
        
        // Define items for "Bitsight Security Ratings Vendor API
        BitsightSecurityRatingsVendorAPIItems = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
            {"Vendors", "Vendor Portfolio", VendorsNavTable(company_guid, far), "Folder", "Vendors", false},
            {"Contacts", "Contacts", VendorsContactsNavTable(company_guid, far), "Folder", "Contacts", false},
            {"Findings", "Findings", VendorsFindingsNavTable(company_guid, far), "Folder", "Findings", false},
            {"Internal Questionnaires", "Internal Questionnaires", VendorsIQuestionnairesNavTable(company_guid, far), "Folder", "Internal Questionnaires", false},
            {"Questionnaires", "Questionnaires", VendorsEQuestionnairesNavTable(company_guid, far), "Folder", "Questionnaires", false},
            {"Requirements", "Requirements", VendorsRequirementsNavTable(company_guid, far), "Folder", "Requirements", false},
            {"Lifecycle", "Lifecycle", VendorsLifecycleNavTable(company_guid, far), "Folder", "Lifecycle", false}
        }),
        BitsightSecurityRatingsVendorAPITable = Table.ToNavigationTable(BitsightSecurityRatingsVendorAPIItems, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),

        // Top-level navigation items
        objects = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
                {"Bitsight Continuous Monitoring API", "Bitsight Continuous Monitoring API", BitsightSecurityRatingsAPITable, "Folder", "Bitsight Continuous Monitoring API", false}
                //{"Bitsight Vendor Risk Management API", "Bitsight Vendor Risk Management API", BitsightSecurityRatingsVendorAPITable, "Folder", "Bitsight Vendor Risk Management API", false}
            }
        ),
        NavTable = BitsightSecurityRatingsAPITable

    in
        NavTable;

// Company Navigation Bar
CompanyNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "company" or [endpoint] = "rvhistory"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

// Others Navigation Bar
OthersNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "alerts"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

       

// My Infrastructure Navigation Bar
MyInfrastructureNavTable = (company_guid as text,  affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "myinfrastructure" or [endpoint] = "findings" or [endpoint] = "infrastructure" or [endpoint] = "assets"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        guids = GetMyCompanyAllGUIDs(),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

// Portfolio Navigation Bar
PortfolioNavTable = (company_guid as text,  affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "portfolio" or [endpoint] = "rvhistoryport" or [endpoint]= "rvlatestport" or [endpoint]= "ratingch" or [endpoint] = "ratings" or [endpoint]= "folders" or [endpoint] = "tiers" or [endpoint]= "breaches" or [endpoint]= "industry"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

// Vendors Navigation Bar
VendorsNavTable = (company_guid as text,  affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "vendors"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsContactsNavTable = (company_guid as text,  affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "contacts"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsFindingsNavTable = (company_guid as text,  affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "vfindings"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsIQuestionnairesNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "iquestionnaires"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsEQuestionnairesNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "equestionnaires"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsQuestionnairesNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "questionnaires"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsRequirementsNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "requirements"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

VendorsLifecycleNavTable = (company_guid as text, affects_rating_findings as text) as table =>
    let
        entitiesAsTable = Table.SelectRows(Table.SelectColumns(RootEntities,{"entity_name","endpoint","flag","url"}), each [endpoint] = "lifecycle"),
        rename = Table.RenameColumns(entitiesAsTable, {{"entity_name", "Name"}}),
        withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        // Indicate that the node should not be expandable
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        // Generate the nav table
        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;


// Obtain an endpoint entity and apply schema
GetEntity = (url as text, endpoint as text, flag as text, company_guid as text, entity_name as text, optional affects_rating_findings as text) as table => 
    let
        schemaTable = GetSchemaForEntity(entity_name),
        result =    if endpoint = "company" and flag = "d" then
                        BitSightSecurityRatingsCompanyDetails.Feed(url, endpoint, flag, company_guid, schemaTable)
                    else if endpoint = "company" and flag = "h" then
                        BitSightSecurityRatingsCompanyRatings.Feed(url, endpoint, flag, company_guid, schemaTable)
                    else if endpoint = "company" and flag = "g" then
                        BitSightSecurityRatingsCompanyGrades.Feed(url, endpoint, flag, company_guid, schemaTable)
                    else if endpoint = "alerts" or endpoint = "rvhistory" or endpoint = "findings" or endpoint = "portfolio" or endpoint = "rvhistoryport" or endpoint= "rvlatestport" or endpoint= "ratingch" or endpoint = "findingsport" or endpoint = "summaries" or endpoint = "infrastructure" or endpoint = "assets" then 
                        PaginatedResult(url, company_guid, endpoint, affects_rating_findings, schemaTable)
                    else if endpoint = "myinfrastructure" then 
                        BitSightSecurityRatingsMyInfrastructure.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "folders" then 
                        BitSightSecurityRatingsFolders.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "tiers" then 
                        BitSightSecurityRatingsTiers.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "ratings" then 
                        BitSightSecurityRatingsRating.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "breaches" then 
                        BitSightSecurityRatingsBreaches.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "industry" then 
                        BitSightSecurityRatingsIndustry.Feed(url, flag, company_guid, schemaTable)
                    // VRM API
                    else if endpoint = "vendors" and flag = "a" then 
                        BitSightSecurityAllVendors.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "vendors" and flag = "d" then 
                        BitSightSecurityVendorsDetails.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "vendors" and flag = "r" then 
                        BitSightSecurityVendorRating.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "vendors" and flag = "i" then 
                        BitSightSecurityVendorInfo.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "contacts" and flag = "v" then 
                        BitSightSecurityVendorContacts.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "contacts" and flag = "i" then 
                        BitSightSecurityInternalContacts.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "vfindings" and flag = "a" then 
                        BitSightSecurityFindings.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "vfindings" and flag = "d" then 
                        BitSightSecurityFindingsDetails.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "iquestionnaires" and flag = "a" then 
                        BitSightSecurityInternalQuestionnaires.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "iquestionnaires" and flag = "c" then 
                        BitSightSecurityInternalQuestionnairesCategories.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "iquestionnaires" and flag = "q" then 
                        BitSightSecurityInternalQuestionnairesQuestions.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "iquestionnaires" and flag = "w" then 
                        BitSightSecurityInternalQuestionnairesAnswers.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "iquestionnaires" and flag = "p" then 
                        BitSightSecurityInternalQuestionnairesProgress.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "equestionnaires" and flag = "a" then 
                        BitSightSecurityExternalQuestionnaires.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "equestionnaires" and flag = "c" then 
                        BitSightSecurityExternalQuestionnairesCategories.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "equestionnaires" and flag = "q" then 
                        BitSightSecurityExternalQuestionnairesQuestions.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "equestionnaires" and flag = "w" then 
                        BitSightSecurityExternalQuestionnairesAnswers.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "equestionnaires" and flag = "p" then 
                        BitSightSecurityExternalQuestionnairesProgress.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "requirements" and flag = "a" then 
                        BitSightSecurityRequirements.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "requirements" and flag = "d" then 
                        BitSightSecurityRequirementsDetails.Feed(url, flag, company_guid, schemaTable)
                    else if endpoint = "lifecycle" and flag = "a" then 
                        BitSightSecurityLifecycle.Feed(url, flag, company_guid, schemaTable)
                    else 
                        error Extension.LoadString("EndpointWithNoDataFunctionError")
    in
        result;

// Company - Obtain Data for Company Details
BitSightSecurityRatingsCompanyDetails.Feed = (url as text, endpoint as text, flag as text, company_guid as text, optional schema as table) =>
    let
        source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        table = Record.ToTable(json),
        company_details = Table.Pivot(table, List.Distinct(table[Name]), "Name", "Value"),
        withSchema = if (schema <> null) then SchemaTransformTable(company_details, schema) else company_details,
        //Start: Code block not yet with dynamic schema treatment
        #"Expanded available_upgrade_types" = Table.ExpandListColumn(withSchema, "available_upgrade_types"),
        #"Expanded primary_company" = Table.ExpandRecordColumn(#"Expanded available_upgrade_types", "primary_company", {"guid", "name"}, {"primary_company.guid", "primary_company.name"}),
        #"Expanded permissions" = Table.ExpandRecordColumn(#"Expanded primary_company", "permissions", {"can_download_company_report", "can_view_forensics", "can_view_service_providers", "can_request_self_published_entity", "can_view_infrastructure", "can_annotate", "can_view_company_reports", "can_manage_primary_company", "has_control"}, {"permissions.can_download_company_report", "permissions.can_view_forensics", "permissions.can_view_service_providers", "permissions.can_request_self_published_entity", "permissions.can_view_infrastructure", "permissions.can_annotate", "permissions.can_view_company_reports", "permissions.can_manage_primary_company", "permissions.has_control"}),
        #"Expanded company_features" = Table.ExpandListColumn(#"Expanded permissions", "company_features"),
        #"Changed Type" = Table.TransformColumnTypes(#"Expanded company_features",{{"permissions.has_control", type logical}, {"permissions.can_manage_primary_company", type logical}, {"permissions.can_view_company_reports", type logical}, {"permissions.can_annotate", type logical}, {"permissions.can_view_infrastructure", type logical}, {"permissions.can_request_self_published_entity", type logical}, {"permissions.can_view_service_providers", type logical}, {"permissions.can_view_forensics", type logical}, {"permissions.can_download_company_report", type logical}}),
        //End: Code block not yet with dynamic schema treatment
        output = #"Changed Type"
    in
        output;

// Company - Obtain Data for Current Risk Vector Grades
BitSightSecurityRatingsCompanyGrades.Feed = (url as text, endpoint as text, flag as text, company_guid as text, optional schema as table) =>
    let
        source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        company_actual_grades = json[rating_details],
        company_actual_grades_table = Table.RenameColumns(Record.ToTable(company_actual_grades),{{"Name", "risk_vector"}}),
        company_actual_grades_fields = Record.FieldNames(Table.FirstValue(Table.FromValue(company_actual_grades_table[Value]), [Empty = null])),
        company_actual_grades_expanded = Table.ExpandRecordColumn(company_actual_grades_table, "Value", company_actual_grades_fields),
        withSchema = if (schema <> null) then SchemaTransformTable(company_actual_grades_expanded, schema) else company_actual_grades_expanded,
        //Start: Code block not yet with dynamic schema treatment
        #"Replaced Errors" = Table.ReplaceErrorValues(withSchema, {{"rating", null}}),
        #"Replaced Errors1" = Table.ReplaceErrorValues(#"Replaced Errors", {{"percentile", null}}),
        //End: Code block not yet with dynamic schema treatment
        output = #"Replaced Errors1"
    in
        output;

// Company - Obtain Data for Company Ratings
BitSightSecurityRatingsCompanyRatings.Feed = (url as text, endpoint as text, flag as text, company_guid as text, optional schema as table) =>
    let
        source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        company_hist_ratings = json[ratings],
        company_hist_ratings_table = Table.FromList(company_hist_ratings, Splitter.SplitByNothing()),
        company_hist_ratings_fields = Record.FieldNames(Table.FirstValue(company_hist_ratings_table, [Empty = null])),
        company_hist_ratings_expanded = Table.ExpandRecordColumn(company_hist_ratings_table, "Column1", company_hist_ratings_fields),
        added_guid = Table.AddColumn(company_hist_ratings_expanded, "guid", each company_guid),
        withSchema = if (schema <> null) then SchemaTransformTable(added_guid, schema) else added_guid,
        output = withSchema
    in
        output;

        //Folders DATA
BitSightSecurityRatingsFolders.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        folders_table = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(folders_table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(folders_table, "Column1", table_fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        //Start: Code block not yet with dynamic schema treatment
       #"companies Expandida" = Table.ExpandListColumn(withSchema, "companies"),
       #"Renamed Columns1" = Table.RenameColumns(#"companies Expandida",{{"companies", "Company Guid"}}),
       //End: Code block not yet with dynamic schema treatment
        output = #"Renamed Columns1"
    in
        output;

//Tiers DATA
BitSightSecurityRatingsTiers.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        tiers_table = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(tiers_table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(tiers_table, "Column1", table_fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        //Start: Code block not yet with dynamic schema treatment
        #"companies Expandida" = Table.ExpandListColumn(withSchema, "companies"),
        #"Renamed Columns1" = Table.RenameColumns(#"companies Expandida",{{"companies", "Company Guid"}}),
         //End: Code block not yet with dynamic schema treatment
        output =  #"Renamed Columns1"
    in
        output;

//Rating DATA
BitSightSecurityRatingsRating.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        tiers_table = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(tiers_table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(tiers_table, "Column1", table_fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        //Start: Code block not yet with dynamic schema treatment
        #"ratings Expandida" = Table.ExpandListColumn(withSchema, "ratings"),
        #"ratings Expandida1" = Table.ExpandRecordColumn(#"ratings Expandida", "ratings", {"date", "rating"}, {"ratings.date", "ratings.rating"}),
        #"Renamed Columns1" = Table.RenameColumns(#"ratings Expandida1",{{"ratings.date", "Date"}, {"ratings.rating", "Rating"}, {"current_rating", "Current Rating"}}),  
        //End: Code block not yet with dynamic schema treatment
        output =  #"Renamed Columns1"
    in
        output;

        //Breaches DATA
BitSightSecurityRatingsBreaches.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        tiers_table = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(tiers_table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(tiers_table, "Column1", table_fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        //Start: Code block not yet with dynamic schema treatment
        #"Expanded breached_company" = Table.ExpandRecordColumn(withSchema, "breached_company", {"guid", "name"}, {"breached_company.guid", "breached_company.name"}),
        #"Expanded affected_portfolio_company" = Table.ExpandRecordColumn(#"Expanded breached_company", "affected_portfolio_company", {"guid", "name"}, {"affected_portfolio_company.guid", "affected_portfolio_company.name"}),
        #"Renamed Columns1" = Table.RenameColumns(#"Expanded affected_portfolio_company",{{"affected_portfolio_company.guid", "Affected Company Guid"}, {"affected_portfolio_company.name", "Affected Company Name"}}),
      
        //End: Code block not yet with dynamic schema treatment
        output =  #"Renamed Columns1"
    in
        output;

        //Industry DATA
BitSightSecurityRatingsIndustry.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(source),
        table = Record.ToTable(json),
        company_details = Table.Pivot(table, List.Distinct(table[Name]), "Name", "Value"),
        withSchema = if (schema <> null) then SchemaTransformTable(company_details, schema) else company_details,
        //Start: Code block not yet with dynamic schema treatment
        #"Expanded industries" = Table.ExpandListColumn(withSchema, "industries"),
        #"Expanded industries1" = Table.ExpandRecordColumn(#"Expanded industries", "industries", {"name", "slug", "rating", "href", "id"}, {"industries.name", "industries.slug", "industries.rating", "industries.href", "industries.id"}),
        #"Removed Columns" = Table.RemoveColumns(#"Expanded industries1",{"industries.href", "industries.id"}),
        #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"industries.name", "Industries Name"}, {"industries.slug", "Industries Slug"}, {"industries.rating", "Industries Rating"}, {"rating_date", "Rating Date"}}),

        //End: Code block not yet with dynamic schema treatment
        output = #"Renamed Columns"
    in
        output;

       
// Findings - Obtain Findings - Paginated
// BitSightSecurityRatingsFindings.Feed = (url as text, company_guid as text, optional schema as table) as table => GetAllPagesByNextLink(url, company_guid, null, schema);


BitSightSecurityLifecycle.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        resultsTable = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        #"Expanded Column1" = Table.ExpandRecordColumn(resultsTable, "Column1", {"order", "guid", "color_name", "name", "status", "is_default"}, {"Column1.order", "Column1.guid", "Column1.color_name", "Column1.name", "Column1.status", "Column1.is_default"}),
        renamed_cols = Table.RenameColumns(#"Expanded Column1",{{"Column1.guid", "guid"}, {"Column1.name", "name"}}),
        output = if schema <> null then SchemaTransformTable(renamed_cols, schema) else renamed_cols
    in
        output;

BitSightSecurityAllVendors.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultVRMRequestHeaders, Content = Json.FromValue([]) ]),
        json = Json.Document(source),
        resultsList = json[results],
        resultsTable = Table.FromList(resultsList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(resultsTable, [Empty = null])),
        expanded = Table.ExpandRecordColumn(resultsTable, "Column1", table_fields),
        #"Added Custom" = Table.AddColumn(expanded, "type", each if [is_managed] = true then "Managed" else "Monitored"),
        finalTable = Table.RemoveColumns(#"Added Custom",{"is_managed"}),
        withSchema = if schema <> null then SchemaTransformTable(finalTable, schema) else finalTable
    in
        withSchema;

GetVendorDetails = (url as text, vendor_guid as text) =>
    let
        details_url = Text.Replace(url, "{vendor_guid}", vendor_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        detailsRecord = Record.AddField(json, "vendor_guid", vendor_guid)
    in
        detailsRecord;

BitSightSecurityVendorsDetails.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        allVendors = BitSightSecurityAllVendors.Feed(allVendorsURL, endpoint, flag, null),
        vendorDetails = Table.SelectColumns(allVendors, {"vendor_guid", "type"}),

        // Transform each row to retrieve vendor details
        detailsList = List.Transform(
            Table.ToRecords(vendorDetails), 
            each 
                if [type] = "Managed" then
                    GetVendorDetails(managedVendorsDetailsURL, [vendor_guid])
                else
                    GetVendorDetails(monitoredVendorsDetailsURL, [vendor_guid])
        ),

        detailsTable = Table.FromRecords(detailsList),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;




BitSightSecurityRequirements.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
        let
        // Get the vendors table
        allVendors = BitSightSecurityAllVendors.Feed(allVendorsURL, endpoint, flag, null),
        // Check if allVendors is empty
        isVendorsEmpty = Table.IsEmpty(allVendors),

        // If allVendors is not empty, process the requirements
        requirementsTable = if not isVendorsEmpty then
            let
                // Extract vendor_guids as a list
                vendorGuidsList = Table.Column(allVendors, "vendor_guid"),
                // Function to split list into chunks of 50
                ChunkList = List.Split(vendorGuidsList, 50),
                // Function to fetch data for a given chunk
                FetchDataForChunk = (chunk as list) =>
                    let
                        vendorGuidsQuery = Text.Combine(List.Transform(chunk, each "vendor_guids=" & _), "&"),
                        details_url = url & "?" & vendorGuidsQuery,
                        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
                        json = Json.Document(source),
                        requirementsTable = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
                        isrequirementsTableEmpty = Table.IsEmpty(requirementsTable),
                        requirementsTableaux = if not isrequirementsTableEmpty then
                            let
                                #"Expanded Column1" = Table.ExpandRecordColumn(requirementsTable, "Column1", {"requirements_fulfilled", "progress_average", "total_documents_count", "total_completed_documents_count", "vendor_guid", "progress"}, {"Column1.requirements_fulfilled", "Column1.progress_average", "Column1.total_documents_count", "Column1.total_completed_documents_count", "Column1.vendor_guid", "Column1.progress"}),
                                #"Renamed Columns" = Table.RenameColumns(#"Expanded Column1", {{"Column1.requirements_fulfilled", "requirements_fulfilled"}, {"Column1.progress_average", "progress_average"}, {"Column1.total_documents_count", "total_documents_count"}, {"Column1.total_completed_documents_count", "total_completed_documents_count"}, {"Column1.vendor_guid", "vendor_guid"}, {"Column1.progress", "progress"}}),
                                expanded = Table.ExpandListColumn(#"Renamed Columns", "progress"),
                                #"Expanded progress" = Table.ExpandRecordColumn(expanded, "progress", {"total_requirement_completion", "number_of_requirements", "requirement_guid", "requirement_name", "is_completed"}, {"progress.total_requirement_completion", "progress.number_of_requirements", "progress.requirement_guid", "progress.requirement_name", "progress.is_completed"}),
                                #"Renamed Columns2" = Table.RenameColumns(#"Expanded progress", {{"progress.total_requirement_completion", "total_requirement_completion"}, {"progress.number_of_requirements", "number_of_requirements"}, {"progress.requirement_guid", "requirement_guid"}, {"progress.requirement_name", "requirement_name"}, {"progress.is_completed", "is_completed"}})
                            in
                                #"Renamed Columns2"
                        else
                            #table({}, {})
                    in
                        requirementsTableaux,

                // Fetch data for all chunks and combine them
                Results = List.Transform(ChunkList, each FetchDataForChunk(_)),
                CombinedTable = Table.Combine(Results)
            in
                CombinedTable
        else
            #table({}, {}),
        
        // Apply schema transformation if provided
        withSchema = if schema <> null then SchemaTransformTable(requirementsTable, schema) else requirementsTable
    in
        withSchema;


GetRequirementDetails = (url as text, vendor_guid as text, requirement_guid as text) =>
    let
        // Replace vendor_guid and requirement_guid in the URL
        details_url = Text.Replace(Text.Replace(url, "{vendor_guid}", vendor_guid), "{requirement_guid}", requirement_guid),
        // Fetch data from the constructed URL
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        // Parse JSON response
        json = Json.Document(source)
    in
        json;

BitSightSecurityRequirementsDetails.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
        let
        // Get the requirements table
        allReqs = BitSightSecurityRequirements.Feed(requirementsURL, endpoint, flag, null),
        // Check if allReqs is empty
        isReqsEmpty = Table.IsEmpty(allReqs),

        // If allReqs is not empty, process the requirements details
        requirementsDetailsTable = if not isReqsEmpty then
            let
                removed_dup = Table.Distinct(allReqs, {"requirement_guid", "vendor_guid"}),
                table_Guids = Table.SelectColumns(removed_dup, {"requirement_guid", "vendor_guid"}),

                detailsList = Table.AddColumn(
                    table_Guids, 
                    "Details", 
                    each GetRequirementDetails(url, [vendor_guid], [requirement_guid])
                ),
                
                #"Expanded Details" = Table.ExpandRecordColumn(detailsList, "Details", {"name", "packages"}, {"Details.name", "Details.packages"}),
                #"Expanded Details.packages" = Table.ExpandListColumn(#"Expanded Details", "Details.packages"),
                #"Expanded Details.packages1" = Table.ExpandRecordColumn(#"Expanded Details.packages", "Details.packages", {"questionnaires_segment", "certifications_segment", "audits_segment", "insurances_segment"}, {"Details.packages.questionnaires_segment", "Details.packages.certifications_segment", "Details.packages.audits_segment", "Details.packages.insurances_segment"}),
                #"Unpivoted Columns" = Table.UnpivotOtherColumns(#"Expanded Details.packages1", {"requirement_guid", "vendor_guid", "Details.name"}, "Attribute", "Value"),
                #"Expanded Value" = Table.ExpandRecordColumn(#"Unpivoted Columns", "Value", {"type", "artifacts"}, {"Value.type", "Value.artifacts"}),
                #"Expanded Value.artifacts" = Table.ExpandListColumn(#"Expanded Value", "Value.artifacts"),
                #"Expanded Value.artifacts1" = Table.ExpandRecordColumn(#"Expanded Value.artifacts", "Value.artifacts", {"is_enabled", "name", "score", "progress", "review", "expires_on", "achieved_on", "status"}, {"Value.artifacts.is_enabled", "Value.artifacts.name", "Value.artifacts.score", "Value.artifacts.progress", "Value.artifacts.review", "Value.artifacts.expires_on", "Value.artifacts.achieved_on", "Value.artifacts.status"}),
                #"Removed Columns" = Table.RemoveColumns(#"Expanded Value.artifacts1",{"Attribute"}),
                #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"Details.name", "requirement_name"}, {"Value.type", "segment_type"}, {"Value.artifacts.is_enabled", "artifact_enabled"}, {"Value.artifacts.name", "artifact_name"}, {"Value.artifacts.score", "artifact_score"}, {"Value.artifacts.progress", "artifact_progress"}, {"Value.artifacts.review", "artifact_review"}, {"Value.artifacts.expires_on", "artifact_expires_on"}, {"Value.artifacts.achieved_on", "artifact_achieved_on"}, {"Value.artifacts.status", "artifact_status"}}),
                #"Expanded artifact_review" = Table.ExpandRecordColumn(#"Renamed Columns", "artifact_review", {"reviewed"}, {"artifact_review.reviewed"}),
                #"Renamed Columns1" = Table.RenameColumns(#"Expanded artifact_review",{{"artifact_review.reviewed", "artifact_reviewed"}})
            in
                #"Renamed Columns1"
        else
            // Return an empty table if no vendors are available
            #table({}, {}),
        
        // Apply schema transformation if provided
        withSchema = if schema <> null then SchemaTransformTable(requirementsDetailsTable, schema) else requirementsDetailsTable
    in
        withSchema;






GetVendorRating = (url as text, bst_entity_guid as text) =>
    let
        details_url = Text.Replace(url, "{bst_entity_guid}", bst_entity_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        // Check if the response contains error-related fields
        detailsRecord = Record.AddField(json, "bst_entity_guid", bst_entity_guid)
    in
        detailsRecord;

BitSightSecurityVendorRating.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the managed and monitored vendors table
        allVendors = BitSightSecurityVendorsDetails.Feed(monitoredVendorsDetailsURL, endpoint, flag, null),
        // Check if managedVendors is empty
        isVendorsEmpty = Table.IsEmpty(allVendors),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"bst_entity_guid"}),
                nonNullGuids = Table.SelectRows(vendorGuids, each [bst_entity_guid] <> null), // Remove null values
                // Fetch details for each vendor_guid and create a new table
                detailsList = List.Transform(nonNullGuids[bst_entity_guid], each GetVendorRating(url, _)),
                detailsTable = Table.FromRecords(detailsList),
                #"Expanded ratings" = Table.ExpandListColumn(detailsTable, "ratings"),
                #"Expanded ratings1" = Table.ExpandRecordColumn(#"Expanded ratings", "ratings", {"rating_date", "rating"}, {"ratings.rating_date", "ratings.rating"}),
                finalTable = Table.RenameColumns(#"Expanded ratings1",{{"ratings.rating", "rating"}, {"ratings.rating_date", "rating_date"}})
            in 
                finalTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;


GetVendorInfo = (url as text, vendor_guid as text) =>
    let
        details_url = Text.Replace(url, "{vendor_guid}", vendor_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source)
    in
        json;

BitSightSecurityVendorInfo.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors table
        allVendors = BitSightSecurityAllVendors.Feed(allVendorsURL, endpoint, flag, null),
        // Check if allVendors is empty
        isVendorsEmpty = Table.IsEmpty(allVendors),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"vendor_guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsList = List.Transform(vendorGuids[vendor_guid], each GetVendorInfo(url, _)),
                detailsTable = Table.FromRecords(detailsList),
                finalTable = Table.RenameColumns(detailsTable,{{"guid", "vendor_guid"}})
            in 
                finalTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

GetVendorContact = (url as text, vendor_guid as text) =>
    let
        details_url = Text.Replace(url, "{vendor_guid}", vendor_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        // Transform each contact record to add vendor_guid to each contact
        detailsList = List.Transform(json, each Record.AddField(_, "vendor_guid", vendor_guid))
    in
        detailsList;

BitSightSecurityVendorContacts.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the managed and monitored vendors table
        allVendors = BitSightSecurityVendorsDetails.Feed(monitoredVendorsDetailsURL, endpoint, flag, null),
        isCombinedVendorsEmpty = Table.IsEmpty(allVendors),
        detailsTable = if not isCombinedVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"vendor_guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsListOfLists = List.Transform(vendorGuids[vendor_guid], each GetVendorContact(url, _)),
                // Flatten the list of lists into a single list of records
                flattenedDetailsList = List.Combine(detailsListOfLists),
                detailsTable = Table.FromRecords(flattenedDetailsList)
            in 
                detailsTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

BitSightSecurityInternalContacts.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the managed and monitored vendors table
        allVendors = BitSightSecurityVendorsDetails.Feed(monitoredVendorsDetailsURL, endpoint, flag, null),
        isCombinedVendorsEmpty = Table.IsEmpty(allVendors),
        detailsTable = if not isCombinedVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"vendor_guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsListOfLists = List.Transform(vendorGuids[vendor_guid], each GetVendorContact(url, _)),
                // Flatten the list of lists into a single list of records
                flattenedDetailsList = List.Combine(detailsListOfLists),
                detailsTable = Table.FromRecords(flattenedDetailsList)
            in 
                detailsTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

GetVendorQuestion = (url as text, vendor_guid as text) =>
    let
        details_url = Text.Replace(url, "{vendor_guid}", vendor_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        resultsList = json[results],
        results_with_guid = List.Transform(resultsList, each Record.AddField(_, "vendor_guid", vendor_guid)),
        resultsTable = Table.FromList(results_with_guid, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(resultsTable, [Empty = null])),
        expanded = Table.ExpandRecordColumn(resultsTable, "Column1", table_fields)
    in
        expanded;

BitSightSecurityInternalQuestionnaires.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors table
        allVendors = BitSightSecurityAllVendors.Feed(allVendorsURL, endpoint, flag, null),
        // Check if allVendors is empty
        isVendorsEmpty = Table.IsEmpty(allVendors),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"vendor_guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsList = List.Transform(vendorGuids[vendor_guid], each GetVendorQuestion(url, _)),
                detailsTable = Table.Combine(detailsList),
                //#"Removed Columns" = Table.RemoveColumns(detailsTable,{"questionnaire_guid", "logo_url"})
                finalTable = Table.RenameColumns(detailsTable,{{"guid", "questionnaire_guid"}})
                //#"Removed Duplicates" = Table.Distinct(detailsTable, {"guid"})
            in 
                finalTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;


GetQuestionInfo = (url as text, vendor_guid as text, questionnaire_guid as text) =>
    let
        // Replace vendor_guid and questionnaire_guid in the URL
        details_url = Text.Replace(Text.Replace(url, "{vendor_guid}", vendor_guid), "{questionnaire_guid}", questionnaire_guid),
        // Fetch data from the constructed URL
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        // Parse JSON response
        json = Json.Document(source),
        // Add questionnaire_guid to each line
        detailsRecord = Record.AddField(json, "questionnaire_guid", questionnaire_guid)
    in
        detailsRecord;




GetCategoryQuestion = (url as text, vendor_guid as text, category_guid as text) =>
    let
        // Replace vendor_guid and category_guid in the URL
        details_url = Text.Replace(Text.Replace(url, "{vendor_guid}", vendor_guid), "{category_guid}", category_guid),
        // Fetch data from the constructed URL
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        // Parse JSON response
        json = Json.Document(source),
        resultsTable = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error)
    in
        resultsTable;

GetQuestionProgress = (url as text, vendor_guid as text, questionnaire_guid as text) =>
    let
        // Replace vendor_guid and questionnaire_guid in the URL
        details_url = Text.Replace(Text.Replace(url, "{vendor_guid}", vendor_guid), "{questionnaire_guid}", questionnaire_guid),
        // Fetch data from the constructed URL
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        // Parse JSON response
        json = Json.Document(source),
        // Add questionnaire_guid to each line
        detailsRecord = Record.AddField(json, "questionnaire_guid", questionnaire_guid),
        detailsRecord2 = Record.AddField(detailsRecord, "vendor_guid", vendor_guid)
    in
        detailsRecord2;

BitSightSecurityInternalQuestionnairesProgress.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the allInternalQ table
        allInternalQ = BitSightSecurityInternalQuestionnaires.Feed(internalQuestionnairesURL, endpoint, flag, null),
        // Check if allInternalQ is empty
        isEmpty = Table.IsEmpty(allInternalQ),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isEmpty then
            let
                table_Guids = Table.SelectColumns(allInternalQ, {"questionnaire_guid", "vendor_guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(table_Guids), 
                    each GetQuestionProgress(url, _[vendor_guid], _[questionnaire_guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList)
            in 
                combinedDetailsTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

BitSightSecurityFindings.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultVRMRequestHeaders, Content = Json.FromValue([limit = 10000]) ]),
        json = Json.Document(source),
        resultsList = json[results],
        resultsTable = Table.FromList(resultsList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(resultsTable, [Empty = null])),
        expanded = Table.ExpandRecordColumn(resultsTable, "Column1", table_fields),
        withSchema = if schema <> null then SchemaTransformTable(expanded, schema) else expanded,
        output = withSchema
    in
        output;

GetFindingsDetails = (url as text, finding_guid as text) =>
    let
        details_url = Text.Replace(url, "{finding_guid}", finding_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source)
    in
        json;

BitSightSecurityFindingsDetails.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the findings table
        findingsVendors = BitSightSecurityFindings.Feed(allVendorFindingsURL, endpoint, flag, null),
        isfindingsVendorsEmpty = Table.IsEmpty(findingsVendors),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isfindingsVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(findingsVendors, {"guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsList = List.Transform(vendorGuids[guid], each GetFindingsDetails(url, _)),
                detailsTable = Table.FromRecords(detailsList)
            in 
                detailsTable
        else
            #table({}, {}),

        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;


BitSightSecurityExternalQuestionnaires.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors table
        allVendors = BitSightSecurityAllVendors.Feed(allVendorsURL, endpoint, flag, null),
        // Check if allVendors is empty
        isVendorsEmpty = Table.IsEmpty(allVendors),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isVendorsEmpty then
            let
                vendorGuids = Table.SelectColumns(allVendors, {"vendor_guid"}),
                // Fetch details for each vendor_guid and create a new table
                detailsList = List.Transform(vendorGuids[vendor_guid], (guid) =>
                    let
                        result = try GetVendorQuestion(url, guid) otherwise #table({}, {})
                    in
                        result
                ),
                filteredList = List.Select(detailsList, each Table.RowCount(_) > 0), // Remove empty tables
                detailsTable = Table.Combine(filteredList)
            in 
                detailsTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;


BitSightSecurityExternalQuestionnairesProgress.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the allInternalQ table
        allExternalQ = BitSightSecurityExternalQuestionnaires.Feed(externalQuestionnairesURL, endpoint, flag, null),
        // Check if allInternalQ is empty
        isEmpty = Table.IsEmpty(allExternalQ),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isEmpty then
            let
                table_Guids = Table.SelectColumns(allExternalQ, {"questionnaire_guid", "vendor_guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(table_Guids), 
                    each GetQuestionProgress(url, _[vendor_guid], _[questionnaire_guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList)
            in 
                combinedDetailsTable
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

BitSightSecurityQuest.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        source = Web.Contents(url, [ Headers = DefaultVRMRequestHeaders ]),
        json = Json.Document(source),
        resultsTable = Table.FromList(json, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(resultsTable, [Empty = null])),
        expanded = Table.ExpandRecordColumn(resultsTable, "Column1", table_fields),
        withSchema = expanded
    in
        withSchema;

GetQuestionCat = (url as text, questionnaire_guid as text) =>
    let
        details_url = Text.Replace(url, "{questionnaire_guid}", questionnaire_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source)
    in
        json;

BitSightSecurityExternalQuestionnairesCategories.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
   let
        all_quest = BitSightSecurityQuest.Feed(questionnairesFullURL, endpoint, flag, null),
        // Check if all_quest is empty
        isVendorsEmpty = Table.IsEmpty(all_quest),

        // If isVendorsEmpty is not empty, get the vendor_guids and fetch details
        detailsTable = if not isVendorsEmpty then
            let
                questGuids = Table.SelectColumns(all_quest, {"guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(questGuids), 
                    each GetQuestionCat(url, _[guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList),
                #"Removed Other Columns" = Table.SelectColumns(combinedDetailsTable,{"guid", "categories"}),
                #"Expanded categories" = Table.ExpandListColumn(#"Removed Other Columns", "categories"),
                #"Expanded categories1" = Table.ExpandRecordColumn(#"Expanded categories", "categories", {"guid", "name"}, {"categories.guid", "categories.name"}),
                #"Renamed Columns" = Table.RenameColumns(#"Expanded categories1",{{"guid", "questionnaire_guid"}, {"categories.guid", "category_guid"}, {"categories.name", "name"}})
            in 
                #"Renamed Columns"
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

BitSightSecurityInternalQuestionnairesCategories.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the internal questionnaires table
        allInternalQ = BitSightSecurityInternalQuestionnaires.Feed(internalQuestionnairesURL, endpoint, flag, null),
        // Check if allInternalQ is empty
        isEmpty = Table.IsEmpty(allInternalQ),

        // If allInternalQ is not empty, get the distinct questionnaire_guid and fetch categories
        detailsTable = if not isEmpty then
            let
                removed_dup = Table.Distinct(allInternalQ, {"questionnaire_guid"}),
                table_Guids = Table.SelectColumns(removed_dup, {"questionnaire_guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(table_Guids), 
                    each GetQuestionCat(url, _[questionnaire_guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList),
                #"Removed Other Columns" = Table.SelectColumns(combinedDetailsTable,{"guid", "categories"}),
                #"Expanded categories" = Table.ExpandListColumn(#"Removed Other Columns", "categories"),
                #"Expanded categories1" = Table.ExpandRecordColumn(#"Expanded categories", "categories", {"guid", "name"}, {"categories.guid", "categories.name"}),
                #"Renamed Columns" = Table.RenameColumns(#"Expanded categories1",{{"guid", "questionnaire_guid"}, {"categories.guid", "category_guid"}, {"categories.name", "name"}})
            in 
                #"Renamed Columns"
        else
            #table({}, {}),
        
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        withSchema;

GetQuestionCatWithVendorID = (url as text, questionnaire_guid as text, vendor_guid as text) =>
    let
        details_url = Text.Replace(url, "{questionnaire_guid}", questionnaire_guid),
        source = Web.Contents(details_url, [Headers = DefaultVRMRequestHeaders]),
        json = Json.Document(source),
        // Add questionnaire_guid to each line
        detailsRecord = Record.AddField(json, "vendor_guid", vendor_guid)
    in
        detailsRecord;

BitSightSecurityQuestCategoriesAuxiliar = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the quest table
        allInternalQ = BitSightSecurityExternalQuestionnaires.Feed(externalQuestionnairesURL, endpoint, flag, null),
        // Check if allVendors is empty
        isEmpty = Table.IsEmpty(allInternalQ),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isEmpty then
            let
                table_Guids = Table.SelectColumns(allInternalQ, {"questionnaire_guid", "vendor_guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(table_Guids), 
                    each GetQuestionCatWithVendorID(url, _[questionnaire_guid], _[vendor_guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList),
                #"Removed Other Columns" = Table.SelectColumns(combinedDetailsTable,{"categories", "vendor_guid"}),
                #"Expanded categories" = Table.ExpandListColumn(#"Removed Other Columns", "categories"),
                #"Expanded categories1" = Table.ExpandRecordColumn(#"Expanded categories", "categories", {"guid"}, {"categories.guid"}),
                #"Renamed Columns" = Table.RenameColumns(#"Expanded categories1",{{"categories.guid", "category_guid"}})
            in 
                #"Renamed Columns"
        else
            #table({}, {}),
        withSchema = detailsTable
    in
        withSchema;

BitSightSecurityQuestCategoriesInternalAuxiliar = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the quest table
        allInternalQ = BitSightSecurityInternalQuestionnaires.Feed(internalQuestionnairesURL, endpoint, flag, null),
        // Check if allVendors is empty
        isEmpty = Table.IsEmpty(allInternalQ),

        // If managedVendors is not empty, get the vendor_guids and fetch details
        detailsTable = if not isEmpty then
            let
                table_Guids = Table.SelectColumns(allInternalQ, {"questionnaire_guid", "vendor_guid"}),
                // Fetch details for each vendor_guid and questionnaire_guid pair
                detailsList = List.Transform(
                    Table.ToRecords(table_Guids), 
                    each GetQuestionCatWithVendorID(url, _[questionnaire_guid], _[vendor_guid])
                ),
                // Combine all the resulting tables into one
                combinedDetailsTable = Table.FromRecords(detailsList),
                #"Removed Other Columns" = Table.SelectColumns(combinedDetailsTable,{"categories", "vendor_guid"}),
                #"Expanded categories" = Table.ExpandListColumn(#"Removed Other Columns", "categories"),
                #"Expanded categories1" = Table.ExpandRecordColumn(#"Expanded categories", "categories", {"guid"}, {"categories.guid"}),
                #"Renamed Columns" = Table.RenameColumns(#"Expanded categories1",{{"categories.guid", "category_guid"}})
            in 
                #"Renamed Columns"
        else
            #table({}, {}),
        withSchema = detailsTable
    in
        withSchema;

BitSightSecurityExternalQuestionnairesQuestions.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors and categories table
        vendorsCategories = BitSightSecurityQuestCategoriesAuxiliar(questionnairesCategoriesURL, endpoint, flag, null),
        
        // Check if the vendorsCategories table is empty
        isEmpty = Table.IsEmpty(vendorsCategories),

        // Process the table if not empty
        detailsTable = if not isEmpty then
            let
                // Transform each row to include the results from GetCategoryQuestion
                detailsList = List.Transform(
                    Table.ToRecords(vendorsCategories), 
                    each 
                        Record.AddField(_, "question_results", 
                            GetCategoryQuestion(url, [vendor_guid], [category_guid])
                        )
                ),
                // Convert the list of records into a table
                resultTable = Table.FromRecords(detailsList),
                #"Expanded question_results" = Table.ExpandTableColumn(resultTable, "question_results", {"Column1"}, {"question_results.Column1"}),
                #"Expanded question_results.Column1" = Table.ExpandRecordColumn(#"Expanded question_results", "question_results.Column1", {"guid", "question"}, {"question_results.Column1.guid", "question_results.Column1.question"}),
                finalTable = Table.RenameColumns(#"Expanded question_results.Column1",{{"question_results.Column1.guid", "question_guid"}, {"question_results.Column1.question", "question"}})
            in
                finalTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        // Apply schema transformation if schema is provided
        withSchema;

BitSightSecurityInternalQuestionnairesQuestions.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors and categories table
        vendorsCategories = BitSightSecurityQuestCategoriesInternalAuxiliar(questionnairesCategoriesURL, endpoint, flag, null),
        
        // Check if the vendorsCategories table is empty
        isEmpty = Table.IsEmpty(vendorsCategories),

        // Process the table if not empty
        detailsTable = if not isEmpty then
            let
                // Transform each row to include the results from GetCategoryQuestion
                detailsList = List.Transform(
                    Table.ToRecords(vendorsCategories), 
                    each 
                        Record.AddField(_, "question_results", 
                            GetCategoryQuestion(url, [vendor_guid], [category_guid])
                        )
                ),
                // Convert the list of records into a table
                resultTable = Table.FromRecords(detailsList),
                #"Expanded question_results" = Table.ExpandTableColumn(resultTable, "question_results", {"Column1"}, {"question_results.Column1"}),
                #"Expanded question_results.Column1" = Table.ExpandRecordColumn(#"Expanded question_results", "question_results.Column1", {"guid", "question"}, {"question_results.Column1.guid", "question_results.Column1.question"}),
                finalTable = Table.RenameColumns(#"Expanded question_results.Column1",{{"question_results.Column1.guid", "question_guid"}, {"question_results.Column1.question", "question"}})
            in
                finalTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        // Apply schema transformation if schema is provided
        withSchema;

BitSightSecurityExternalQuestionnairesAnswers.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors and categories table
        vendorsCategories = BitSightSecurityQuestCategoriesAuxiliar(questionnairesCategoriesURL, endpoint, flag, null),
        
        // Check if the vendorsCategories table is empty
        isEmpty = Table.IsEmpty(vendorsCategories),

        // Process the table if not empty
        detailsTable = if not isEmpty then
            let
                // Transform each row to include the results from GetCategoryQuestion
                detailsList = List.Transform(
                    Table.ToRecords(vendorsCategories), 
                    each 
                        Record.AddField(_, "question_results", 
                            GetCategoryQuestion(url, [vendor_guid], [category_guid])
                        )
                ),
                // Convert the list of records into a table
                resultTable = Table.FromRecords(detailsList),
                #"Expanded question_results" = Table.ExpandTableColumn(resultTable, "question_results", {"Column1"}, {"question_results.Column1"}),
                #"Expanded question_results.Column1" = Table.ExpandRecordColumn(#"Expanded question_results", "question_results.Column1", {"question_guid", "unanswered", "value"}, {"question_results.Column1.question_guid", "question_results.Column1.unanswered", "question_results.Column1.value"}),
                finalTable = Table.RenameColumns(#"Expanded question_results.Column1",{{"question_results.Column1.question_guid", "question_guid"}, {"question_results.Column1.unanswered", "unanswered"}, {"question_results.Column1.value", "value"}})
            in
                finalTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        // Apply schema transformation if schema is provided
        withSchema;

BitSightSecurityInternalQuestionnairesAnswers.Feed = (url as text, endpoint as text, flag as text, optional schema as table) =>
    let
        // Get the vendors and categories table
        vendorsCategories = BitSightSecurityQuestCategoriesInternalAuxiliar(questionnairesCategoriesURL, endpoint, flag, null),
        // Check if the vendorsCategories table is empty
        isEmpty = Table.IsEmpty(vendorsCategories),
        // Process the table if not empty
        detailsTable = if not isEmpty then
            let
                // Transform each row to include the results from GetCategoryQuestion
                detailsList = List.Transform(
                    Table.ToRecords(vendorsCategories), 
                    each 
                        Record.AddField(_, "question_results", 
                            GetCategoryQuestion(url, [vendor_guid], [category_guid])
                        )
                ),
                // Convert the list of records into a table
                resultTable = Table.FromRecords(detailsList),
                #"Expanded question_results" = Table.ExpandTableColumn(resultTable, "question_results", {"Column1"}, {"question_results.Column1"}),
                #"Expanded question_results.Column1" = Table.ExpandRecordColumn(#"Expanded question_results", "question_results.Column1", {"question_guid", "unanswered", "value"}, {"question_results.Column1.question_guid", "question_results.Column1.unanswered", "question_results.Column1.value"}),
                finalTable = Table.RenameColumns(#"Expanded question_results.Column1",{{"question_results.Column1.question_guid", "question_guid"}, {"question_results.Column1.unanswered", "unanswered"}, {"question_results.Column1.value", "value"}})
            in
                finalTable
        else
            #table({}, {}),
        withSchema = if schema <> null then SchemaTransformTable(detailsTable, schema) else detailsTable
    in
        // Apply schema transformation if schema is provided
        withSchema;

// Findings - Obtain Findings - Paginated
PaginatedResult = (url as text, company_guid as text, endpoint as text, affects_rating_findings as text, optional schema as table) as table => GetAllPagesByNextLink(url, company_guid, affects_rating_findings, endpoint, schema);

// Obtain Links - Pagination
GetAllPagesByNextLink = (url as text, company_guid as text, affects_rating_findings as text, optional endpoint as text, optional schema as table) as table =>
    Table.GenerateByPage((previous) => 
        let
            // if previous is null, then this is our first page of data
            nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,
            // if NextLink was set to null by the previous call, we know we have no more data
            page = if (nextLink <> null) then 
                                                if endpoint = "findings" then 
                                                    GetPageFindings(nextLink, company_guid, affects_rating_findings, schema)
                                                else if endpoint = "alerts" then 
                                                    GetPageAlerts(nextLink, schema)
                                                else if endpoint = "rvhistory" then 
                                                    GetPageRVHistory(nextLink, company_guid, schema)
                                                else if endpoint = "portfolio" then
                                                    GetPagePortfolio(nextLink, schema)
                                                else if endpoint = "rvhistoryport" then
                                                    GetPageRVHistoryPort(nextLink,schema)
                                                else if endpoint = "rvlatestport" then
                                                    GetPageRVLatestPort(nextLink, schema)
                                                else if endpoint = "ratingch" then
                                                    GetPageRatingCH(nextLink, schema)
                                                else if endpoint = "infrastructure" then
                                                    GetPageInfrastructure(nextLink,  company_guid, schema)
                                                else if endpoint = "assets" then
                                                    GetPageAssets(nextLink,  company_guid, schema)
                                                else error Extension.LoadString("EndpointWithNoPaginationError")
                   else null
        in
            page
    );
    
// Findings - Obtain Data Page
GetPageFindings = (url as text, company_guid as text, affects_rating_findings as text, optional schema as table) as table =>
    let
        new_url = if affects_rating_findings <> "all" then url & "&affects_rating=" & affects_rating_findings else url,
        response = Web.Contents(Text.Replace(new_url, "company_guid", company_guid), [ Headers = DefaultRequestHeaders ]),
        json = Json.Document(response, TextEncoding.Utf8),
        nextLink = json[links][next],
        counts = json[count],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        table_fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", table_fields),
        expanded_column1 = Table.ExpandRecordColumn(table, "Column1", {"affects_rating", "assets", "details", "evidence_key", "first_seen", "last_seen", "risk_category", "risk_vector", "risk_vector_label", "rolledup_observation_id", "severity", "severity_category", "tags", "remediation_history", "comments", "attributed_companies", "duration", "remaining_decay"}, {"affects_rating", "assets", "details", "evidence_key", "first_seen", "last_seen", "risk_category", "risk_vector", "risk_vector_label", "rolledup_observation_id", "severity", "severity_category", "tags", "remediation_history", "comments", "attributed_companies", "duration", "remaining_decay"}),
        expanded_details = Table.ExpandRecordColumn(expanded_column1, "details", {"diligence_annotations", "grade", "infection", "observed_ips", "vulnerabilities", "remediations", "geo_ip_location","dest_port","country","port_list","operating_system_version","user_agent_family","user_agent_version"}, {"details.diligence_annotations", "details.grade", "details.infection", "details.observed_ips", "details.vulnerabilities", "details.remediations", "details.geo_ip_location", "details.dest_port", "details.country", "details.port_list","details.operating_system_version","details.user_agent_family","details.user_agent_version"}),
        expanded_remediation_history = Table.ExpandRecordColumn(expanded_details, "remediation_history", {"last_requested_refresh_date", "last_refresh_status_date", "last_refresh_status_label", "last_remediation_status_label", "last_remediation_status_date", "remediation_assignments", "last_remediation_status_updated_by"}, {"last_requested_refresh_date", "last_refresh_status_date", "last_refresh_status_label", "last_remediation_status_label", "last_remediation_status_date", "remediation_assignments", "last_remediation_status_updated_by"}),
        expanded_attributed_companies = Table.ExpandListColumn(expanded_remediation_history, "attributed_companies"),
        expanded_attributed_companies1 = Table.ExpandRecordColumn(expanded_attributed_companies, "attributed_companies", {"guid", "name"}, {"attributed_companies.guid", "attributed_companies.name"}),
        expanded_results.details.remediations = Table.ExpandListColumn(expanded_attributed_companies1, "details.remediations"),
        expanded_results.details.remediations1 = Table.ExpandRecordColumn(expanded_results.details.remediations, "details.remediations", {"remediation_tip"}, {"details.remediations.remediation_tip"}),
        expanded_infection = Table.ExpandRecordColumn(expanded_results.details.remediations1, "details.infection", {"family"}, {"infection.family"}),
        expanded_assets = Table.ExpandListColumn(expanded_infection, "assets"),
        expanded_assets1 = Table.ExpandRecordColumn(expanded_assets, "assets", {"asset", "category", "importance"}, {"asset", "category", "importance"}),
        expanded_vulnerabilities = Table.ExpandListColumn(expanded_assets1, "details.vulnerabilities"),
        expanded_vulnerabilities1 = Table.ExpandRecordColumn(expanded_vulnerabilities, "details.vulnerabilities", {"name", "severity"}, {"vulnerabilities.name", "vulnerabilities.severity"}),
        expand_diligence_annotations = Table.ExpandRecordColumn(expanded_vulnerabilities1, "details.diligence_annotations", {"certchain", "message", "modal_tags"}, {"certchain", "message", "modal_tags"}),
        expanded_remediation_assignments = Table.ExpandListColumn(expand_diligence_annotations, "remediation_assignments"),
        extracted_values = Table.TransformColumns(expanded_remediation_assignments, {"remediation_assignments", each 
            if _ <> null then Text.Combine(List.Transform(_, Text.From), ",") else null, type text}),
        extracted_values2 = Table.TransformColumns(extracted_values, {"tags", each
            if _ <> null then Text.Combine(List.Transform(_, Text.From), ",") else null, type text}),
        extracted_values3 = Table.TransformColumns(extracted_values2, {"details.port_list", each
            if _ <> null then Text.Combine(List.Transform(_, Text.From), ",") else null, type text}),
        extracted_values4 = Table.TransformColumns(extracted_values3, {"details.observed_ips", each
            if _ <> null then Text.Combine(List.Transform(_, Text.From), ",") else null, type text}),
        change_errors = Table.ReplaceErrorValues(Table.ReplaceErrorValues(Table.ReplaceErrorValues(extracted_values4,{{"certchain", null}}),{{"message", null}}),{{"modal_tags", null}}),
        certchain_expanded = Table.ExpandListColumn(change_errors, "certchain"),
        certchain_expanded2 = Table.ExpandRecordColumn(certchain_expanded, "certchain", {"dnsName", "endDate", "issuerName", "serialNumber", "startDate", "subjectName"}, {"dnsName", "endDate", "issuerName", "serialNumber", "startDate", "subjectName"}),
        dnsName_expanded = Table.TransformColumns(certchain_expanded2, {"dnsName", each 
            if _ <> null then Text.Combine(List.Transform(_, Text.From), ",") else null, type text}),
        #"Changed Type" = Table.TransformColumnTypes(dnsName_expanded,{{"affects_rating", type logical}, {"importance", type number}, {"first_seen", type date}, {"last_seen", type date}, {"severity", type number}, {"last_requested_refresh_date", type date}, {"last_refresh_status_date", type date}, {"last_remediation_status_date", type date}}),
        //End: Code block not yet with dynamic schema treatment 
        output = #"Changed Type"
    in
        output meta [NextLink = nextLink];


        
        
// Risk Vector History - Obtain Data Page
GetPageRVHistory = (url as text, company_guid as text, optional schema as table) =>
    let
        source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        grades = results{0}[grades],
        table = Table.FromList(grades, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        //Start: Code block not yet with dynamic schema treatment
        #"Expanded risk_vectors" = Table.ExpandListColumn(withSchema, "risk_vectors"),
        #"Expanded risk_vectors1" = Table.ExpandRecordColumn(#"Expanded risk_vectors", "risk_vectors", {"risk_vector", "grade", "percentile"}, {"risk_vector", "grade", "percentile"}),
        #"Expanded risk_vector" = Table.ExpandRecordColumn(#"Expanded risk_vectors1", "risk_vector", {"name", "slug"}, {"name", "slug"}),
        #"Changed Type" = Table.TransformColumnTypes(#"Expanded risk_vector",{{"percentile", type number}}),
        //End: Code block not yet with dynamic schema treatment
        output = #"Changed Type"
    in
        output meta [NextLink = nextLink];

        // Portfolio - Obtain Data Page
GetPagePortfolio = (url as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
          //Start: Code block not yet with dynamic schema treatment
         #"results.industry Expandida" = Table.ExpandRecordColumn(withSchema, "industry", {"name", "slug"}, {"industry.name", "industry.slug"}),
         #"results.sub_industry Expandida" = Table.ExpandRecordColumn(#"results.industry Expandida", "sub_industry", {"name", "slug"}, {"sub_industry.name", "sub_industry.slug"}),
         #"results.subscription_type Expandida" = Table.ExpandRecordColumn(#"results.sub_industry Expandida", "subscription_type", {"name"}, {"subscription_type.name"}),
         #"results.relationship Expandida" = Table.ExpandRecordColumn( #"results.subscription_type Expandida", "relationship", {"name"}, {"relationship.name"}),
         #"Expanded life_cycle" = Table.ExpandRecordColumn(#"results.relationship Expandida", "life_cycle", {"name"}, {"life_cycle.name"}),
         #"Removed Columns" = Table.RemoveColumns (#"Expanded life_cycle",{"type"}),
         #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"guid", "Company Guid"}, {"industry.name", "Industry"}, {"industry.slug", "Industry Slug"}, {"sub_industry.name", "Sub Industry"}, {"sub_industry.slug", "Sub Industry Slug"}, {"subscription_type.name", "Subscription Type"}}),
         //End: Code block not yet with dynamic schema treatment
         output =  #"Renamed Columns1"
        
    in
        output meta [NextLink = nextLink];

// RVHISTORY

GetPageRVHistoryPort = (url as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        
        //Start: Code block not yet with dynamic schema treatment
        #"results.company Expandida" = Table.ExpandRecordColumn( withSchema, "company", {"guid", "name"}, {"company.guid", "company.name"}),
       #"results.grades Expandida" = Table.ExpandListColumn(#"results.company Expandida", "grades"),
       #"results.grades Expandida1" = Table.ExpandRecordColumn(#"results.grades Expandida", "grades", {"date", "risk_vectors"}, {"grades.date", "grades.risk_vectors"}),
       #"Tipo Alterado" = Table.TransformColumnTypes(#"results.grades Expandida1",{{"company.guid", type text}, {"company.name", type text}, {"grades.date", type date}, {"grades.risk_vectors", type any}}),
       #"results.grades.risk_vectors Expandida" = Table.ExpandListColumn(#"Tipo Alterado", "grades.risk_vectors"),
       #"results.grades.risk_vectors Expandida1" = Table.ExpandRecordColumn(#"results.grades.risk_vectors Expandida", "grades.risk_vectors", {"risk_vector", "grade", "percentile"}, {"grades.risk_vectors.risk_vector", "grades.risk_vectors.grade", "grades.risk_vectors.percentile"}),
       #"results.grades.risk_vectors.risk_vector Expandida" = Table.ExpandRecordColumn(#"results.grades.risk_vectors Expandida1", "grades.risk_vectors.risk_vector", {"name", "risk_category"}, {"grades.risk_vectors.risk_vector.name", "grades.risk_vectors.risk_vector.risk_category"}), 
       #"Renamed Columns1" = Table.RenameColumns(#"results.grades.risk_vectors.risk_vector Expandida",{{"company.guid", "Company Guid"}, {"company.name", "Company Name"}, {"grades.date", "Risk Vector Grade Date"}, {"grades.risk_vectors.risk_vector.name", "Risk Vector Name"}, {"grades.risk_vectors.risk_vector.risk_category", "Risk Vector Category"}, {"grades.risk_vectors.grade", "Risk Vector Grade"}}),
       #"Removed Columns" = Table.RemoveColumns (#"Renamed Columns1",{"grades.risk_vectors.percentile"}),
       //End: Code block not yet with dynamic schema treatment
        output = #"Removed Columns"
    in
        output meta [NextLink = nextLink];

//RVLATEST

GetPageRVLatestPort = (url as text,  optional schema as table) =>
    let 
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
       //Start: Code block not yet with dynamic schema treatment
       #"results.company Expandida" = Table.ExpandRecordColumn( withSchema, "company", {"guid", "name"}, {"company.guid", "company.name"}),
       #"results.grades Expandida" = Table.ExpandListColumn(#"results.company Expandida", "grades"),
       #"results.grades Expandida1" = Table.ExpandRecordColumn(#"results.grades Expandida", "grades", {"date", "risk_vectors"}, {"grades.date", "grades.risk_vectors"}),
       #"Tipo Alterado" = Table.TransformColumnTypes(#"results.grades Expandida1",{{"company.guid", type text}, {"company.name", type text}, {"grades.date", type date}, {"grades.risk_vectors", type any}}),
       #"results.grades.risk_vectors Expandida" = Table.ExpandListColumn(#"Tipo Alterado", "grades.risk_vectors"),
       #"results.grades.risk_vectors Expandida1" = Table.ExpandRecordColumn(#"results.grades.risk_vectors Expandida", "grades.risk_vectors", {"risk_vector", "grade", "percentile"}, {"grades.risk_vectors.risk_vector", "grades.risk_vectors.grade", "grades.risk_vectors.percentile"}),
       #"results.grades.risk_vectors.risk_vector Expandida" = Table.ExpandRecordColumn(#"results.grades.risk_vectors Expandida1", "grades.risk_vectors.risk_vector", {"name", "risk_category"}, {"grades.risk_vectors.risk_vector.name", "grades.risk_vectors.risk_vector.risk_category"}),
       #"Renamed Columns1" = Table.RenameColumns(#"results.grades.risk_vectors.risk_vector Expandida",{{"company.guid", "Company Guid"}, {"company.name", "Company Name"}, {"grades.date", "Risk Vector Grade Date"}, {"grades.risk_vectors.risk_vector.name", "Risk Vector Name"}, {"grades.risk_vectors.risk_vector.risk_category", "Risk Vector Category"}, {"grades.risk_vectors.grade", "Risk Vector Grade"}}),
       #"Removed Columns" = Table.RemoveColumns (#"Renamed Columns1",{"grades.risk_vectors.percentile"}),
       //End: Code block not yet with dynamic schema treatment
       output = #"Removed Columns"
        
    in
        output meta [NextLink = nextLink];

        //RatingCH
GetPageRatingCH = (url as text,  optional schema as table) =>
    let 
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
       //Start: Code block not yet with dynamic schema treatment
       #"Expanded results.reasons" = Table.ExpandListColumn(withSchema, "reasons"),
       #"Expanded results.reasons1" = Table.ExpandRecordColumn(#"Expanded results.reasons", "reasons", {"start_percentile", "risk_vector", "end_percentile"}, {"reasons.start_percentile", "reasons.risk_vector", "reasons.end_percentile"}),
       #"Removed Columns" = Table.RemoveColumns(#"Expanded results.reasons1",{"reasons.start_percentile", "reasons.end_percentile"}),
       #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"start_score", "start_rating"}, {"end_score", "end_rating"}}),
       #"Renamed Columns1" = Table.RenameColumns(#"Renamed Columns",{{"company", "Company Guid"}, {"reasons.risk_vector", "Reason Risk Vector"}}),
       //End: Code block not yet with dynamic schema treatment
       output = #"Renamed Columns1"
        
    in
        output meta [NextLink = nextLink];
 
//Infrastruture
GetPageInfrastructure = (url as text, company_guid as text, optional schema as table) as table =>
    let
        source = Web.Contents(Text.Replace(url, "company_guid", company_guid), [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        expanded_column1 = Table.ExpandRecordColumn(table, "Column1", {"value", "source", "country", "start_date", "end_date", "is_active", "attributed_to", "ip_count", "is_suppressed", "tags", "asn"}, {"results.value", "results.source", "results.country", "results.start_date", "results.end_date", "results.is_active", "results.attributed_to", "results.ip_count", "results.is_suppressed", "results.tags", "results.asn"}),
        expanded_source = Table.ExpandRecordColumn(expanded_column1, "results.source", {"slug", "name"}, {"results.source.slug", "results.source.name"}),
        expanded_country = Table.ExpandRecordColumn(expanded_source, "results.country", {"code", "name"}, {"results.country.code", "results.country.name"}),
        expanded_attributed_to = Table.ExpandRecordColumn(expanded_country, "results.attributed_to", {"guid", "name"}, {"results.attributed_to.guid", "results.attributed_to.name"}),
        expanded_tags = Table.ExpandListColumn(expanded_attributed_to, "results.tags"),
        expanded_tags_1 = Table.ExpandRecordColumn(expanded_tags, "results.tags", {"guid", "name", "is_public"}, {"results.tags.guid", "results.tags.name", "results.tags.is_public"}),
        changed_columns = Table.RenameColumns(expanded_tags_1,{{"results.value", "Value"}, {"results.source.slug", "Source.slug"}, {"results.source.name", "Source.name"}, {"results.country.code", "Country.code"}, {"results.country.name", "Country.name"}, {"results.start_date", "Start Date"}, {"results.end_date", "End Date"}, {"results.is_active", "Is Active"}, {"results.attributed_to.guid", "Attributed_to.guid"}, {"results.attributed_to.name", "Attributed_to.name"}, {"results.ip_count", "CIDR Size"}, {"results.is_suppressed", "Is Suppressed"}, {"results.tags.guid", "Tags.guid"}, {"results.tags.name", "Tags.name"}, {"results.tags.is_public", "Tags.is_public"}, {"results.asn", "AS Number"}}),
        //End: Code block not yet with dynamic schema treatment 
        output = changed_columns 
    in
        output meta [NextLink = nextLink];



//Assets
GetPageAssets = (url as text, company_guid as text, optional schema as table) as table =>
    let
        source = Web.Contents(Text.Replace(url, "company_guid", company_guid), [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        expanded_column1 = Table.ExpandRecordColumn(table, "Column1", {"asset", "asset_type", "app_grade", "country", "services", "products", "hosted_by", "origin_subsidiary", "findings", "tag_details", "combined_overrides"}, {"results.asset", "results.asset_type", "results.app_grade", "results.country", "results.services", "results.products", "results.hosted_by", "results.origin_subsidiary", "results.findings", "results.tag_details", "results.combined_overrides"}),
        expanded_findings = Table.ExpandRecordColumn(expanded_column1, "results.findings", {"total_count", "counts_by_severity"}, {"results.findings.total_count", "results.findings.counts_by_severity"}),
        expanded_tag_details = Table.ExpandListColumn(expanded_findings, "results.tag_details"),
        expanded_tag_details1 = Table.ExpandRecordColumn(expanded_tag_details, "results.tag_details", {"guid", "name", "is_inherited", "is_public"}, {"results.tag_details.guid", "results.tag_details.name", "results.tag_details.is_inherited", "results.tag_details.is_public"}),
        expanded_combined_overrides =Table.ExpandRecordColumn(expanded_tag_details1, "results.combined_overrides", {"importance"}, {"results.combined_overrides.importance"}),
        expanded_products = Table.ExpandListColumn(expanded_combined_overrides, "results.products"),
        expanded_products1 = Table.ExpandRecordColumn(expanded_products, "results.products", {"type", "vendor", "product", "version", "support"}, {"results.products.type", "results.products.vendor", "results.products.product", "results.products.version", "results.products.support"}),
        expanded_services = Table.ExpandListColumn(expanded_products1, "results.services"),
        expanded_hosted_by = Table.ExpandRecordColumn(expanded_services, "results.hosted_by", {"guid", "name"}, {"results.hosted_by.guid", "results.hosted_by.name"}),
        expanded_origin_subsidiary = Table.ExpandRecordColumn(expanded_hosted_by, "results.origin_subsidiary", {"guid", "name"}, {"results.origin_subsidiary.guid", "results.origin_subsidiary.name"}),
        expanded_findings_counts_by_severity = Table.ExpandRecordColumn(expanded_origin_subsidiary, "results.findings.counts_by_severity", {"severe", "material", "moderate", "minor"}, {"results.findings.counts_by_severity.severe", "results.findings.counts_by_severity.material", "results.findings.counts_by_severity.moderate", "results.findings.counts_by_severity.minor"}),
        changed_columns = Table.RenameColumns(expanded_findings_counts_by_severity,{{"results.asset", "Asset"}, {"results.asset_type", "Asset_type"}, {"results.tag_details.guid", "Tags.guid"}, {"results.tag_details.name", "Tags.name"}, {"results.tag_details.is_inherited", "Tags.is_inherited"}, {"results.tag_details.is_public", "Tags.is_public"}, {"results.combined_overrides.importance", "Importance"}, {"results.app_grade", "App Grade"}, {"results.country", "Country"}, {"results.services", "Services"}, {"results.products.type", "Identified Products.type"}, {"results.products.vendor", "Identified Products.vendor"}, {"results.products.product", "Identified Products.product"}, {"results.products.version", "Identified Products.version"}, {"results.products.support", "Identified Products.support"}, {"results.hosted_by.name", "Hosting Provider.name"}, {"results.hosted_by.guid", "Hosting Provider.guid"}, {"results.findings.counts_by_severity.severe", "Severe Findings (Impacts RV Grade)"}, {"results.findings.counts_by_severity.material", "Material Findings (Impacts RV Grade)"}, {"results.findings.counts_by_severity.moderate", "Moderate Findings (Impacts RV Grade)"}, {"results.findings.counts_by_severity.minor", "Minor Findings (Impacts RV Grade)"}, {"results.findings.total_count", "Findings (Impacts RV Grade)"}, {"results.origin_subsidiary.guid", "Originating Subsidiary.guid"}, {"results.origin_subsidiary.name", "Originating Subsidiary.name"}}),
    
        //End: Code block not yet with dynamic schema treatment 
        output = changed_columns
    in
        output meta [NextLink = nextLink];


// Alerts- Obtain Data Page
GetPageAlerts = (url as text, optional schema as table) =>
    let
        source = Web.Contents(url, [ Headers = DefaultRequestHeaders]),
        json = Json.Document(source),
        nextLink = json[links][next],
        results = json[results],
        table = Table.FromList(results, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        fields = Record.FieldNames(Table.FirstValue(table, [Empty = null])),
        expanded = Table.ExpandRecordColumn(table, "Column1", fields),
        withSchema = if (schema <> null) then SchemaTransformTable(expanded, schema) else expanded,
        output = withSchema
    in
        output meta [NextLink = nextLink];

// My Infrastructure - Obtain Data 
BitSightSecurityRatingsMyInfrastructure.Feed = (url as text, flag as text, company_guid as text, optional schema as table) =>
    let
        source = Web.Contents(Text.Replace(url, "company_guid", company_guid), [ Headers = 
        [
            Authorization = "Basic " & apiKey,
            Accept = "*/*",
            #"Content-Type" = "text/csv"
        ] 
        ]),
        body = Csv.Document(source,[Delimiter=",", Columns=13, Encoding=1252, QuoteStyle=QuoteStyle.Csv]),
        promoted_headers = Table.PromoteHeaders(body, [PromoteAllScalars=true]),
        withSchema = if (schema <> null) then SchemaTransformTable(promoted_headers, schema) else promoted_headers,
        removed_bottom_rows = Table.RemoveLastN(withSchema,2),
        removed_top_rows = Table.Skip(removed_bottom_rows,3)
    in
        if flag = "i" then removed_top_rows else removed_bottom_rows;

// Obtain the company's GUID of the user logged in
GetMyCompanyGUID = () as text =>
    let
        source = Json.Document(Web.Contents(guidUrl, [ Headers = DefaultRequestHeaders ])),
        guid = source[customer][my_company_guid],
        output = if (guid = null) then "none" else guid 
    in
        output;


// Obtain the company's Name of the user logged in
GetMyCompanyName = () as text =>
    let
        source = Json.Document(Web.Contents(guidUrl, [ Headers = FirstRequestHeaders ])),
        name = source[customer][name],
        output = name
    in
        output;

// Obtain the main company's subsidiaries
GetMyCompanyAllGUIDs = () as table =>
    let
        source = Json.Document(Web.Contents(guidUrl, [ Headers = DefaultRequestHeaders ])),
        subsidiariesGUIDs = source[customer][my_company_subsidiaries],
        subsidiariesGUIDsTable = Table.FromList(subsidiariesGUIDs, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        renamedSubsidiariesGUIDsColumns = Table.RenameColumns(subsidiariesGUIDsTable,{{"Column1", "guid"}}),
        mainCompanyGUID = source[customer][my_company_guid],
        mainCompanyGUIDTable = #table(1, {{mainCompanyGUID}}),
        renamedMainCompanyGUIDColumns = Table.RenameColumns(mainCompanyGUIDTable,{{"Column1", "guid"}}),
        combineTables = Table.Combine({renamedMainCompanyGUIDColumns, renamedSubsidiariesGUIDsColumns}),
        output = combineTables
    in
        output;


//
// Common Functions
//

// Common - Obtain Next Link - Pagination
GetNextLink = (response) as nullable text => 
    let
        next_url = response[links][next]
    in
        next_url;

// The getNextPage function takes a single argument and is expected to return a nullable table
Table.GenerateByPage = (getNextPage as function) as table =>
    let        
        listOfPages = List.Generate(
            () => getNextPage(null),            // get the first page of data
            (lastPage) => lastPage <> null,     // stop when the function returns null
            (lastPage) => getNextPage(lastPage) // pass the previous page to the next function call
        ),
        // concatenate the pages together
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        // if we didn't get back any pages of data, return an empty table
        // otherwise set the table type based on the columns of the first page
        if (firstRow = null) then
            Table.FromRows({})
        else        
            Value.ReplaceType(
                Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                Value.Type(firstRow[Column1])
            );

// Navigation Bar
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
            NavigationTable.NameColumn = nameColumn, 
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn, 
            Preview.DelayColumn = itemNameColumn, 
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;
//
// Schema functions
//

EnforceSchema.Strict = 1;               // Add any missing columns, remove extra columns, set table type
EnforceSchema.IgnoreExtraColumns = 2;   // Add missing columns, do not remove extra columns
EnforceSchema.IgnoreMissingColumns = 3; // Do not add or remove columns

SchemaTransformTable = (table as table, schema as table, optional enforceSchema as number) as table =>
    let
        // Default to EnforceSchema.Strict
        _enforceSchema = if (enforceSchema <> null) then enforceSchema else EnforceSchema.Strict,

        // Applies type transforms to a given table
        EnforceTypes = (table as table, schema as table) as table =>
            let
                map = (t) => if Type.Is(t, type list) or Type.Is(t, type record) or t = type any then null else t,
                mapped = Table.TransformColumns(schema, {"Type", map}),
                omitted = Table.SelectRows(mapped, each [Type] <> null),
                existingColumns = Table.ColumnNames(table),
                removeMissing = Table.SelectRows(omitted, each List.Contains(existingColumns, [Name])),
                primitiveTransforms = Table.ToRows(removeMissing),
                changedPrimitives = Table.TransformColumnTypes(table, primitiveTransforms)
            in
                changedPrimitives,

        // Returns the table type for a given schema
        SchemaToTableType = (schema as table) as type =>
            let
                toList = List.Transform(schema[Type], (t) => [Type=t, Optional=false]),
                toRecord = Record.FromList(toList, schema[Name]),
                toType = Type.ForRecord(toRecord, false)
            in
                type table (toType),

        // Determine if we have extra/missing columns.
        // The enforceSchema parameter determines what we do about them.
        schemaNames = schema[Name],
        foundNames = Table.ColumnNames(table),
        addNames = List.RemoveItems(schemaNames, foundNames),
        extraNames = List.RemoveItems(foundNames, schemaNames),
        tmp = Text.NewGuid(),
        added = Table.AddColumn(table, tmp, each []),
        expanded = Table.ExpandRecordColumn(added, tmp, addNames),
        result = if List.IsEmpty(addNames) then table else expanded,
        fullList =
            if (_enforceSchema = EnforceSchema.Strict) then
                schemaNames
            else if (_enforceSchema = EnforceSchema.IgnoreMissingColumns) then
                foundNames
            else
                schemaNames & extraNames,

        // Select the final list of columns.
        // These will be ordered according to the schema table.
        reordered = Table.SelectColumns(result, fullList, MissingField.Ignore),
        enforcedTypes = EnforceTypes(reordered, schema),
        withType = if (_enforceSchema = EnforceSchema.Strict) then Value.ReplaceType(enforcedTypes, SchemaToTableType(schema)) else enforcedTypes
    in
        withType;

//
// External Resources
//

BitSightSecurityRatings.Icons = [
    Icon16 = { Extension.Contents("BitSightSecurityRatings16.png"), Extension.Contents("BitSightSecurityRatings20.png"), Extension.Contents("BitSightSecurityRatings24.png"), Extension.Contents("BitSightSecurityRatings32.png") },
    Icon32 = { Extension.Contents("BitSightSecurityRatings32.png"), Extension.Contents("BitSightSecurityRatings40.png"), Extension.Contents("BitSightSecurityRatings48.png"), Extension.Contents("BitSightSecurityRatings64.png") }
];


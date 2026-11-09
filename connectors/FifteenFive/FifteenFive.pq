[Version="1.0.1"]
section FifteenFive;

[DataSource.Kind="FifteenFive", Publish="FifteenFive.Publish"]
shared FifteenFive.Contents = Value.ReplaceType(FifteenFive.ContentsImpl, FifteenFive.ContentsType);

FifteenFive.Schemas = [
    hello = {
    },
    getAnswer = {
        [Name = "id", Type = Int64.Type],
        [Name = "report_id", Type = Int64.Type],
        [Name = "question", Type = Text.Type],
        [Name = "user", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "answer_text", Type = Text.Type],
        [Name = "metrics_value", Type = Number.Type]
    },
    getAttribute = {
        [Name = "id", Type = Int64.Type],
        [Name = "name", Type = Text.Type],
        [Name = "slug", Type = Text.Type],
        [Name = "datatype", Type = Text.Type],
        [Name = "is_default", Type = Logical.Type],
        [Name = "is_only_admin_editable", Type = Logical.Type],
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type]
    },
    getAttributeValue = {
        [Name = "id", Type = Int64.Type],
        [Name = "attribute__is_only_admin_editable", Type = Logical.Type],
        [Name = "attribute__is_default", Type = Logical.Type],
        [Name = "attribute__id", Type = Int64.Type],
        [Name = "attribute__name", Type = Text.Type],
        [Name = "attribute__slug", Type = Text.Type],
        [Name = "attribute__datatype", Type = Text.Type],
        [Name = "attribute__category", Type = Text.Type],
        [Name = "user_id", Type = Int64.Type],
        [Name = "value", Type = Text.Type],
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type]
    },
    getDepartment = {
        [Name = "id", Type = Int64.Type],
        [Name = "name", Type = Text.Type]
    },
    getFeatureStatus = {
    },
    getCompanyIsActive = {
    },
    getGroup = {
        [Name = "id", Type = Int64.Type],
        [Name = "name", Type = Text.Type],
        [Name = "group_type_name", Type = Text.Type],
        [Name = "members_count", Type = Int64.Type],
        [Name = "mention_name", Type = Text.Type]
    },
    getGroupType = {
        [Name = "id", Type = Int64.Type],
        [Name = "name_plural", Type = Text.Type],
        [Name = "name_singular", Type = Text.Type]
    },
    getHighFive = {
        [Name = "id", Type = Int64.Type],
        [Name = "report", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "text", Type = Text.Type],
        [Name = "creator_id", Type = Int64.Type],
        [Name = "creator", Type = Text.Type],
        [Name = "creator_details.id", Type = Int64.Type],
        [Name = "creator_details.full_name", Type = Text.Type],
        [Name = "creator_details.email", Type = Text.Type],
        [Name = "receivers.id", Type = Int64.Type],
        [Name = "receivers.url", Type = Text.Type],
        [Name = "receivers.full_name", Type = Text.Type],
        [Name = "receivers.email", Type = Text.Type],
        [Name = "email_receivers.email", Type = Text.Type]
    },
    getObjective = {
        [Name = "id", Type = Int64.Type],
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type],
        [Name = "parent", Type = Text.Type],
        [Name = "user", Type = Text.Type],
        [Name = "user_details.id", Type = Int64.Type],
        [Name = "user_details.full_name", Type = Text.Type],
        [Name = "user_details.email", Type = Text.Type],
        [Name = "description", Type = Text.Type],
        [Name = "scope", Type = Text.Type],
        [Name = "start_ts", Type = Text.Type],
        [Name = "end_ts", Type = Text.Type],
        [Name = "color", Type = Text.Type],
        [Name = "percentage", Type = Int64.Type],
        [Name = "is_active", Type = Logical.Type],
        [Name = "is_closed", Type = Logical.Type],
        [Name = "is_complete", Type = Logical.Type],
        [Name = "is_archived", Type = Logical.Type],
        [Name = "is_past_due", Type = Logical.Type],
        [Name = "is_future", Type = Logical.Type],
        [Name = "visibility", Type = Text.Type],
        [Name = "result_count", Type = Int64.Type],
        [Name = "weight", Type = Number.Type]
    },
    getObjectiveHistory = {
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type],
        [Name = "user", Type = Text.Type],
        [Name = "user_details.id", Type = Int64.Type],
        [Name = "user_details.full_name", Type = Text.Type],
        [Name = "user_details.email", Type = Text.Type],
        [Name = "event", Type = Text.Type],
        [Name = "objective_id", Type = Int64.Type],
        [Name = "description", Type = Text.Type],
        [Name = "report_id", Type = Int64.Type],
        [Name = "key_result_id", Type = Int64.Type],
        [Name = "key_result", Type = Text.Type],
        [Name = "prior_value", Type = Text.Type],
        [Name = "current_value", Type = Text.Type],
        [Name = "comment_text", Type = Text.Type]
    },
    getOneOnOne = {
        [Name = "id", Type = Int64.Type],
        [Name = "user_1", Type = Text.Type],
        [Name = "user_1_details.id", Type = Int64.Type],
        [Name = "user_1_details.full_name", Type = Text.Type],
        [Name = "user_1_details.email", Type = Text.Type],
        [Name = "user_1_role", Type = Text.Type],
        [Name = "user_2", Type = Text.Type],
        [Name = "user_2_details.id", Type = Int64.Type],
        [Name = "user_2_details.full_name", Type = Text.Type],
        [Name = "user_2_details.email", Type = Text.Type],
        [Name = "user_2_role", Type = Text.Type],
        [Name = "is_draft", Type = Logical.Type],
        [Name = "for_date:", Type = Text.Type],
        [Name = "end_ts:", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type]
    },
    getOneOnOneBulkExport = {
        [Name = "reporter", Type = Text.Type],
        [Name = "reviewer", Type = Text.Type],
        [Name = "start_ts", Type = Text.Type],
        [Name = "end_ts", Type = Text.Type],
        [Name = "reporter_notes", Type = Text.Type],
        [Name = "reviewer_notes", Type = Text.Type],
        [Name = "reviewer_private_notes", Type = Text.Type],
        [Name = "reporter_private_notes", Type = Text.Type],
        [Name = "action_item_list.description", Type = Text.Type],
        [Name = "action_item_list.owner", Type = Text.Type],
        [Name = "action_item_list.creator", Type = Text.Type],
        [Name = "talking_point_list.description", Type = Text.Type],
        [Name = "talking_point_list.owner", Type = Text.Type]
    },
    getPriority = {
        [Name = "id", Type = Int64.Type],
        [Name = "user_id", Type = Int64.Type],
        [Name = "manager_id", Type = Int64.Type],
        [Name = "status", Type = Text.Type],
        [Name = "text", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "comments.user_id", Type = Int64.Type],
        [Name = "comments.comment_text", Type = Text.Type],
        [Name = "comments.create_ts", Type = Text.Type],
        [Name = "goal_status_comments.user_id", Type = Int64.Type],
        [Name = "goal_status_comments.comment_text", Type = Text.Type],
        [Name = "goal_status_comments.create_ts", Type = Text.Type]
    },
    getPulse = {
        [Name = "id", Type = Int64.Type],
        [Name = "report", Type = Text.Type],
        [Name = "user", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "value", Type = Text.Type]
    },
    getQuestion = {
        [Name = "id", Type = Int64.Type],
        [Name = "question_text", Type = Text.Type],
        [Name = "user", Type = Text.Type],
        [Name = "group", Type = Text.Type],
        [Name = "question_type", Type = Text.Type],
        [Name = "question_frequency", Type = Text.Type],
        [Name = "is_optional", Type = Logical.Type],
        [Name = "is_active", Type = Logical.Type],
        [Name = "create_ts", Type = type any],
        [Name = "update_ts", Type = type any]
    },
    getReport = {
        [Name = "id", Type = Int64.Type],
        [Name = "user", Type = Text.Type],
        [Name = "due_date", Type = Text.Type]
    },
    getReviewCycle = {
        [Name = "id", Type = Int64.Type],
        [Name = "name", Type = Text.Type],
        [Name = "does_peer_review", Type = Logical.Type],
        [Name = "does_upward_review", Type = Logical.Type],
        [Name = "does_manager_review", Type = Logical.Type],
        [Name = "does_self_review", Type = Logical.Type],
        [Name = "template.id", Type = Int64.Type],
        [Name = "template.name", Type = Text.Type],
        [Name = "peer_review_template.id", Type = Int64.Type],
        [Name = "peer_review_template.name", Type = Text.Type],
        [Name = "upward_review_template.id", Type = Int64.Type],
        [Name = "upward_review_template.name", Type = Text.Type],
        [Name = "cycle_start_ts", Type = Text.Type],
        [Name = "actual_start_ts", Type = Text.Type],
        [Name = "cycle_end_ts", Type = Text.Type],
        [Name = "lock_ts", Type = Text.Type],
        [Name = "peer_selection_due_ts", Type = Text.Type],
        [Name = "manager_reviews_end_ts", Type = Text.Type],
        [Name = "self_reviews_end_ts", Type = Text.Type],
        [Name = "upward_reviews_end_ts", Type = Text.Type],
        [Name = "peer_reviews_end_ts", Type = Text.Type],
        [Name = "peer_manager_approval_due_ts", Type = Text.Type],
        [Name = "share_and_finalize_end_ts", Type = Text.Type],
        [Name = "viewing_permissions", Type = Text.Type],
        [Name = "peer_reviews_transparency", Type = Text.Type],
        [Name = "upward_reviews_transparency", Type = Text.Type],
        [Name = "status", Type = Text.Type],
        [Name = "days_remaining", Type = Int64.Type],
        [Name = "statistics.number_of_reviews_completed", Type = Int64.Type],
        [Name = "statistics.number_of_reviews_uncompleted", Type = Int64.Type],
        [Name = "creator", Type = Text.Type],
        [Name = "creator_details.id", Type = Int64.Type],
        [Name = "creator_details.full_name", Type = Text.Type],
        [Name = "creator_details.email", Type = Text.Type],
        [Name = "participant_ids", Type = Int64.Type],
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type],
        [Name = "hierarchy_update_ts", Type = DateTimeZone.Type]
    },
    getSecurityAudit = {
        [Name = "actor", Type = Int64.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "type", Type = Text.Type],
        [Name = "extra", Type = Text.Type]
    },
    getUser = {
        [Name = "id", Type = Int64.Type],
        [Name = "global_id", Type = Text.Type],
        [Name = "create_ts", Type = DateTimeZone.Type],
        [Name = "update_ts", Type = DateTimeZone.Type],
        [Name = "first_name", Type = Text.Type],
        [Name = "last_name", Type = Text.Type],
        [Name = "email", Type = Text.Type],
        [Name = "location", Type = Text.Type],
        [Name = "employee_id", Type = Text.Type],
        [Name = "reviewer_id", Type = Text.Type],
        [Name = "mention_name", Type = Text.Type],
        [Name = "is_active", Type = Logical.Type],
        [Name = "company_groups_ids", Type = Int64.Type]
    },
    getVacation = {
        [Name = "id", Type = Int64.Type],
        [Name = "note", Type = Text.Type],
        [Name = "start_dt", Type = Text.Type],
        [Name = "end_dt", Type = Text.Type],
        [Name = "create_ts", Type = Text.Type],
        [Name = "user", Type = Text.Type]
    }
];

FifteenFive.Expansions = [
    hello = {},
    getAnswer = {},
    getAttribute = {},
    getAttributeValue = {},
    getDepartment = {},
    getFeatureStatus = {},
    getCompanyIsActive = {},
    getGroup = {},
    getGroupType = {},
    getHighFive = {
        [
            Kind = "Record",
            Name = "creator_details",
            Fields = {"id", "full_name", "email"},
            Names = {
                "creator_details.id",
                "creator_details.full_name",
                "creator_details.email"
            }
        ],
        [
            Kind = "List",
            Name = "receivers"
        ],
        [
            Kind = "Record",
            Name = "receivers",
            Fields = {"id", "url", "full_name", "email"},
            Names = {
                "receivers.id",
                "receivers.url",
                "receivers.full_name",
                "receivers.email"
            }
        ],
        [
            Kind = "List",
            Name = "email_receivers"
        ],
        [
            Kind = "Record",
            Name = "email_receivers",
            Fields = {"email"},
            Names = {"email_receivers.email"}
        ]
    },
    getObjective = {
        [
            Kind = "Record",
            Name = "user_details",
            Fields = {"id", "full_name", "email"},
            Names = {"user_details.id", "user_details.full_name", "user_details.email"}
        ]
    },
    getObjectiveHistory = {
        [
            Kind = "List",
            Name = "user_details"
        ],
        [
            Kind = "Record",
            Name = "user_details",
            Fields = {"id", "full_name", "email"},
            Names = {"user_details.id", "user_details.full_name", "user_details.email"}
        ]
    },
    getOneOnOne = {
        [
            Kind = "Record",
            Name = "user_1_details",
            Fields = {"id", "full_name", "email"},
            Names = {
                "user_1_details.id",
                "user_1_details.full_name",
                "user_1_details.email"
            }
        ],
        [
            Kind = "Record",
            Name = "user_2_details",
            Fields = {"id", "full_name", "email"},
            Names = {
                "user_2_details.id",
                "user_2_details.full_name",
                "user_2_details.email"
            }
        ]
    },
    getOneOnOneBulkExport = {
        [
            Kind = "List",
            Name = "action_item_list"
        ],
        [
            Kind = "Record",
            Name = "action_item_list",
            Fields = {"description", "owner", "creator"},
            Names = {
                "action_item_list.description",
                "action_item_list.owner",
                "action_item_list.creator"
            }
        ],
        [
            Kind = "List",
            Name = "talking_point_list"
        ],
        [
            Kind = "Record",
            Name = "talking_point_list",
            Fields = {"description", "owner"},
            Names = {"talking_point_list.description", "talking_point_list.owner"}
        ]
    },
    getPriority = {
        [
            Kind = "List",
            Name = "comments"
        ],
        [
            Kind = "Record",
            Name = "comments",
            Fields = {"user_id", "comment_text", "create_ts"},
            Names = {"comments.user_id", "comments.comment_text", "comments.create_ts"}
        ],
        [
            Kind = "List",
            Name = "goal_status_comments"
        ],
        [
            Kind = "Record",
            Name = "goal_status_comments",
            Fields = {"user_id", "comment_text", "create_ts"},
            Names = {
                "goal_status_comments.user_id",
                "goal_status_comments.comment_text",
                "goal_status_comments.create_ts"
            }
        ]
    },
    getPulse = {},
    getQuestion = {},
    getReport = {},
    getReviewCycle = {
        [
            Kind = "Record",
            Name = "template",
            Fields = {"id", "name"},
            Names = {"template.id", "template.name"}
        ],
        [
            Kind = "Record",
            Name = "peer_review_template",
            Fields = {"id", "name"},
            Names = {"peer_review_template.id", "peer_review_template.name"}
        ],
        [
            Kind = "Record",
            Name = "upward_review_template",
            Fields = {"id", "name"},
            Names = {"upward_review_template.id", "upward_review_template.name"}
        ],
        [
            Kind = "Record",
            Name = "statistics",
            Fields = {"number_of_reviews_completed", "number_of_reviews_uncompleted"},
            Names = {
                "statistics.number_of_reviews_completed",
                "statistics.number_of_reviews_uncompleted"
            }
        ],
        [
            Kind = "Record",
            Name = "creator_details",
            Fields = {"id", "full_name", "email"},
            Names = {
                "creator_details.id",
                "creator_details.full_name",
                "creator_details.email"
            }
        ],
        [
            Kind = "List",
            Name = "participant_ids"
        ]
    },
    getSecurityAudit = {},
    getUser = {
        [
            Kind = "List",
            Name = "company_groups_ids"
        ]
    },
    getVacation = {}
];

FifteenFive.Collections = [
    hello = [
        Name = "Hello",
        Key = "hello",
        OperationId = "hello",
        Path = "/api/public/hello/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/hello/"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(FifteenFive.Schemas, "hello"),
                    Expansions = Record.Field(FifteenFive.Expansions, "hello"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getAnswer = [
        Name = "Answer",
        Key = "answer",
        OperationId = "getAnswer",
        Path = "/api/public/answer/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/answer/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getAnswer"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getAnswer"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getAttribute = [
        Name = "Attribute",
        Key = "attribute",
        OperationId = "getAttribute",
        Path = "/api/public/attribute/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/attribute/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getAttribute"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getAttribute"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getAttributeValue = [
        Name = "AttributeValue",
        Key = "attribute_value",
        OperationId = "getAttributeValue",
        Path = "/api/public/attribute_value/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/attribute_value/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getAttributeValue"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getAttributeValue"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getDepartment = [
        Name = "Department",
        Key = "department",
        OperationId = "getDepartment",
        Path = "/api/public/department/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/department/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getDepartment"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getDepartment"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getFeatureStatus = [
        Name = "FeatureStatus",
        Key = "feature-status",
        OperationId = "getFeatureStatus",
        Path = "/api/public/feature-status/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/feature-status/"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(FifteenFive.Schemas, "getFeatureStatus"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getFeatureStatus"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getCompanyIsActive = [
        Name = "CompanyIsActive",
        Key = "is_active",
        OperationId = "getCompanyIsActive",
        Path = "/api/public/company/is_active/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/company/is_active/"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(FifteenFive.Schemas, "getCompanyIsActive"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getCompanyIsActive"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getGroup = [
        Name = "Group",
        Key = "group",
        OperationId = "getGroup",
        Path = "/api/public/group/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/group/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getGroup"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getGroup"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getGroupType = [
        Name = "GroupType",
        Key = "group-type",
        OperationId = "getGroupType",
        Path = "/api/public/group-type/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/group-type/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getGroupType"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getGroupType"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getHighFive = [
        Name = "HighFive",
        Key = "high-five",
        OperationId = "getHighFive",
        Path = "/api/public/high-five/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/high-five/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getHighFive"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getHighFive"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getObjective = [
        Name = "Objective",
        Key = "objective",
        OperationId = "getObjective",
        Path = "/api/public/objective/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/objective/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getObjective"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getObjective"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getObjectiveHistory = [
        Name = "ObjectiveHistory",
        Key = "history",
        OperationId = "getObjectiveHistory",
        Path = "/api/public/objective/history/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/objective/history/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getObjectiveHistory"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getObjectiveHistory"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getOneOnOne = [
        Name = "OneOnOne",
        Key = "one-on-one",
        OperationId = "getOneOnOne",
        Path = "/api/public/one-on-one/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/one-on-one/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getOneOnOne"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getOneOnOne"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getOneOnOneBulkExport = [
        Name = "OneOnOneBulkExport",
        Key = "bulk-export",
        OperationId = "getOneOnOneBulkExport",
        Path = "/api/public/one-on-one/bulk-export/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/one-on-one/bulk-export/"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(FifteenFive.Schemas, "getOneOnOneBulkExport"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getOneOnOneBulkExport"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getPriority = [
        Name = "Priority",
        Key = "priority",
        OperationId = "getPriority",
        Path = "/api/public/priority/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/priority/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getPriority"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getPriority"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getPulse = [
        Name = "Pulse",
        Key = "pulse",
        OperationId = "getPulse",
        Path = "/api/public/pulse/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/pulse/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getPulse"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getPulse"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getQuestion = [
        Name = "Question",
        Key = "question",
        OperationId = "getQuestion",
        Path = "/api/public/question/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/question/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getQuestion"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getQuestion"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getReport = [
        Name = "Report",
        Key = "report",
        OperationId = "getReport",
        Path = "/api/public/report/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/report/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getReport"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getReport"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getReviewCycle = [
        Name = "ReviewCycle",
        Key = "review-cycle",
        OperationId = "getReviewCycle",
        Path = "/api/public/review-cycle/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/review-cycle/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getReviewCycle"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getReviewCycle"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getSecurityAudit = [
        Name = "SecurityAudit",
        Key = "security-audit",
        OperationId = "getSecurityAudit",
        Path = "/api/public/security-audit/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/security-audit/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getSecurityAudit"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getSecurityAudit"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getUser = [
        Name = "User",
        Key = "user",
        OperationId = "getUser",
        Path = "/api/public/user/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/user/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getUser"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getUser"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ],
    getVacation = [
        Name = "Vacation",
        Key = "vacation",
        OperationId = "getVacation",
        Path = "/api/public/vacation/",
        Fetch = (baseUrl as text) as table =>
            FifteenFive.FetchCollection(
                Uri.Combine(baseUrl & "/", "api/public/vacation/"),
                "results",
                [
                    CollectionPath = {"results"},
                    Columns = Record.Field(FifteenFive.Schemas, "getVacation"),
                    Expansions = Record.Field(FifteenFive.Expansions, "getVacation"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ]
];

FifteenFive.BasePath = "";

FifteenFive.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];

FifteenFive.Request = (url as text, optional query as nullable record) as binary =>
    let
        manualRetryStatusCodes = {500, 502},
        send = (attempt as number) as binary =>
            let
                baseOptions = [
                    ManualStatusHandling = manualRetryStatusCodes,
                    IsRetry = attempt > 0
                ],
                queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),
                requestOptions = if Record.FieldCount(FifteenFive.RequestHeaders) = 0
                    then queryOptions else Record.AddField(queryOptions, "Headers", FifteenFive.RequestHeaders),
                response = Web.Contents(url, requestOptions),
                status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)
            in
                if List.Contains(manualRetryStatusCodes, status) then
                    if attempt < 2 then
                        Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))
                    else error Error.Record(
                        "HttpRequestFailed",
                        "HTTP request failed after retries.",
                        [Status = status])
                else response
    in
        send(0);

FifteenFive.RequestJson = (url as text, optional query as nullable record) as any =>
    Json.Document(FifteenFive.Request(url, query));

FifteenFive.TestConnectionProbe = (baseUrl as text) as table =>
    let
        endpoint = Uri.Combine(baseUrl & "/", "api/public/user/"),
        response = Binary.Buffer(FifteenFive.Request(endpoint, null))
    in
        #table({"Connected"}, {{Binary.Length(response) >= 0}});

FifteenFive.FetchCollection = (url as text, optional collectionName as text, optional options as record) =>
    let
            __options = options ?? [],
            __collectionPath = Record.FieldOrDefault(
                __options,
                "CollectionPath",
                if collectionName = null then {} else Text.Split(collectionName, ".")),
            __cols = Record.FieldOrDefault(__options, "Columns", {}),
            __expansions = Record.FieldOrDefault(__options, "Expansions", {}),
            __paging = Record.FieldOrDefault(__options, "Paging", [Style = "none"]),
            __style = Record.FieldOrDefault(__paging, "Style", "none"),
            __pageSize = Record.FieldOrDefault(__options, "PageSize", 100),
            __readPath = (value as any, path as list) as any =>
                List.Accumulate(
                    path,
                    value,
                    (state, segment) =>
                        if state is record and Record.HasFields(state, {segment})
                        then Record.Field(state, segment)
                        else null),
            pickCollection = (response as any) as list =>
                if response is list then response
                else if response is record then
                    let
                        explicit = if List.IsEmpty(__collectionPath)
                            then null else __readPath(response, __collectionPath),
                        auto = if explicit <> null then null else List.First(
                            List.Select(
                                Record.FieldNames(response),
                                each not List.Contains(
                                    {"next_page", "previous_page", "next", "previous", "nextLink", "@odata.nextLink", "count", "total", "total_count", "page", "per_page", "page_size", "has_more", "hasMore", "meta", "links", "links_meta"},
                                    _) and Value.Is(Record.Field(response, _), type list)),
                            null),
                        picked = if explicit <> null then explicit
                            else if auto <> null then Record.Field(response, auto)
                            else null
                    in
                        if picked is list then picked
                        else if picked is record then {picked}
                        else {response}
                else {},
            toTable = (items as list) as table =>
                let
                    records = List.Select(items, each _ is record),
                    rows = if List.IsEmpty(records)
                        then #table(List.Transform(__cols, each _[Name]), {})
                        else Table.FromRecords(records)
                in
                    ApplySchema(rows, __cols, __expansions),
            getPageNextLinkBody = (nextUrl as nullable text, first as logical) as nullable table =>
                if nextUrl = null or nextUrl = "" then null else
                let
                    limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                    query = if first and limitParam <> null
                        then Record.AddField([], limitParam, Text.From(__pageSize))
                        else null,
                    response = FifteenFive.RequestJson(nextUrl, query),
                    nextField = Record.FieldOrDefault(__paging, "NextField", "next_page"),
                    nextLink = __readPath(response, Text.Split(nextField, ".")),
                    page = toTable(pickCollection(response))
                in
                    page meta [Next = nextLink],
            result =
                if __style = "nextLinkBody" then
                    Table.GenerateByPage(
                        (previous) =>
                            let nextUrl = if previous = null then url else Value.Metadata(previous)[Next]
                            in getPageNextLinkBody(nextUrl, previous = null),
                        toTable({}))
                else
                    let
                        limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                        query = if limitParam = null then null
                            else Record.AddField([], limitParam, Text.From(__pageSize))
                    in
                        toTable(pickCollection(FifteenFive.RequestJson(url, query)))
        in
            result;

FifteenFive.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            FifteenFive.TestConnectionProbe(NormalizeUrl(url))
        else
            let
                    baseUrl = NormalizeUrl(url),
                    definitions = Record.ToTable(FifteenFive.Collections),
                    withDisplayName = Table.AddColumn(definitions, "DisplayName", each [Value][Name], type text),
                    withKey = Table.AddColumn(withDisplayName, "Key", each [Value][Key], type text),
                    withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),
                    withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
                    withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
                    withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
                    selected = Table.SelectColumns(
                        withIsLeaf,
                        {"DisplayName", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}),
                    objects = Table.RenameColumns(selected, {{"DisplayName", "Name"}}),
                    nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                in
                    nav;

FifteenFive.ContentsType =
    let
        url = (type text) meta [
            Documentation.FieldCaption = Extension.LoadString("fifteenfive.Contents.Parameter.url.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("fifteenfive.Contents.Parameter.url.FieldDescription"),
            Documentation.SampleValues = {"https://my.15five.com/"}
        ],
        options = (type record) meta [
            Documentation.FieldCaption = Extension.LoadString("fifteenfive.Contents.Parameter.options.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("fifteenfive.Contents.Parameter.options.FieldDescription")
        ],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("fifteenfive.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("fifteenfive.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("fifteenfive.Contents.Function.Description")
        ];

FifteenFive = [
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"FifteenFive.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = Extension.LoadString("ResourceLabel")
];

FifteenFive.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp") },
    SourceImage = FifteenFive.Icons,
    SourceTypeImage = FifteenFive.Icons
];

FifteenFive.Icons = [
    Icon16 = { Extension.Contents("15Five16.png"), Extension.Contents("15Five20.png"), Extension.Contents("15Five24.png"), Extension.Contents("15Five32.png") },
    Icon32 = { Extension.Contents("15Five32.png"), Extension.Contents("15Five40.png"), Extension.Contents("15Five48.png"), Extension.Contents("15Five64.png") }
];

NormalizeUrl = (url as text) as text =>
    let
        parts = Uri.Parts(url),
        scheme = Text.Lower(parts[Scheme]),
        host = Text.Lower(parts[Host]),
        rawPort = parts[Port]?,
        port = if rawPort = null or rawPort = 443 then ""
               else ":" & Text.From(rawPort),
        basePathTemplate = FifteenFive.BasePath,
        templateSegments = List.Select(
            Text.Split(Text.Trim(basePathTemplate, "/"), "/"),
            each _ <> ""),
        callerSegments = List.Select(
            Text.Split(Text.Trim(Record.FieldOrDefault(parts, "Path", ""), "/"), "/"),
            each _ <> ""),
        isVariable = (segment as text) as logical =>
            Text.StartsWith(segment, "{") and Text.EndsWith(segment, "}"),
        hasVariables = List.Contains(List.Transform(templateSegments, isVariable), true),
        pathMatches = List.Count(callerSegments) >= List.Count(templateSegments)
            and List.AllTrue(List.Transform(
                List.Positions(templateSegments),
                (index) => isVariable(templateSegments{index})
                    or templateSegments{index} = callerSegments{index})),
        resolvedSegments =
            if List.IsEmpty(templateSegments) then {}
            else if not hasVariables then templateSegments
            else if pathMatches then List.FirstN(callerSegments, List.Count(templateSegments))
            else error "endpoint path does not match OpenAPI server URL pattern",
        basePath = if List.IsEmpty(resolvedSegments)
            then "" else "/" & Text.Combine(resolvedSegments, "/")
    in
        if scheme <> "https" then error "https scheme required"
        else "https://" & host & port & basePath;

Table.GenerateByPage = (getNextPage as function, optional emptyTable as nullable table) as table =>
    let
        listOfPages = List.Generate(() => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then (emptyTable ?? Table.FromRows({}))
        else Value.ReplaceType(
            Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
            Value.Type(firstRow[Column1]));

ApplySchema = (rows as table, columns as list, expansions as list) as table =>
    let
        normalizeList = (value as any, name as text) as list =>
            if value is list then value
            else if value = null then {null}
            else error Error.Record("OpenAPI projection", "Expected a list while expanding '" & name & "'.", null),
        normalizeRecord = (value as any, fields as list, name as text) as record =>
            if value is record then Record.SelectFields(value, fields, MissingField.UseNull)
            else if value = null then Record.FromList(List.Repeat({null}, List.Count(fields)), fields)
            else error Error.Record("OpenAPI projection", "Expected a record while expanding '" & name & "'.", null),
        applyExpansion = (state as table, expansion as record) as table =>
            if not List.Contains(Table.ColumnNames(state), expansion[Name]) then state
            else if expansion[Kind] = "List" then
                Table.ExpandListColumn(
                    Table.TransformColumns(state, {{expansion[Name], each normalizeList(_, expansion[Name])}}),
                    expansion[Name])
            else
                Table.ExpandRecordColumn(
                    Table.TransformColumns(state, {{expansion[Name], each normalizeRecord(_, expansion[Fields], expansion[Name])}}),
                    expansion[Name],
                    expansion[Fields],
                    expansion[Names]),
        projected = List.Accumulate(expansions, rows, applyExpansion),
        present = List.Select(columns, each List.Contains(Table.ColumnNames(projected), _[Name])),
        isStructured = (column as record) as logical =>
            let columnType = Type.NonNullable(column[Type])
            in columnType = type record or columnType = type list,
        conversions = List.Select(present, each not isStructured(_)),
        structured = List.Select(present, each isStructured(_)),
        pairs = List.Transform(conversions, each {_[Name], _[Type]}),
        converted = if List.IsEmpty(pairs) then projected else Table.TransformColumnTypes(projected, pairs),
        operations = List.Transform(structured, each {_[Name], (value) => value, _[Type]})
    in
        if List.IsEmpty(operations) then converted
        else Table.TransformColumns(converted, operations);

Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn     = nameColumn,
            NavigationTable.DataColumn     = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn            = itemNameColumn,
            NavigationTable.IsLeafColumn   = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;

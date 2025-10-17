workspace "EduTech Platform" "A cloud-based platform for online learning, serving students and instructors globally." {

    model {
        student = person "Student" "A learner who uses the platform to enroll in and take courses." "Student"
        instructor = person "Instructor" "Creates and manages courses, and interacts with students." "Instructor"
        admin = person "Administrator" "Manages the platform and handles operational issues." "Admin"

        group "EduTech Ltd." {
            educationPlatform = softwaresystem "Education Platform" "Provides online courses, assessments, and certifications." {
                webApp = container "Web Application" "Allows users to access courses, submit assignments, and manage accounts." "React + Node.js" "Web Browser"
                mobileApp = container "Mobile App" "Mobile version of the platform with limited features." "React Native" "Mobile App"
                api = container "API Application" "Handles business logic and data access via REST API." "Node.js/Express"
                database = container "Database" "Stores user profiles, course data, progress, submissions, etc." "PostgreSQL" "Database"
                fileStorage = container "File Storage" "Stores course videos, documents, and assignments." "AWS S3" "Blob Storage"
            }

            adminTool = container "Admin Dashboard" "Used by administrators for managing users, courses, and reports." "Angular + Express"
        }

        # External integrations
        paymentGateway = softwaresystem "Payment Gateway (Stripe)" "Handles payments and subscriptions." "External System"
        emailService = softwaresystem "Email Service (SendGrid)" "Sends transactional and promotional emails." "External System"
        videoService = softwaresystem "Video Conferencing (Zoom)" "Used for live classes and meetings." "External System"
        analyticsPlatform = softwaresystem "Analytics Platform (Mixpanel)" "Tracks user behavior and engagement metrics." "External System"

        # User interactions
        student -> webApp "Uses to access courses"
        student -> mobileApp "Uses to access courses on mobile"
        instructor -> webApp "Manages courses via"
        admin -> adminTool "Manages the system using"

        # Container interactions
        webApp -> api "Uses REST API"
        mobileApp -> api "Uses REST API"
        adminTool -> api "Uses REST API"
        api -> database "Reads/writes user and course data"
        api -> fileStorage "Uploads/downloads files"
        api -> paymentGateway "Processes payments via"
        api -> emailService "Sends emails via"
        api -> videoService "Schedules live sessions via"
        api -> analyticsPlatform "Sends tracking events to"

        deploymentEnvironment "Production" {
            deploymentNode "AWS Cloud" "" "Amazon Web Services" {
                deploymentNode "Kubernetes Cluster" "" "EKS" {
                    containerInstance webApp
                    containerInstance mobileApp
                    containerInstance api
                    containerInstance adminTool
                }
                deploymentNode "RDS PostgreSQL" "" "PostgreSQL 13" {
                    containerInstance database
                }
                deploymentNode "S3 Bucket" "" "AWS S3" {
                    containerInstance fileStorage
                }
            }
        }
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
            description "High-level view showing users, the education platform, and its integrations."
        }

        systemcontext educationPlatform "SystemContext" {
            include *
            animation {
                educationPlatform
                student instructor admin
                paymentGateway emailService videoService analyticsPlatform
            }
            autoLayout
            description "Context diagram showing users and third-party systems interacting with the education platform."
        }

        container educationPlatform "Containers" {
            include *
            animation {
                student instructor
                webApp mobileApp adminTool
                api
                database fileStorage
                paymentGateway emailService videoService analyticsPlatform
            }
            autoLayout
            description "Container diagram showing the internals of the education platform and external integrations."
        }

        deployment educationPlatform "Production" "ProductionDeployment" {
            include *
            animation {
                webApp mobileApp adminTool api
                database fileStorage
            }
            autoLayout
            description "Production deployment of the education platform on AWS."
        }

        styles {
            element "Person" {
                shape Person
                color #ffffff
                fontSize 22
            }

            element "Student" {
                background #4B8BBE
            }
            element "Instructor" {
                background #306998
            }
            element "Admin" {
                background #2b2b2b
            }

            element "Software System" {
                background #1168bd
                color #ffffff
            }

            element "External System" {
                background #999999
                color #ffffff
            }

            element "Container" {
                background #438dd5
                color #ffffff
            }

            element "Web Browser" {
                shape WebBrowser
            }

            element "Mobile App" {
                shape MobileDevicePortrait
            }

            element "Database" {
                shape Cylinder
            }

            element "Blob Storage" {
                shape Folder
            }
        }
    }
}

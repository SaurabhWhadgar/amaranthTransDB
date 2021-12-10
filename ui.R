library(shiny)
library(shinydashboard)
library(DT)


# Define UI for application that draws a histogram
sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
       # menuItem("Widgets", icon = icon("th"), tabName = "widgets", badgeLabel = "new", badgeColor = "green")
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "dashboard",
                h2("Search for Transcriptome Data"),
                
               fluidRow(box(width = 12,collapsible = TRUE,solidHeader=TRUE,status = "success",title = "Gene Search",
                    column(width = 8,textInput("querysearch","Query", placeholder = "Enter --> AhKP_16362/AT2G27290/Gene Name/Gene Function")),
                    column(width = 4,title = "Search Database",collapsible = TRUE,HTML("<br>"),actionButton("searchbutton","SUBMIT"))#column3
                ,footer = "Enter AhKP Gene ID (e.g. AhKP_16362)")),
                
               fluidRow(box(title = "Result Data Table",width = 12,
                            DT::dataTableOutput("queryresult"))),         
                
                fluidRow(box(
                    title = "Plot Graph by AhKP Gene ID",solidHeader = TRUE,status = "info",
                    textInput('query',"Enter AhKP Gene ID")
                ),
                box(height = 139,solidHeader = TRUE,status = "primary",
                    title = "Plot the Graph",
                    actionButton("plotsubmit","Click Here to Plot")
                )
        ),
        
        fluidRow(
            box(title="Line Plot", status = "warning", solidHeader=TRUE, collapsible = FALSE,collapsed = TRUE,
                plotOutput("lineplot"),width = 12,footer = "R = Root, S = Stem, L = Leaves, Bd = Bud, FLwr = Flower, YSe = Young Seed, 
                MSe = Mature Seed : Developmental Stages [R15 => Root 15 Days]",)
            
        ),
        fluidRow(box(title = "Transcriptome Result ( DESeq Normalized Data)",width = 12,
            DT::dataTableOutput("transtable")))

    
        
        #tabItem(tabName = "widgets",h2("Widgets tab content"))
    )
)
)
# Put them together into a dashboardPage
dashboardPage(skin = "black",
    dashboardHeader(title = "Amaranth TransDB"),
    sidebar,
    body
)
source("globals.R")

library(shinydashboard)
library(ggplot2)
library(readxl)
library(shinyjs)

# Define UI for dataset viewer app ----

dashboardPage(
    dashboardHeader(title = "Inventory"),
    
    dashboardSidebar(
        sidebarMenu(
            # Setting id makes input$tabs give the tabName of currently-selected tab
            id = "tabs",
            menuItem("Inventory List", tabName = "inventoryList", icon = icon("list")),
            menuItem("Update Inventory", tabName = "updateInventory", icon = icon("edit")),
            menuItem("Add New Inventory", tabName = "addNewInventory", icon = icon("plus")
            )
        )
    ),
    
    dashboardBody(
        fluidPage(
            useShinyjs(),
            inlineCSS(appCSS),
            
            tabItems(
                
                tabItem("inventoryList",
                        # Output: Inventory Table
                        dataTableOutput('mytable'),
                        dataTableOutput('updateTable')
                ),
                
                tabItem("updateInventory",
                        
                        div(
                            id = "updateForm",
                         
                            # Input: Item Barcode
                            textInput(inputId = "itemBarcode",
                                      labelMandatory("Scan item barcode:")),
                            
                            # Select which column to update.
                            selectInput("column",
                                        labelMandatory("Choose a column to update:"),
                                        c(columnNames[-c(0, 1, 2)])
                            ),
                            
                            # Input: New value for selected column
                            textInput(inputId = "newColumnValue",
                                      label = NULL),
                            
                            # Action Button: Submit
                            actionButton("updateInventoryItem", "Submit", class = "btn-primary")   
                        )
                ),
                
                tabItem("addNewInventory",
                        
                        div(
                            id = "newForm",
                            
                            # Input: Barcode
                            textInput(inputId = "Barcode",
                                      label= "Barcode:"),
                            
                            # Input: Chemical
                            textInput(inputId = "Name",
                                      labelMandatory("Name:")),
                            
                            # Input: Location
                            textInput(inputId = "Location",
                                      labelMandatory("Location:")),
                            
                            # Input: Column1
                            textInput(inputId = "Column1",
                                      label = "Column1:"),
                            
                            # Input: Column2
                            textInput(inputId = "Column2",
                                      label = "Column2:"),
                            
                            # Input: Column3
                            textInput(inputId = "Column3",
                                      label = "Column3:"),
                            
                            # Input: Column4
                            textInput(inputId = "Column4",
                                      label = "Column4:"),
                            
                            # Input: Column5
                            textInput(inputId = "Column5",
                                      label = "Column5:"),
                            
                            # Input: Column6
                            textInput(inputId = "Column6",
                                      label = "Column6:"),
                            
                            # Input: Column7
                            textInput(inputId = "Column7",
                                      label = "Column7:"),
                            
                            # Input: Column8
                            textInput(inputId = "Column8",
                                      label = "Column8:"),
                            
                            # Action Button: Submit
                            actionButton("addNewItem", "Submit", class = "btn-primary"),
                            
                            hidden(
                                span(id = "newSubmitMsg", "Submitting..."),
                                div(id = "newError",
                                    div(br(), tags$b("Error: "), span(id = "newErrorMsg"))
                                )
                            )
                        ),
                        
                        hidden(
                            div(
                                id = "NewThankYouMsg",
                                h3("Thanks, your response was submitted successfully!"),
                                actionLink("newSubmitAnother", "Submit another response")
                            )
                        )
                        
                )
            )
        )
    )
)
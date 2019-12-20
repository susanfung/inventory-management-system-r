library(shinydashboard)
library(ggplot2)
library(readxl)

# Read the dataset.
sheets <- readxl::excel_sheets("Inventory.xlsx")
InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
names(InventoryList) <- sheets
columnNames <- colnames(InventoryList$Inventory)

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
            
            tabItems(
                tabItem("inventoryList",
                        # Output: Inventory Table
                        dataTableOutput('mytable')
                ),
                
                tabItem("updateInventory",
                        # Input: Chemical Barcode
                        textInput(inputId = "barcodeChemical",
                                  label = "Chemical:",
                                  value = "Scan Barcode"),
                        
                        # Select which column to update.
                        selectInput("column", "Choose a column to update:",
                                    c(columnNames[-c(0, 1, 2)])
                        ),
                        
                        # Input: New value for selected column
                        textInput(inputId = "newColumnValue",
                                  label = NULL,
                                  value = "Enter new value"),
                        
                        # Action Button: Submit
                        actionButton("updateChemical", "Submit")
                ),
                
                tabItem("addNewInventory",
                        
                        # Input: Chemical
                        textInput(inputId = "name",
                                  label = "New Chemical:",
                                  value = "Scan Barcode"),
                        
                        # Input: Location
                        textInput(inputId = "location",
                                  label = "Location:",
                                  value = "Scan Barcode"),
                        
                        # Input: Column1
                        textInput(inputId = "column1",
                                  label = "Column1:",
                                  value = "Scan Barcode"),
                        
                        # Action Button: Submit
                        actionButton("addNewChemical", "Submit")
                )
            )
        )
    )
)
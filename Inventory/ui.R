library(shinydashboard)
library(ggplot2)
library(readxl)

# Read the dataset.
sheets <- readxl::excel_sheets("Inventory.xlsx")
InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
names(InventoryList) <- sheets
vchoices <- 1:ncol(InventoryList$Inventory)
names(vchoices) <- names(InventoryList$Inventory)

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
                        
                        # Input: Location Barcode
                        textInput(inputId = "barcodeLocation",
                                  label = "Location:",
                                  value = "Scan Barcode"),
                        
                        # Action Button: Submit
                        actionButton("updateLocation", "Submit")
                ),
                
                tabItem("addNewInventory",
                        "Form content here"
                )
            )
        )
    )
)
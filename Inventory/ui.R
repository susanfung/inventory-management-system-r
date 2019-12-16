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
    
    dashboardBody(
        fluidPage(
            # Output: Inventory Table
            dataTableOutput('mytable')
        )
    )
)
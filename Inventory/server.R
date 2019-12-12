# Load the required packages.
library(shiny)
library(readxl)

# Create the server functions for the UI.
shinyServer(function(input, output) {

    # Read the dataset.
    sheets <- readxl::excel_sheets("Inventory.xlsx")
    InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
    names(InventoryList) <- sheets
    
    # Show inventory list.
    output$view <- renderTable({
        head(InventoryList$Inventory)
    })

})
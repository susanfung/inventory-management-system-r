# Load the required packages.
library(shiny)
library(readxl)
library(ggplot2)

# Create the server functions for the UI.
shinyServer(function(input, output) {

    # Read the dataset.
    sheets <- readxl::excel_sheets("Inventory.xlsx")
    InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
    names(InventoryList) <- sheets
    
    # Update chemical location.
    eventReactive(input$updateLocation, {
        
        # Render inputs.
        output$barcode_chemical <- {(
            renderText(input$barcodeChemical)
        )}
        
        output$barcode_location <- {(
            renderText(input$barcodeLocation)
        )}
        
    })
    
    # Show inventory list.
    output$table <- DT::renderDataTable(DT::datatable({
        data <- InventoryList$Inventory
        data
    }))

})
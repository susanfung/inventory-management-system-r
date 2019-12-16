# Load the required packages.
library(shiny)
library(readxl)
library(ggplot2)
library(DT)

# Create the server functions for the UI.
shinyServer(function(input, output) {

    # Read the dataset.
    sheets <- readxl::excel_sheets("Inventory.xlsx")
    InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
    names(InventoryList) <- sheets
    
    # Show table selected columns.
    output$mytable = renderDataTable(
        InventoryList$Inventory, rownames = FALSE,
        extensions = 'Buttons', options = list(
            dom = 'Bfrtip',
            buttons = list(list(extend = 'colvis', columns = c(0)))
        )
    )
    
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

})
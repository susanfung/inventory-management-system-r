source("globals.R")

# Load the required packages.
library(shiny)
library(readxl)
library(ggplot2)
library(DT)

# Create the server functions for the UI.
shinyServer(function(input, output, session) {

    # Read the dataset.
    sheets <- readxl::excel_sheets("Inventory.xlsx")
    InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
    names(InventoryList) <- sheets
    
    # Show table selected columns.
    output$mytable = renderDataTable(
        InventoryList$Inventory, rownames = FALSE,
        extensions = list('Buttons' = NULL,
                          'FixedColumns' = NULL,
                          'FixedHeader' = NULL),
        options = list(
            dom = 'Blfrtip',
            buttons = list(list(extend = 'colvis', columns = c(0, 3, 4, 5, 6, 7, 8, 9, 10))),
            scrollX = TRUE,
            fixedColumns = list(leftColumns = 3),
            fixedHeader = TRUE
        )
    )
    
    # Update inventory.
    eventReactive(input$updateChemical, {
        
        # Render inputs.
        output$barcode_chemical <- {(
            renderText(input$barcodeChemical)
        )}
        
        output$new_value <- {(
            renderText(input$newColumnValue)
        )}
        
    })
    
    # Add new inventory.
    
    # Only enable the Submit button when the mandatory fields are validated
    observe({
        mandatoryFilled <-
            vapply(fieldsMandatory,
                   function(x) {
                       !is.null(input[[x]]) && input[[x]] != ""
                   },
                   logical(1))
        mandatoryFilled <- all(mandatoryFilled)

        shinyjs::toggleState(id = "addNewItem", condition = mandatoryFilled)
    })

})
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
        loadData(), rownames = FALSE,
        extensions = list('Buttons' = NULL,
                          'FixedColumns' = NULL,
                          'FixedHeader' = NULL),
        options = list(
            dom = 'lBfrtip',
            buttons = list(list(extend = 'colvis', columns = c(0, 3, 4, 5, 6, 7, 8, 9, 10)), c('excel', 'pdf')),
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
    
    # Only enable the Submit button when the mandatory fields are validated.
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
    
    # Gather new form data.
    newFormData <- reactive({
        data <- sapply(fieldsAll, function(x) input[[x]])
        data <- c(timestamp = epochTime(), data)
        data <- t(data)
        data
    })
    
    # Save new form data.
    saveNewData <- function(data) {
        fileName <- sprintf("%s_%s.csv",
                            humanTime(),
                            digest::digest(data))
        
        write.csv(x = data, file = file.path(responsesDir, fileName),
                  row.names = FALSE, quote = TRUE)
    }
    
    # Action to take when submit button is pressed.
    observeEvent(input$addNewItem, {
        saveNewData(newFormData())
        shinyjs::reset("newForm")
        shinyjs::hide("newForm")
        shinyjs::show("NewThankYouMsg")
    })
    
    observeEvent(input$addNewItem, {
        shinyjs::disable("addNewItem")
        shinyjs::show("newSubmitMsg")
        shinyjs::hide("newError")
        
        tryCatch({
            saveNewData(newFormData())
            shinyjs::reset("newForm")
            shinyjs::hide("newForm")
            shinyjs::show("NewThankYouMsg")
        },
        
        error = function(err) {
            shinyjs::html("newErrorMsg", err$message)
            shinyjs::show(id = "error", anim = TRUE, animType = "fade")
        },
        
        finally = {
            shinyjs::enable("addNewItem")
            shinyjs::hide("newSubmitMsg")
        })
    })
    
    observeEvent(input$newSubmitAnother, {
        shinyjs::show("newForm")
        shinyjs::hide("NewThankYouMsg")
    }) 

})
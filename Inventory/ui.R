library(shiny)

# Define UI for dataset viewer app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Reactivity"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Chemical Barcode
            textInput(inputId = "barcodeChemical",
                      label = "Chemical:",
                      value = "Scan Barcode"),
            
            # Input: Location Barcode
            textInput(inputId = "barcodeLocation",
                      label = "Location:",
                      value = "Scan Barcode")
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: HTML table with requested number of observations ----
            tableOutput("view")
            
        )
    )
)
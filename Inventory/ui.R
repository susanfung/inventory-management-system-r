library(shinydashboard)

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
                  value = "Scan Barcode")
    ),
    dashboardBody(
        fluidPage(
            # Output: Inventory Table
            tableOutput("view")
        )
    )
)
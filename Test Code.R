library(readxl)    

sheets <- readxl::excel_sheets("Inventory.xlsx")
InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
names(InventoryList) <- sheets
vchoices <- 1:ncol(InventoryList$Inventory)
names(vchoices) <- names(InventoryList$Inventory)
head(vchoices)
columnNames <- colnames(InventoryList$Inventory)
columnNames

# Show selected column to update.
output$result <- renderText({
  paste("Enter new value for ", input$column)
})
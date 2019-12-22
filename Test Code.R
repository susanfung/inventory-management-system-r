library(writexl)
library(readxl)
library(dplyr)

sheets <- readxl::excel_sheets("Inventory.xlsx")
InventoryList <- lapply(sheets, function(X) readxl::read_excel("Inventory.xlsx", sheet = X))
names(InventoryList) <- sheets
vchoices <- 1:ncol(InventoryList$Inventory)
names(vchoices) <- names(InventoryList$Inventory)
columnNames <- colnames(InventoryList$Inventory)

updateFormData <- InventoryList$Inventory %>% filter(., Barcode == "1") %>% mutate(Location = 100)
remainingFormData <- InventoryList$Inventory %>% filter(., Barcode != "1")
InventoryList$Inventory <- rbind(updateFormData, remainingFormData)
sheets <- list("Inventory" = InventoryList$Inventory, "Location" = InventoryList$Location)
write_xlsx(sheets, "Inventory.xlsx")

# Show selected column to update.
output$result <- renderText({
  paste("Enter new value for ", input$column)
})
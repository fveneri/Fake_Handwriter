library(shiny)

ui <- navbarPage(
  "CSAFE-Evidence Explorer",
  tabPanel(
    "Info Tab",
    fluidPage(
      HTML("<h3>Welcome to CSAFE Evidence Explorer</h3>
        <p>This app allows you to explore and visualize evidence found at the crime scene and the suspects data</p>"),
      HTML("<h3>What we know</h3>
        <p>The elusive CATburglar has strike again</p>"),
      imageOutput("CAT"),
      HTML("<p>The Corgi Detective in on the case</p>"),
      imageOutput("CORGI"),
      HTML("<h3>But he only has a clue to find the thief </h3>
           <h3> An enigmatic note left behind </h3>"),
      imageOutput("Title_IMAGE"),
      HTML("<h3>Using his detective skills he round up 5 suspect</h3>
           <h3>and by using CSAFE evidence explorer he hope to catch the culrpit </h3>"),
      
    )),
  
     tabPanel(
      "Evidence",
      fluidPage(
  titlePanel("Evidence Inspector"),
  sidebarLayout(
    sidebarPanel(
      div(class = "logo",
      radioButtons("alternatives", label = "Select one of the suspects:",
                   choices = c("w0001", "w0002", "w0003","w0004","w0005"),
                   selected = "w0001")
    )),
    mainPanel(
      HTML("<h3>Sample from crime scene</h3>"),
      
     imageOutput("reference_image"),
      HTML("<h3>Sample from the suspect</h3>"),
      imageOutput("display_images"),
     # HTML("<h3>Statistics</h3>"),
  #    imageOutput("display_Data")
    ) ))  ),
  
  tabPanel(
    "CSAFE-Tools I",
    fluidPage(
      HTML("<h3>How CSAFE analys the data</h3>
        <p>CSAFE researcher  develop a tool that can decompose writing into graphs</p>
      <p>That can be used to creat writership profiles</p>"),
      imageOutput("Profile"),
      HTML("<p>The closer the profile is to the crime scene the more likely we have found the correct suspect</p>")
            
      )),
  tabPanel(
    "CSAFE-Tools II",
    fluidPage(
      HTML("<h3>Using extra tools</h3>
        <p>Even the profiles can be hard to read</p>
        <p>That is why we compute the euclidean distance</p>"),
      imageOutput("Final"),
      HTML("<p>The smaller the distance more likely it that we have found the correct suspect</p>")
    ))
  
  )

server <- function(input, output) {
  ## Reference 
  selected_reference <- reactiveValues(ref = "CSAFE Data/w0001_s01_pPHR_r03.png") 
  Corgi <- reactiveValues(ref = "CSAFE Data/CorgiDetective.jpg") 
  Cat <- reactiveValues(ref = "CSAFE Data/TheCatburglar.jpg") 
  Profile <- reactiveValues(ref = "CSAFE Data/Profile.png") 
  Final <- reactiveValues(ref = "CSAFE Data/Final.png") 
  
  selected_alternative <- reactiveValues(alt = NULL)
  selected_alternativeData <- reactiveValues(alt = NULL)
  
  observeEvent(input$alternatives, {
    selected_alternative$alt <- paste0("CSAFE Data/", input$alternatives,"_s01_pPHR_r01", ".png") 
    selected_alternativeData$alt <- paste0("Fake Data/", input$alternatives,"_D", ".jpg") 
    
    output$selected_files <- renderPrint({
      "Print found in the crime Scene:"
    })
  })
  
  # observeEvent(input$alternatives, {
  #   selected_alternative$alt <- paste0("Fake Data/", input$alternatives, ".jpg") 
  #   output$selected_files <- renderPrint({
  #     "Print found in the crime Scene:"
  #   })
  # })
  
  
  output$reference_image <- renderImage({
    list(
      src = selected_reference$ref,
      contentType = 'image/png',
      width = "80%",  # Adjust width here
      height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
 
  output$CAT <- renderImage({
    list(
      src = Cat$ref,
      contentType = 'image/png',
      width = "40%"#,  # Adjust width here
      #  height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
  output$CORGI <- renderImage({
    list(
      src = Corgi$ref,
      contentType = 'image/png',
      width = "40%"#,  # Adjust width here
      #  height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
  
  output$Profile <- renderImage({
    list(
      src = Profile$ref,
      contentType = 'image/png',
      width = "40%"#,  # Adjust width here
      #  height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
  output$Final <- renderImage({
    list(
      src = Final$ref,
      contentType = 'image/png',
      width = "40%"#,  # Adjust width here
      #  height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
  
  output$Title_IMAGE <- renderImage({
    list(
      src = selected_reference$ref,
      contentType = 'image/png',
    width = "80%"#,  # Adjust width here
    #  height = "80%"  # Adjust height here
    )
  }, deleteFile = FALSE) 
  
  output$display_images <- renderImage({
    if (!is.null(selected_alternative$alt)) {
      list(
        src = selected_alternative$alt,
        contentType = 'image/png',
        width = "80%",  # Adjust width here
        height = "80%"  # Adjust height here
      )
    }
  }, deleteFile = FALSE) 
  
  output$display_Data <- renderImage({
    if (!is.null(selected_alternative$alt)) {
      list(
        src = selected_alternativeData$alt,
        contentType = 'image/png',
        width = "30%",  # Adjust width here
        height = "30%"  # Adjust height here
      )
    }
  }, deleteFile = FALSE) 
  
  # Print some text 
  output$selected_reference <- renderPrint({
    paste("Sample from suspect:", input$alternatives)
  })
}
# Run the application
shinyApp(ui = ui, server = server)

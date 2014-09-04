library(shiny)

shinyUI(fluidPage(theme="bootstrap.css",
  navbarPage("CAT",
                   tabPanel("Info",
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("info",label="",choices=c("Uitleg" = "uit", "Copyright" = "copy"))
                                ),
                              mainPanel(htmlOutput("infoMD"))
                            )
                              ),
                   navbarMenu("RUN1",
                              tabPanel("Slider",
                                       sidebarLayout(
                                         sidebarPanel(
                                           # HTML opmaak e.d.
                                           tags$head(
                                             HTML('<body style="background-color: white;">'),
                                              tags$style(type="text/css", "select { color: #001C3D }"),
                                              tags$style(type="text/css", "textarea { max-width: 315px; color: #001C3D}"),
                                             tags$style(type="text/css", ".jslider { max-width: 100%; }"),
                                              tags$style(type="text/css", ".jslider { min-width: 100%; color: #001C3D}"),
                                             tags$style(type="text/css", ".jslider .jslider-label{color: #001C3D ; font-size: 12px;}"),
                                             tags$style(type="text/css", ".jslider .jslider-value{color: #001C3D ; font-weight:bold; font-size: 16px;}"),      
                                             tags$style(type='text/css', ".well { max-width: 340px; }"),
                                              tags$style(type='text/css', ".span4 .well { background-color: white; border-color: #00A2DB}"),
                                              tags$style(type='text/css', ".span12  { color: #001C3D; }"),
                                              tags$style(type='text/css', ".span4  { color: #001C3D; }") ,   
                                             tags$style(type="text/css", "select { max-width: 200px; }"),
                                             tags$style(type="text/css", "textarea { max-width: 185px; }"),
                                             tags$style(type='text/css', ".well { max-width: 310px; }"),
                                             tags$style(type='text/css', ".span4 { max-width: 310px; }")
                                           ),
                                           # Conditie
                                           selectInput("selfr", strong("Conditie"), 
                                                       choices = c("Normaal" = "nor", "Prior Laag" = "priL", "Prior Hoog" = "priH", "Perfect" = "per", "Slecht" = "wor")),
                                           # Opties voor figuur
                                           wellPanel(strong("Populatie Figuur"),
                                                     checkboxInput("PF_cel","Cell",   value = FALSE),
                                                     checkboxInput("PF_cor","Classificatie (X = Fout; V = Goed)",value = FALSE)
                                           ),
                                           # Opties voor tabel
                                           wellPanel(strong("Tabel"), 
                                                     checkboxInput("TA_inv","Invullen",value=FALSE),
                                                     checkboxInput("TA_uit","Uitrekenen"),value=FALSE)
                                           ),
                                           # Plaatje UM

                                           # Uitleg in condional panel
    
                                         mainPanel(
                                           # Opmaakt html
#                                            tags$head(
#                                              tags$style(type="text/css", "li a{color: white;  background-color:#001C3D;}")
#                                            ),
                                           sliderInput("afkap", "",min=0, max=105, value=50, step=5,animate=TRUE),
                                           plotOutput("basefig",height = "250px"),
                                           fluidRow(
                                             column(4,plotOutput("tabfig",height = "250px")),
                                             column(4,plotOutput("sens_form",height = "250px")),
                                             column(4,plotOutput("ROC",height = "250px"))
                                           )
                                         )
                                       )
                              ),
                              tabPanel("Calculator",
                                       sidebarLayout(
                                         sidebarPanel(
                                           numericInput("cell_A", "Echt positieven", 0),
                                           numericInput("cell_B", "Foutpositief", 0),
                                           numericInput("cell_C", "Foutnegatief", 0),
                                           numericInput("cell_D", "Echt negatieven", 0),
                                           checkboxInput("calc_uit","Uitrekenen",value=FALSE),
                                           conditionalPanel(condition = paste("input.calc_uit == true"),
                                                            checkboxInput("calc_ci","Betrouwbaarheids interval",value=FALSE)
                                                            )                                           
                                           ),
                                         mainPanel(
                                           fluidRow(
                                             column(6,plotOutput("calcTab",height = "250px")),
                                             column(6,plotOutput("calc_form",height = "250px"))
                                           )
                                           )
                                       )
                   )
                   )
)
))
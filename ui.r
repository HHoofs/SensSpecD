library(shiny)



shinyUI(
  navbarPage("CAT",theme="bootstrap.css",
             tabPanel("Info",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("info",label="",choices=c("Uitleg" = "uit", "Copyright" = "copy")),
                          HTML("<b>Taal</b> <br>"),
                          HTML('<a href="https://github.com/HHoofs/SensSpecD" target="_blank"><img src="http://i.imgur.com/2kXCO4c.png" height= "60px" width="60px"></a>'),
                          HTML("     "),
                          HTML('<a href="https://github.com/HHoofs/SensSpecE" target="_blank"><img src="http://i.imgur.com/ZZTSkN9.png" height= "60px" width="60px"></a>'),
                          br(),br(),
                          HTML('<a href="http://www.maastrichtuniversity.nl/" target="_blank"><img src="logo.jpg" alt="Maastricht University"  border="0" style="border: #00A2DB solid 1px; border-radius: 5px;"/></a>')
                          
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
                                       tags$style(type="text/css", ".jslider { max-width: 99%; }"),
                                       tags$style(type="text/css", ".jslider { min-width: 99%; color: #001C3D}"),
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
                                                 choices = c("Normaal" = "nor", "Prior Laag" = "priL", "Prior Hoog" = "priH", "Perfect" = "per", "Slecht" = "wor", "Diffuus" = "diff")),
                                     # Opties voor figuur
                                     wellPanel(strong("Populatie Figuur"),
                                               checkboxInput("PF_cel","Cell",   value = FALSE),
                                               checkboxInput("PF_cor","Classificatie (X = Fout; V = Goed)",value = FALSE)
                                     ),
                                     # Opties voor tabel
                                     wellPanel(strong("Tabel"), 
                                               checkboxInput("TA_inv","Invullen",value=FALSE),
                                               checkboxInput("TA_uit","Uitrekenen"),value=FALSE),
                                     checkboxInput("expl",strong("Uitleg")),
                                     conditionalPanel(condition = paste("input.expl == true"),
                                                      "Voor een bepaalde ziekte zijn 21 personen gescreend met een nieuw instrument. De scores lopen van 0 t/m 105, waarbij een hogere score staat voor een grotere kans op de ziekte. In werkelijkheid hebben de groene personen de ziekte niet, en de rode personen wel. Het afkappunt kan (boven de figuur) worden verschoven om zodoende te kijken welke gevolgen dit heeft voor de sensitiviteit, specificiteit, NPV, en PPV. De optie Cell onder Figuur geeft de locatie van ieder persoon in de 2x2 tabel aan. De optie Classificatie toont aan of met het desbetreffende afkappunt een persoon juist of onjuist is geclassificeerd (X = Fout; V = Goed). De opties Invullen en Uitrekenen onder Tabel, tonen, respectievelijk, de aantallen in de 2x2 tabel en de bijbehorende sensitiviteit, specificiteit, NPV, en PPV waardes. De figuur rechtsonder geeft de ROC curve weer, waarbij de sensitiviteit en specificiteit van het gekozen afkappunt zijn omcirkeld. Bij condities kunnen verschillende situaties worden gekozen m.b.t. de prior kans van de ziekte en de kwaliteit van het instrument.")
                                     
                                   ),
                                   
                                   mainPanel(
                                     sliderInput("afkap", "",min=0, max=105, value=50, step=5,animate=TRUE),
                                     plotOutput("basefig",height = "250px", width="99%"),
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
                                     wellPanel(
                                     numericInput("cell_A", HTML("Echt positieven <b>(A)</b>"), 1,min=0),
                                     numericInput("cell_B", HTML("Foutpositief <b>(B)</b>"), 1,min=0),
                                     numericInput("cell_C", HTML("Foutnegatief <b>(C)</b>"), 1,min=0),
                                     numericInput("cell_D", HTML("Echt negatieven <b>(D)</b>"), 1,min=0)
                                     ),
                                     wellPanel(
                                     checkboxInput("calc_uit",strong("Uitrekenen"),value=FALSE),
                                     conditionalPanel(condition = paste("input.calc_uit == true"),
                                                      numericInput("dec","Decimalen",2,min=1,max=5),
                                                      checkboxInput("calc_ci","Betrouwbaarheids interval (%)",value=FALSE),
                                                      conditionalPanel(condition = paste("input.calc_ci == true"),           
                                                                       numericInput("calc_cib", "",value=95,min=0,max=100)
                                                      )
                                     )),
                                     checkboxInput("expl_calc",strong("Uitleg")),
                                     conditionalPanel(condition = paste("input.expl_calc == true"),
                                                      "De cellen van de 2x2 tabel kunnen worden ingevoerd om vervolgens de specificiteit, sensitiviteit, negatief voorspellende waarde (npv), en positief voorspellende waarde (ppv) te berekenen. Daarnaast kan het aantal decimalen van deze waardes worden gekozen en de breedte van het betrouwbaarheidsinterval.")
                                     
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
             
  ))

library(shiny)
ui <- pageWithSidebar(
  # Application title
  headerPanel("Home Loan EMI Calculator"),
  # Sidebar with a slider input
  sidebarPanel(
    ## Slider input to provide principal amount value
    sliderInput("home_loan_amount", label = h6("Home Loan Amount"),min = 0, max = 1000000, value = 10000),
    ## Slider input to provide interest rate value
    sliderInput("home_loan_interest", label = h6("Home Loan Interest(Yearly)"),min = 0.5, max = 40, value = 1),
    ## Slider input to provide home tenure value
    sliderInput("home_loan_tenure", label = h6("Home Loan Tenure(In Years)"),min = 1, max = 40, value = 1)
    ),
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      ## Display EMI value in main panel- EMI details tab
      tabPanel("EMI Details", textOutput("emi_value")), 
      ## Display Amortization schedule in main panel tab
      tabPanel("Amortization schedule", tableOutput("amortize_table")), 
      ## Display Components Summary in main panel tab
      tabPanel("Principal payment Summary", plotOutput("Output_pie_chart")),
      tabPanel("User Documentation", textOutput("User_Documentation"))      
    )
  )
)
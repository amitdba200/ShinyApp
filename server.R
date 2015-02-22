library(shiny)
library(ggplot2)
options(digits=10)

shinyServer(function(input, output, session) {
  ## Code to calculate EMI value for EMI tab
  output$emi_value <- renderText({ 
    home_loan_interest_t<-input$home_loan_interest/1200
    home_loan_tenure_t<-input$home_loan_tenure*12
    a<-input$home_loan_amount*home_loan_interest_t
    b<-(1+home_loan_interest_t)^home_loan_tenure_t
    emi_value<-(a*b)/(b-1)
    ## print EMI value
    emi_value
  })
  ## Code to calculate amortization schedule for the home loan
  output$amortize_table <- renderTable({ 
    balance <- input$home_loan_amount
    loan_periods <-input$home_loan_tenure*12
    monthlyRate = input$home_loan_interest/1200
    a<-input$home_loan_amount*monthlyRate
    b<-(1+monthlyRate)^loan_periods
    monthlyPayment<-(a*b)/(b-1)
    interestForMonth<-balance * monthlyRate;
    principalForMonth <- monthlyPayment - interestForMonth;
    balance_post_payment<- balance- principalForMonth; 
    month_count<-1
    out_table<-matrix(c(month_count,balance,monthlyPayment,interestForMonth,principalForMonth,balance_post_payment),ncol=6,byrow=TRUE)
    out_table <- as.data.frame(out_table)
    balance<-balance_post_payment

    for (month_count in 2:loan_periods) 
      {
      interestForMonth<-balance * monthlyRate;
      principalForMonth <- monthlyPayment - interestForMonth;
      balance_post_payment<- balance- principalForMonth; 
      out_table<-rbind(out_table,c(month_count,balance,monthlyPayment,interestForMonth,principalForMonth,balance_post_payment))
      balance<-balance_post_payment
      }
    colnames(out_table)<-c("Month_Count","Beginning Balance","EMI_Payment","Interest_Paid","Principal_Paid","Balance")
    out_table
  })
  ## Code to plot amounts of principal payment part in EMI
  output$Output_pie_chart <- renderPlot({ 
    balance <- input$home_loan_amount
    loan_periods <-input$home_loan_tenure*12
    monthlyRate = input$home_loan_interest/12
    a<-input$home_loan_amount*monthlyRate
    b<-(1+monthlyRate/100)^loan_periods
    monthlyPayment<-(a*b)/(b-1)    
    interestForMonth<-balance * monthlyRate/100;
    principalForMonth <- monthlyPayment - interestForMonth;
    balance_post_payment<- balance- principalForMonth; 
    month_count<-1
    out_table<-matrix(c(month_count,balance,monthlyPayment,interestForMonth,principalForMonth,balance_post_payment),ncol=6,byrow=TRUE)
    out_table <- as.data.frame(out_table)
    balance<-balance_post_payment
    
    for (Month_Count in 2:loan_periods) 
    {
      interestForMonth<-balance * monthlyRate/100;
      principalForMonth <- monthlyPayment - interestForMonth;
      balance_post_payment<- balance- principalForMonth; 
      out_table<-rbind(out_table,c(Month_Count,balance,monthlyPayment,interestForMonth,principalForMonth,balance_post_payment))
      balance<-balance_post_payment
    }
    colnames(out_table)<-c("Month_No","Beginning Balance","EMI_Payment","Interest_Paid","Principal_Paid","Balance")
    qplot(Month_No, Principal_Paid, data=out_table,geom="line")
   ## plot(out_table$Principal_Paid)
  })
  
  ## Code to calculate EMI value for EMI tab
  output$User_Documentation <- renderText({ 
  manual<-"With 3 useful tabs and instant results, this Home loan EMI calculator is easy to use, intuitive to understand and is quick to perform."        
  manual<-paste(manual,"You can calculate EMI for home loan fully amortizing loan using this tool.")
  manual<-paste(manual,"Use Slider bars to change following information in the EMI calculator:")
  manual<-paste(manual,"Principal loan amount you wish to avail Loan term (years) Rate of interest (yearly percentage)")
  manual<-paste(manual,"Use the slider to adjust the values in the EMI calculator form.") 
  manual<-paste(manual,"I have tried to keep highest precision values in these slider.")        
  manual<-paste(manual,"As soon as the values are changed using the slider , Home loan EMI calculator will re-calculate your monthly payment (EMI) amount,Amortization schedule and installment pattern.")
  manual
    
  })
  
}
)
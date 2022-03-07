library(shiny)
library(shinydashboard)
library(DT)
library(jsonlite)
library(httr)
library(dplyr)

ui <- dashboardPage(
  dashboardHeader(title = p(icon('leaf'),"AGRIME")),
  dashboardSidebar(
    sidebarMenu(
      menuItem('User',icon = icon('user'),tabName = 'user'),
      menuItem('Market',icon = icon('money'),tabName = 'market'),
      menuItem('School',icon = icon('school'),tabName = 'school'),
      menuItem('Group',icon = icon('users'),tabName = 'group')
    )),
  dashboardBody(
    tags$body(tags$style('h4 {text-align:center}')),
    tabItems(
      tabItem(tabName = 'user',
              fluidRow(
                column(12,
                  tabsetPanel(
                    tabPanel('Create User',
                             fluidRow(
                               column(12,box(width = 500,height = 530,
                                             tags$br(),
                                             fluidRow(
                                               column(5,offset = 3,
                                                      box(width = 200,height = 450,background = 'aqua',
                                                          tags$hr(),
                                                          fluidRow(column(7,offset = 3,textInput('name','name',placeholder = 'enter name here',width = 200))),
                                                          fluidRow(column(7,offset = 3,textInput('phone','phone number',placeholder = 'enter phone number here',width = 200))),
                                                          fluidRow(column(7,offset = 3,textInput('email','email',placeholder =  'enter email here',width = 200))),
                                                          fluidRow(column(7,offset = 3,passwordInput('password','password',placeholder = 'enter password here',width = 200))),
                                                          fluidRow(column(4,offset = 4,submitButton('set',icon = icon('leaf'))))))
                                             )))
                             )),
                    tabPanel('User',
                             fluidRow(
                               column(12,
                                      box(width = 500,height = 530,
                                          tags$br(),
                                          fluidRow(
                                            column(6),
                                            column(3,textInput('Lname',label = NULL,placeholder = 'name')),
                                            column(3,submitButton('search',icon = icon('search')))),
                                          tags$hr(),
                                          fluidRow(
                                            column(3,
                                                   tags$hr(),
                                                   box(width = 200,height = 300,title = 'Bank Balance',status = 'info',solidHeader = T,
                                                       tags$br(),
                                                       fluidRow(column(12,numericInput('inflow','inflow',value = 0))),
                                                       fluidRow(column(12,numericInput('outflow','outflow',value = 0))),
                                                       fluidRow(column(3),column(4,submitButton('transact',icon = icon('money'))),column(4)))),
                                            column(3,box(width = 200,height = 400,status = 'info',solidHeader = T,
                                                         fluidRow(column(12,h4(textOutput('profile_name')))),
                                                         tags$br(),
                                                         tags$hr(),
                                                         fluidRow(column(12,textOutput('profile_phone'))),
                                                         tags$hr(),
                                                         fluidRow(column(12,textOutput('profile_email'))),
                                                         tags$hr(),
                                                         fluidRow(column(12,textOutput('profile_balance'))))),
                                            column(6,box(width = 200,height = 400,solidHeader = T,status = 'info',
                                                         tabsetPanel(
                                                           tabPanel('Create Shop',
                                                                    tags$br(),
                                                                    fluidRow(column(12,p(icon('coins'),'Have a shop at 2000 only'))),
                                                                    tags$hr(),
                                                                    fluidRow(
                                                                      column(8,
                                                                             fluidRow(column(12,textInput('name_shop',label = NULL,placeholder = 'Shop Name'))),
                                                                             fluidRow(column(12,textAreaInput('shop_description',label = NULL,height = '55px',resize = 'none',placeholder = 'Shop Description'))),
                                                                             fluidRow(column(12,textInput('shop_location',label = NULL,placeholder = 'Shop Location'))),
                                                                             fluidRow(column(12,textInput('shop_contact',label = NULL,placeholder = 'Shop Contact')))),
                                                                      column(4,
                                                                             box(height = 200,width = 200,background = 'aqua',
                                                                                 tags$br(),
                                                                                 tags$br(),
                                                                                 tags$br(),
                                                                                 fluidRow(column(1),column(6,submitButton('Pay',icon = icon('money'))),column(3))))
                                                                    )),
                                                           tabPanel('Create School',
                                                                    tags$br(),
                                                                    fluidRow(column(12,p(icon('coins'),'Have a school at 2500 only'))),
                                                                    tags$hr(),
                                                                    fluidRow(
                                                                      column(8,
                                                                             fluidRow(column(12,textInput('school_name',label = NULL,placeholder = 'School Name'))),
                                                                             fluidRow(column(12,textAreaInput('school_description',label = NULL,height = '100px',resize = 'none',placeholder = 'School Description'))),
                                                                             fluidRow(column(12,textInput('school_contact',label = NULL,placeholder = 'School Contact')))
                                                                             ),
                                                                      column(4,
                                                                             box(height = 200,width = 200,background = 'aqua',
                                                                                 tags$br(),
                                                                                 tags$br(),
                                                                                 tags$br(),
                                                                                 fluidRow(column(1),column(6,submitButton('Pay',icon = icon('money'))),column(3)))))),
                                                           tabPanel('Create group',
                                                                    tags$br(),
                                                                    fluidRow(column(12,p(icon('coins'),'Free to have'))),
                                                                    tags$hr(),
                                                                    fluidRow(
                                                                      column(12,
                                                                             fluidRow(column(12,textInput('group_name',label = NULL,placeholder = 'Group Name'))),
                                                                             fluidRow(column(12,textAreaInput('group_description',label = NULL,height = '70px',resize = 'none',placeholder = 'Group Description'))),
                                                                             fluidRow(column(12,textInput('group_contact',label = NULL,placeholder = 'Group contact'))),
                                                                             fluidRow(column(5),column(6,submitButton('make',icon = icon('hammer'))),column(1)))
                                                                    ))
                                                         ))))))
                             )),
                    tabPanel('All Users',
                             fluidRow(
                               column(12,box(width = 500,height = 530,
                                             tags$br(),
                                             fluidRow(
                                               column(12,DT::dataTableOutput('dt'))
                                             )))
                             ))
                    )
                )
              )),
      tabItem(tabName = 'market',
              tabsetPanel(
                tabPanel('My Shop',
                         fluidRow(
                           column(12,box(width = 500,height = 530,
                                         fluidRow(
                                           column(3),
                                           column(6,
                                                  box(width = 200,height = 500,status = 'info',solidHeader = T,
                                                      tags$br(),
                                                      fluidRow(column(7,offset = 3,textInput('my_shop_name',placeholder  ='enter shop name',label = 'Shop Name'))),
                                                      fluidRow(column(7,offset = 3,textInput('my_shop_product',placeholder  = 'enter product',label = 'Shop Product'))),
                                                      fluidRow(column(7,offset = 3,textInput('my_shop_product_price',placeholder = 'enter price',label = 'Product Price'))),
                                                      fluidRow(column(7,offset = 3,textAreaInput('my_shop_product_description',resize = 'none',placeholder = 'enter product description',label = 'Product Description'))),
                                                      fluidRow(column(4),column(6,submitButton('Add Product',icon = icon('plus'))),column(1)))),
                                           column(2)
                                         )))
                         )),
                tabPanel('Marketplace',
                         fluidRow(
                           column(12,box(width = 500,height = 530,
                                         fluidRow(
                                           column(12,
                                                  tabBox(width = 450,height = 480,title = 'welcome',side = 'right',
                                                      tabPanel('Enter Shop',
                                                               fluidRow(
                                                                 column(12,
                                                                        box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                            fluidRow(column(12,DT::dataTableOutput('enter_shop_dt')))))
                                                               )),
                                                      tabPanel('All Shops',
                                                               fluidRow(
                                                                 column(12,
                                                                        box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                            fluidRow(column(12,DT::dataTableOutput('all_shop_dt')))))
                                                               ))
                                                  ))
                                         )
                                         ))
                         ))
              )),
      tabItem(tabName = 'school',
              tabsetPanel(
                tabPanel('Create Topic',
                         fluidRow(
                           column(12,box(width = 500,height = 530,
                                         fluidRow(
                                           column(3),
                                           column(6,
                                                  box(width = 200,height = 500,status = 'info',solidHeader = T,
                                                      tags$br(),
                                                      fluidRow(column(7,offset = 3,textInput('slct',label = 'School',placeholder = 'enter school'))),
                                                      fluidRow(column(7,offset = 3,textInput('topic_name',label = 'Topic',placeholder = 'create topic'))),
                                                      fluidRow(column(7,offset = 3,textAreaInput('topic_description',label = 'Description',height = '120px',resize = 'none',placeholder = 'create content'))),
                                                      fluidRow(column(4),column(6,submitButton('Add Topic',icon = icon('plus'))),column(1)))),
                                           column(2)
                                         )))
                         )),
                tabPanel('Schools',
                         fluidRow(
                           column(12,box(width = 500,height = 530,
                                         fluidRow(
                                           column(12,tabBox(width = 450,height = 480,title = 'welcome',side = 'right',
                                                            tabPanel('Enter School',
                                                                     fluidRow(
                                                                       column(12,
                                                                              box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                                  fluidRow(column(12,DT::dataTableOutput('enter_school_dt')))))
                                                                     )),
                                                            tabPanel('All Schools',
                                                                     fluidRow(
                                                                       column(12,
                                                                              box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                                  fluidRow(column(12,DT::dataTableOutput('all_school_dt')))))
                                                                     ))))
                                         )))
                         ))
              )),
      tabItem(tabName = 'group',
              tabsetPanel(
                tabPanel('Create Discussion',
                         fluidRow(
                           column(12,
                                  box(width = 500,height = 530,
                                    fluidRow(
                                        column(3),
                                        column(6,box(width = 200,height = 500,status = 'info',solidHeader = T,
                                            tags$br(),
                                            fluidRow(column(7,offset = 3,textInput('discussion_creator',label = 'Creator',placeholder = 'Who is creating ?'))),
                                            fluidRow(column(7,offset = 3,dateInput('discussion_date',label = 'Date Created'))),
                                            fluidRow(column(7,offset = 3,textAreaInput('discussion_content',label = 'Discussion',placeholder = 'Create Discussion',resize = 'none',height = '100px'))),
                                            fluidRow(column(4),column(6,submitButton('Add Discussion',icon = icon('plus'))),column(1)))),
                                        column(2)
                         ))))),
                tabPanel('Groups',
                         fluidRow(
                           column(12,box(width = 500,height = 530,
                                         fluidRow(
                                           column(12,tabBox(width = 450,height = 480,title = 'welcome',side = 'right',
                                                            tabPanel('Enter group',
                                                                     fluidRow(
                                                                       column(12,
                                                                              box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                                  fluidRow(column(12,DT::dataTableOutput('enter_group_dt')))))
                                                                     )
                                                              
                                                            ),
                                                            tabPanel('All Groups',
                                                                     fluidRow(
                                                                       column(12,
                                                                              box(width = 430,height = 420,status = 'info',solidHeader = T,
                                                                                  fluidRow(column(12,DT::dataTableOutput('all_groups_dt')))))
                                                                     ))))
                                         )))
                         ))
              ))
    )
  )
)

server <- shinyServer(function(input,output){
  
  create_discussion <- reactive({
    
    POST('https://qne10u.deta.dev/create_discussion/',body = list(creator = input$discussion_creator,date = input$discussion_date,discussion = input$discussion_content),encode = 'form')
    
  })
  
  all_discussions <- reactive({
    
    url <- 'https://qne10u.deta.dev/get_discussions/'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Creator','Date','Discussion','Key')
    ddf1
    
  })
  
  output$enter_group_dt <- DT::renderDataTable({
    
    create_discussion()
    select(all_discussions(),'Creator','Date','Discussion')
    
  })
  
  create_group <- reactive({
    
    POST('https://qne10u.deta.dev/create_group/',body = list(name = input$group_name,description = input$group_description,contact = input$group_contact),encode = 'form')
    
  })
  
  all_groups <- reactive({
    
    url = 'https://qne10u.deta.dev/get_groups'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Contact','Description','Name','Key')
    ddf1
    
  })
  
  output$all_groups_dt <- DT::renderDataTable({
    select(all_groups(),'Name','Description','Contact')
    
  })
  
  create_topic <- reactive({
    
    POST('https://qne10u.deta.dev/create_topic/',body = list(school = input$slct,topic = input$topic_name,description = input$topic_description),encode = 'form')
    
  })
  
  all_topics <- reactive({
    
    url = 'https://qne10u.deta.dev/get_topics'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Description','School','Topic','Key')
    ddf1
    
  })
  
  output$enter_school_dt <- DT::renderDataTable({
    
    create_topic()
    select(all_topics(),'School','Topic','Description')
    
  })
  
  create_school <- reactive({
    
    POST('https://qne10u.deta.dev/create_school/',body = list(school = input$school_name,description = input$school_description,contact = input$school_contact),encode = 'form')
    
  })
  
  all_schools <- reactive({
    
    url = 'https://qne10u.deta.dev/get_schools'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Contact','Description','School','Keys')
    ddf1
    
  })
  
  output$all_school_dt <- DT::renderDataTable({
    select(all_schools(),'School','Description','Contact')
    
  })
  
  
  
  product_create <- reactive({
    
    POST('https://qne10u.deta.dev/create_product/',body = list(shop = input$my_shop_name,product = input$my_shop_product,price = input$my_shop_product_price,description = input$my_shop_product_description),encode = 'form')
    
  })
  
  all_shops <- reactive({
    
    url = 'https://qne10u.deta.dev/get_shops'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Contact','Description','Location','Shop','Key')
    ddf1
    
  })
  
  all_products <- reactive({
    
    url = 'https://qne10u.deta.dev/get_products'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('Description','Price','Product','Shop','Key')
    ddf1
    
  })
  
  output$enter_shop_dt <- DT::renderDataTable({
    product_create()
    select(all_products(),'Shop','Product','Price','Description')
    
  })
  
  output$all_shop_dt <- DT::renderDataTable({
    
    df <- select(all_shops(),'Shop','Description','Location','Contact')
    df
    
  })

  create_shop <- reactive({
    
    POST('https://qne10u.deta.dev/create_shop',body = list(shop = input$name_shop,description = input$shop_description,location = input$shop_location,contact = input$shop_contact),encode = 'form')
    
  })
  
  
  post_data <- reactive({
    
    POST('https://qne10u.deta.dev/create_user',body = list(name = input$name,phone = input$phone,email = input$email,password = input$password),encode = 'form')
    
  })

  
  users <- reactive({
    
    url = 'https://qne10u.deta.dev/get_users'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('email','name','password','phone','key')
    ddf1
    
  })
  
  output$dt <- DT::renderDataTable({
    post_data()
    users()[,c('name','phone','email')]
    
  })
  

  bank_transactions_in <- reactive({
    
    POST('https://qne10u.deta.dev/post_inflow',body = list(name = input$Lname,amount = input$inflow),encode = 'form')
    
  })
  
  bank_transactions_out <- reactive({
    
    POST('https://qne10u.deta.dev/post_outflow',body = list(name = input$Lname,amount = input$outflow),encode = 'form')
    
  })
  
  output$profile_name <- renderText({
    
    if (is.null(input$Lname)){
      text0 <- 'profile'
    }else{
      text0 <- paste(input$Lname,'profile')
    }
    
    text0
    
  })
  
  output$profile_phone <- renderText({
    
    if (is.null(input$Lname)){
      text1 <- 'phone'
    }else{
      text1 <- paste('Phone Number : ',select(filter(users(),name == input$Lname),phone)[,1])
      
    }
    
    text1
    
  })
  
  output$profile_email <- renderText({
    
    if (is.null(input$Lname)){
      text2 <- 'email'
    }else{
      text2 <- paste('Email : ',select(filter(users(),name == input$Lname),email)[,1])
      
    }
    
    text2
    
  })
  
  
  balance <- reactive({
    
    bank_transactions_in()
    bank_transactions_out()
    
    url <- 'https://qne10u.deta.dev/get_inflow'
    df <- fromJSON(url)
    ddf1 <- as.data.frame(df[3])
    colnames(ddf1) <- c('inflow','key','name')
    
    url2 <- 'https://qne10u.deta.dev/get_outflow'
    df2 <- fromJSON(url2)
    ddf12 <- as.data.frame(df2[3])
    colnames(ddf12) <- c('outflow','key','name')
    
    inflow <- sum(select(filter(ddf1,name == input$Lname),inflow))
    outflow <- sum(select(filter(ddf12,name == input$Lname),outflow))
    
    bal <- inflow - outflow
    
    create_shop()
    create_school()
    create_group()
    
    bal <- as.character(bal)
    bal
    
  })
  
  output$profile_balance <- renderText({
  
    
    if (is.null(input$Lname == T)){
      text2 <- 'balance'
    }else{
      

      text2 <- paste('Balance',balance())
    }
    
    text2
    
  })
  
})

shinyApp(ui,server)
const express = require('express')
const app = express()
const port = 8080 
const cors = require('cors')
const bodyParser = require('body-parser')

const mongoose = require('mongoose')
mongoose.connect("mongodb+srv://sushant:sushant123@cluster0.q3jlgms.mongodb.net/?retryWrites=true&w=majority",{ useNewUrlParser: true, useUnifiedTopology: true })


app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use('/',require('./routes/user.route'))
app.use('/',require('./routes/query.route'))
app.listen(port,()=>{
    console.log('port running on '+port)
})
const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    email:String,
    query:String,
    category:String,
    comment:[
        {
            type:mongoose.Schema.Types.ObjectId, ref:'Answer'
        }
    ]
},{
    timestamps: true
})

module.exports = mongoose.model('Query',newSchema)
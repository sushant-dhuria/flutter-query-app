

const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    comment:{
        type:String,
        required:"this filed is required"
    },
    queryid: {
        type:String
    },
    email:{
       type :String
       },
       upvotes: { type: Number,
         default: 0
         },
       upvotedBy: [String]
},{
    timestamps: true
    
})

module.exports = mongoose.model('Comment',newSchema)
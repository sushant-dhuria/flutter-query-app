const express = require('express')
const Query = require('../models/query.model')
const router = express.Router()
const Comment=require("../models/comment.model")

router.post('/query',(req,res)=>{
 
                const user = Query({
                    name:req.body.name,
                    query:req.body.query,
                    category:req.body.category
                })
                user.save()
                .then((err)=>{
                    if(err){
                        console.log(err)
                        res.json(err)
                    }else{
                        console.log(user)
                        res.json(user)
                    }
                    
                })
            }
    )


router.get('/queriesml', (req, res) => {
    Query.find({category:"Machine Learning"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })
 router.get('/queriesdsa', (req, res) => {
    Query.find({category:"DSA"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })
 router.get('/queriesothers', (req, res) => {
    Query.find({category:"Others"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })
 router.get('/queriesweb', (req, res) => {
    Query.find({category:"Web Development"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })
 router.get('/queriesandroid', (req, res) => {
    Query.find({category:"Android Development"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })
 router.get('/queriessystem', (req, res) => {
    Query.find({category:"System Design"}, (err, q) => {
        if (err) {
            res.send(err);
        } else {
            res.send(q);
        }
    })
 })

 router.post('/queries/:queryid/comments', async (req, res) => {
    const comment = new Comment({
      comment: req.body.comment,
     queryid : req.params.queryid,
     email:req.body.email
      // other fields
    });
  
    try {
      const newComment = await comment.save();
      res.status(201).json(newComment);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  });

  router.get('/queries/:queryid/comments', async (req, res) => {

    try {
      const comments = await Comment.find({ queryid: req.params.queryid });
      res.json(comments);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  });

  module.exports = router

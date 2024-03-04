import express from "express"
import {db} from "../connect.js"
const router = express.Router()

router.get("/",(req,res)=>{
    const q = "SELECT * FROM subcategories"
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})


router.post("/",(req,res)=>{
    const values = [
        req.body.subcategoryName
    ]
    const q = "INSERT INTO subcategories (`subcategoryName`) VALUES (?)"
    db.query(q,[values],(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})


router.delete("/:id",(req,res)=>{
    const id = req.params.id
    const q = "DELETE FROM subcategories WHERE id = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})
export default router

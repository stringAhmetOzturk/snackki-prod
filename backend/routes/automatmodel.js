import express from "express"
import {db} from "../connect.js"
const router = express.Router()

router.get("/",(req,res)=>{
    const q = "SELECT automatmodels.id,automatmodels.automatBrand,automatmodels.automatModelName,automatbrands.brandName AS brandName FROM automatmodels INNER JOIN automatbrands ON automatbrands.id = automatmodels.automatBrand"
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
        req.body.automatModelName,
        req.body.automatBrand
    ]
    const q = "INSERT INTO automatmodels (`automatModelName`,`automatBrand`) VALUES (?)"
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
    const q = "DELETE FROM automatmodels WHERE id = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})
export default router
import express from "express"
import {db} from "../connect.js"
import { verifyJWT } from "../middleware/verifyJWT.js"
const router = express.Router()

router.get("/",(req,res)=>{
    const q = "SELECT products.*,categories.categoryName AS category , subcategories.subcategoryName AS sub_category FROM products INNER JOIN foryou ON products.id = foryou.productId INNER JOIN categories ON categories.id = products.category INNER JOIN subcategories ON subcategories.id = products.sub_category"
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.delete("/:id",verifyJWT,(req,res)=>{
    const id = req.params.id
    const q = "DELETE FROM foryou WHERE productId = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.post("/:id",verifyJWT,(req,res)=>{
    const productId = req.params.id
    const q = "INSERT INTO foryou (`productId`) VALUES (?)"
    db.query(q,productId,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

export default router
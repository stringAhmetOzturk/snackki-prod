import express from "express"
import {db} from "../connect.js"
import { verifyJWT } from "../middleware/verifyJWT.js"
const router = express.Router()

router.get("/",verifyJWT,(req,res)=>{
    const q = "SELECT orders.*,users.name,users.surname FROM orders INNER JOIN users ON orders.userId = users.userId ORDER BY orders.id"
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})
router.get("/:id",verifyJWT,(req,res)=>{
    const id = req.params.id
    const q = "SELECT *,orders.id AS id FROM orders INNER JOIN users ON orders.userId = users.userId INNER JOIN products ON FIND_IN_SET(products.id, orders.productId) WHERE orders.id = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.delete("/:id",verifyJWT,(req,res)=>{
    const productId = req.params.id
    const q = "DELETE FROM orders WHERE id = ?"
    db.query(q,productId,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.post("/",(req,res)=>{
    const q = "INSERT INTO orders (`userId`,`orderId`,`productId`,`productAmount`,`orderDate`,`paymentName`) VALUES (?,?,?,?,?,?)"
    const values = [
        req.body.userId,
        req.body.orderId,
        req.body.productId,
        req.body.productAmount,
        req.body.orderDate,
        req.body.paymentName
    ]
    db.query(q,values,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

export default router
import express from "express"
import {db} from "../connect.js"
const router = express.Router()

router.get("/",(req,res)=>{
    const q = "SELECT userautomats.*,periods.periodName,automatfilters.filterName,users.name,users.surname FROM userautomats INNER JOIN users ON users.userId = userautomats.userId  INNER JOIN automatfilters ON userautomats.automatFilterId = automatfilters.id INNER JOIN periods ON periods.id = userautomats.periodId "
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.put("/:id",(req,res)=>{
    const id = req.params.id;
    const q = "SELECT periods.periodName FROM userautomats INNER JOIN periods ON periods.id = userautomats.periodId WHERE userautomats.id = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            const periodName = data[0].periodName;
            const q = `UPDATE userautomats SET filterchangedDate = DATE_ADD(filterchangedDate, INTERVAL ${periodName}) WHERE id = ?`;
            db.query(q,id,(error,data)=>{
                if (error) {
                    return res.json(error);
                } else {
                    return res.json(data);
                }
            });
        }
    })
});




export default router
import express from "express"
import {db} from "../connect.js"
const router = express.Router()
import multer from "multer"
router.get("/",(req,res)=>{
    const q = "SELECT automats.*,userautomats.filterChangedDate,users.name,users.surname,users.userId,automatmodels.automatModelName,automatbrands.brandName,automatfilters.filterName,periods.periodName FROM automats LEFT JOIN userautomats ON userautomats.automatId = automats.id LEFT JOIN users ON users.userId = userautomats.userId LEFT JOIN periods ON periods.id = userautomats.periodId LEFT JOIN automatfilters ON automatfilters.id = userautomats.automatFilterId INNER JOIN automatbrands ON automatbrands.id = automats.automatBrandId INNER JOIN automatmodels ON automatmodels.id = automats.automatModelId"
        db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})
//get free automats
router.get("/free",(req,res)=>{
    const q = "SELECT automatbrands.brandName,automatmodels.automatModelName,automats.id,automats.automatSeriNo FROM automats INNER JOIN automatbrands ON automatbrands.id = automats.automatBrandId INNER JOIN automatmodels ON automatmodels.id = automats.automatModelId WHERE isRented = 'Depoda' ";
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.get("/:id",(req,res)=>{

    const id = req.params.id
    const q = "SELECT automats.*,userautomats.filterChangedDate,users.name,users.surname,users.userId,automatmodels.automatModelName,automatbrands.brandName,automatfilters.filterName,periods.periodName,periods.id AS periodId,automatfilters.id AS filterId FROM automats LEFT JOIN userautomats ON userautomats.automatId = automats.id LEFT JOIN users ON users.userId = userautomats.userId LEFT JOIN periods ON periods.id = userautomats.periodId LEFT JOIN automatfilters ON automatfilters.id = userautomats.automatFilterId INNER JOIN automatbrands ON automatbrands.id = automats.automatBrandId INNER JOIN automatmodels ON automatmodels.id = automats.automatModelId WHERE automats.id= ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})
// img storage confing
var documentConfig = multer.diskStorage({
    destination:(req,file,callback)=>{
        callback(null,"./uploads/automatDocuments");
    },
    filename:(req,file,callback)=>{
        callback(null,`automat-${Date.now()}-${file.originalname}`)
    }
});


// img filter
const isDocument = (req,file,callback)=>{
    if(file.mimetype.startsWith("automatDocument")){
        callback(null,true)
    }else{
        callback(null,Error("only file is allowd"))
    }
}

var upload = multer({
    storage:documentConfig,
    fileFilter:isDocument
})

router.post("/", upload.single("automatDocument"), (req,res) => {


    const {filename} = req.file || {};
    const q = "INSERT INTO automats (`automatBrandId`,`automatModelId`,`automatSeriNo`,`automatDocument`,`isBuy`,`isRented`) VALUES (?)"

    const values = [
        req.body.automatBrandId,
        req.body.automatModelId,
        req.body.automatSeriNo,

        filename,
        req.body.isBuy,
        req.body.isRented
    ];
    db.query(q, [values], (error, data) => {
        if (error) {
            return res.json(error);
        } else {
            const automatId = data.insertId
            const values = [
                req.body.userId,
                automatId,
                req.body.automatFilterId,
                req.body.periodId,
                req.body.filterChangedDate
            ]
            const userQ = "INSERT INTO userautomats (`userId`,`automatId`,`automatFilterId`,`periodId`,`filterChangedDate`) VALUES (?)"
            db.query(userQ, [values], (error, data) => {
                if (error) {
                    return res.json(error);
                } else {
                    return res.json(data);
                }
            });
        }
    });
});


router.put("/:id", (req, res) => {
    const id = req.params.id
    const values = [
        req.body.automatId,
        req.body.userId,
        req.body.automatFilterId,
        req.body.periodId,
        req.body.filterChangedDate,
    ]
        
        const q = "INSERT INTO userautomats (automatId,userId,automatFilterId,periodId,filterChangedDate) VALUES(?)";
        db.query(q, [values], (error, data) => {
          if (error) {
            return res
              .status(400)
              .json({ error: "Failed to update product details" });
          } else {
            const q = "UPDATE automats SET isRented = ? WHERE id = ? ";
            db.query(q, [req.body.isRented,id], (error, data) => {
              if (error) {
                return res
                  .status(400)
                  .json({ error: "Failed to update product details" });
              } else {
                return res.json({status:200})
                  }})
              }})
  });
  
  router.delete("/:id",(req,res)=>{
    const automatId = req.params.id
    const q = "DELETE FROM automats WHERE id = ?"
    db.query(q,automatId,(error,data)=>{
        if (error) {
            res.json(error)
        } else {
            res.json(data)            
        }
    })
  })


export default router
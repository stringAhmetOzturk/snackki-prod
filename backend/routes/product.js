import express from "express"
import {db} from "../connect.js"
const router = express.Router()
import multer from "multer"
import { verifyJWT } from "../middleware/verifyJWT.js"
router.get("/",(req,res)=>{
    const q = "SELECT products.*, categories.categoryName AS category , categories.id AS categoryId,subcategories.subcategoryName AS sub_category FROM products INNER JOIN categories ON categories.id = products.category INNER JOIN subcategories ON subcategories.id = products.sub_category ORDER BY categoryId"
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
    const q = "SELECT products.*, categories.categoryName,subcategories.subcategoryName FROM products INNER JOIN categories ON categories.id = products.category INNER JOIN subcategories ON subcategories.id = products.sub_category WHERE products.id = ?"
    db.query(q,id,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
          
            return res.json(data)
        }
    })
})

// img storage confing
var imgconfig = multer.diskStorage({
    destination:(req,file,callback)=>{
        callback(null,"./uploads");
    },
    filename:(req,file,callback)=>{
        callback(null,`image-${Date.now()}-${file.originalname}`)
    }
});


// img filter
const isImage = (req,file,callback)=>{
    if(file.mimetype.startsWith("image")){
        callback(null,true)
    }else{
        callback(null,Error("only image is allowd"))
    }
}

var upload = multer({
    storage:imgconfig,
    fileFilter:isImage
})


router.post("/",verifyJWT,upload.single("image"),(req,res)=>{
    const {filename} = req.file;
    const q = "INSERT INTO products (`title`,`image`,`category`,`sub_category`,`productId`,`desc`,`cartoonAmount`) VALUES (?)"
    const values = [
      req.body.title,
       filename,
       req.body.category,
       req.body.subCategory,
       req.body.productId,
       req.body.desc,
       req.body.cartoonAmount
    ]
    db.query(q,[values],(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })

})

router.put("/:id", verifyJWT,(req, res) => {
    const id = req.params.id
 
    const q = "UPDATE products SET title=?,productId=?, category=?, sub_category=?, `desc`=?, cartoonAmount=? WHERE id=?"
    const values = [
      req.body.title,
      req.body.productId,
      req.body.category,
      req.body.subCategory,
      req.body.desc,
      req.body.cartoonAmount,
      id,
    ]
    db.query(q, values, (error, data) => {
      if (error) {
        return res.status(400).json({ error: "Failed to update product details" })
      }else{
        return res.json({status:200})
      }
 
    })
  })
  

router.delete("/:id",verifyJWT,(req,res)=>{
    const productId = req.params.id
    const q = "DELETE FROM products WHERE id = ?"
    db.query(q,productId,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

export default router
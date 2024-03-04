import express from "express"
import {db} from "../connect.js"
const router = express.Router()
import bcrypt from "bcrypt"
import { verifyJWT } from "../middleware/verifyJWT.js"

router.get("/",verifyJWT,(req,res)=>{
    const q = "SELECT * FROM users ORDER BY isAdmin DESC"
    db.query(q,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})

router.get("/withoutAutomat",verifyJWT,(req,res)=>{
  const q = "SELECT users.* FROM users LEFT JOIN userautomats ON users.userId = userautomats.userId WHERE userautomats.userId IS NULL";
  db.query(q,(error,data)=>{
      if (error) {
          return res.json(error);
      } else {
          return res.json(data);
      }
  });
});


router.get("/admin",verifyJWT,(req,res)=>{
  const q = "SELECT * FROM users WHERE isAdmin = 1"
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
  const q = "SELECT users.*,automats.automatSeriNo,categories.categoryName,products.id AS productId, products.title,products.cartoonAmount,products.image,products.desc,paymenttypes.paymentName FROM users  LEFT JOIN userpaymenttypes ON userpaymenttypes.userId = users.userId LEFT JOIN paymenttypes ON paymenttypes.id = userpaymenttypes.paymentId LEFT JOIN userproducts ON userproducts.userId = users.userId LEFT JOIN products ON products.productId = userproducts.productId LEFT JOIN categories ON categories.id = products.category LEFT JOIN userautomats ON userautomats.userId = users.userId LEFT JOIN automats ON automats.id = userautomats.automatId WHERE users.id = ?"
  db.query(q, id, (error, data)=>{
      if (error) {
          return res.json(error)
      } else {
          return res.json(data)
      }
  })
})

const saltRounds = 10

router.post("/",verifyJWT, async (req, res) => {
  const q =
    "INSERT INTO users (`userId`,`isAdmin`,`name`, `surname`, `email`, `phone`, `street`, `postNo`, `city`, `country`, `branch`, `contactPerson`, `companyName`, `password`) VALUES (?)";
  const password = req.body.postNo;
  const queryValues = [
    req.body.userId,
    req.body.isAdmin,
    req.body.name,
    req.body.surname,
    req.body.email,
    req.body.phone,
    req.body.street,
    req.body.postNo,
    req.body.city,
    req.body.country,
    req.body.branch,
    req.body.contactPerson,
    req.body.companyName,
  ];

  if (password) {
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    queryValues.push(hashedPassword);
  }
  db.query(q, [queryValues], (error, data) => {
    if (error) {

      return res.status(400).json(error);
    } 
    else{
  
          const paymentTypes = JSON.parse(req.body.paymentType)
          const userpaymenttypes = []
          paymentTypes.forEach((p) => {
            userpaymenttypes.push([
              req.body.userId,
              p.value
            ])})
            const orderProductsQuery = "INSERT INTO userpaymenttypes (userId, paymentId) VALUES ?";
           
            db.query(orderProductsQuery, [userpaymenttypes], (error, data) => {
               if (error) {
     
                  return res.json(error);
               } else {
             
                const productsOpen = JSON.parse( req.body.productsOpen)
                const userproducts = []
                productsOpen.forEach((p) => {
                  userproducts.push([
                    req.body.userId,
                    p.value
                  ])})
                  const userProductsQuery = "INSERT INTO userproducts (userId, productId) VALUES ?";
                    
                  db.query(userProductsQuery, [userproducts], (error, data) => {
                     if (error) {
                       
                        return res.json(error);
                     } else {
                     if(req.body.automatId !== undefined && req.body.automatFilterId !== undefined &&req.body.periodId !== undefined &&req.body.filterChangedDate !== undefined)
                     {

            
                          const values = [
                            req.body.automatId,
                            req.body.userId,
                            req.body.automatFilterId,
                            req.body.periodId,
                            req.body.filterChangedDate,
                        ]
                            
                            const userAutomatQuery = "INSERT INTO userautomats (automatId,userId,automatFilterId,periodId,filterChangedDate) VALUES(?)";
                            db.query(userAutomatQuery, [values], (error, data) => {
                              if (error) {
                                return res
                                  .status(400)
                                  .json({ error: "Failed to update product details" });
                              } else {
                                const updateAutomatq = "UPDATE automats SET isRented = ? WHERE id = ? ";
                                db.query(updateAutomatq, [req.body.isRented,req.body.automatId], (error, data) => {
                                  if (error) {
                                    return res
                                      .status(400)
                                      .json({ error: "Failed to update product details" });
                                  } else {
                                        return res.json(data);
                                      }})
                                  }})
                      }else{
                        res.json(data)
                      }
              
              }})}
      })}})})
router.get("/resetPassword/:id",verifyJWT, async (req, res) => {
    try {
      const userId = req.params.id;
      const q = "SELECT postNo FROM users WHERE id = ?";
      db.query(q, userId, async (error, data) => {
        if (error) {
          return res.json(error);
        } else {
          if (data[0] && data[0].postNo) {
            // return res.json(data[0].postNo.toString())
            const pass = await bcrypt.hash(data[0].postNo.toString(), saltRounds);
            const q = "UPDATE users SET password = ? WHERE id = ?";
            db.query(q, [pass, userId], (error, data) => {
              if (error) {
                return res.json(error);
              } else {
                return res.json({ message: "Password reset successful" });
              }
            });
          } else {
            return res.json({ message: "Could not reset password" });
          }
        }
      });
    } catch (error) {
      return res.json(error);
    }
  });

router.put("/deactivate/:id",verifyJWT,(req,res)=>{
    const userId = req.params.id
    const q = "UPDATE users SET isActive = 0 WHERE id = ?"
    db.query(q,userId,(error,data)=>{
        if (error) {
            return res.json(error)
        } else {
            return res.json(data)
        }
    })
})


router.put("/activate/:id",verifyJWT,(req,res)=>{
  const userId = req.params.id
  const q = "UPDATE users SET isActive = 1 WHERE id = ?"
  db.query(q,userId,(error,data)=>{
      if (error) {
          return res.json(error)
      } else {
          return res.json(data)
      }
  })
})

router.delete("/:id",verifyJWT,(req,res)=>{
  const userId = req.params.id
  const q = "DELETE FROM users WHERE id = ?"
  db.query(q,userId,(error,data)=>{
      if (error) {
          return res.json(error)
      } else {
          return res.json(data)
      }
  })
})

router.put("/:id", verifyJWT, (req, res) => {
  const id = req.params.id;
  const q = "UPDATE users SET name=?, surname=?, userId=?, phone=?, email=?, street=?, postNo=?, city=?, country=?, branch=?, companyName=?, contactPerson=? WHERE id=?";
  const values = [
    req.body.myUser.name,
    req.body.myUser.surname,
    req.body.myUser.userId,
    req.body.myUser.phone,
    req.body.myUser.email,
    req.body.myUser.street,
    req.body.myUser.postNo,
    req.body.myUser.city,
    req.body.myUser.country,
    req.body.myUser.branch,
    req.body.myUser.companyName,
    req.body.myUser.contactPerson,
    id,
  ];

  db.query(q, values, (error, data) => {
    if (error) {
      console.log("Error:", error);
      return res.status(400).json({ error: "Failed to update user details" });
    } else {
      console.log("User details updated successfully");
      // Uncomment and complete the following section if needed
      /*
      const q2 = "UPDATE userautomats SET automatId = ? WHERE userId = ?";
      db.query(q2, [req.body.automatSeriNo, req.body.userId], (error2, data2) => {
        if (error2) {
          console.log(error2);
          return res.status(400).json({ error: "Failed to update userautomats" });
        } else {
          console.log("userautomats updated successfully");
          return res.json({ status: 200 });
        }
      });
      */
      return res.json({ status: 200 });
    }
  });
});



export default router
import express from "express"
import {db} from "../connect.js"
const router = express.Router()

router.post("/verify-token", async (req,res) => {
    try{
        let token = req.body;
        let response = await axios.post(`https://www.google.com/recaptcha/api/siteverify?secret=${process.env.CAPTCHA_SECRET_KEY}&response=${token}`);
        return res.status(200).json({
            success:true,
            message: "Token successfully verified",
            data: response.data
        });
    }catch(error){
        return res.status(500).json({
            success:false,
            message: "Error verifying token"
        })
    }
});

export default router
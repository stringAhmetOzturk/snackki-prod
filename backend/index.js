//////// Imports
import dotenv from 'dotenv'
dotenv.config()
import fs from 'fs'
import https from 'https'
import express from "express"
import cors from "cors"
import userRoute from "./routes/user.js"
import productRoute from "./routes/product.js"
import orderRoute from "./routes/order.js"
import automatRoute from "./routes/automat.js"
import loginRoute from "./routes/login.js"
import foryouRoute from "./routes/foryou.js"
import categoryRoute from "./routes/categories.js"
import subcategoryRoute from "./routes/subcategories.js"
import paymentRoute from "./routes/payments.js"
import brandRoute from "./routes/automatbrand.js"
import modelRoute from "./routes/automatmodel.js"
import filterRoute from "./routes/automatfilters.js"
import userAutomatRoute from "./routes/userautomats.js"
import periodRoute from "./routes/automatperiods.js"
import tokenRoute from "./routes/token.js"
import path from 'path'
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import cookieParser from "cookie-parser"
import {verifyJWT} from './middleware/verifyJWT.js'
import {corsOptions} from './config/corsOptions.js'
//////// Greeting and Debug Outputs
console.log("Welcome to " + process.env.APPNAME + " WebApp");
if (process.env.VERBOSEDEBUG) console.log(".env Settings:");
if (process.env.VERBOSEDEBUG) console.log("VERBOSEDEBUG = " + process.env.VERBOSEDEBUG);
if (process.env.VERBOSEDEBUG) console.log("PORT = " + process.env.PORT);
if (process.env.VERBOSEDEBUG) console.log("HTTPS = " + process.env.HTTPS);
if (process.env.VERBOSEDEBUG) console.log("SSL_CRT_FILE = " + process.env.SSL_CRT_FILE);
if (process.env.VERBOSEDEBUG) console.log("SSL_KEY_FILE = " + process.env.SSL_KEY_FILE);
if (process.env.VERBOSEDEBUG) console.log("NODE_EXTRA_CA_CERTS = " + process.env.NODE_EXTRA_CA_CERTS);

//////// Check if SSL Cert and Key Files exist
if (process.env.VERBOSEDEBUG == "true" && process.env.HTTPS == "true"){
	const path_crt = process.env.SSL_CRT_FILE;
	const path_key = process.env.SSL_KEY_FILE;
	const path_ca = process.env.NODE_EXTRA_CA_CERTS;
	try {
  		if (fs.existsSync(path_crt)) {
    		console.log("SSL_CRT_FILE exists in " + path_crt);
  		}
	} catch(err) {
  		console.error("SSL_CRT_FILE ERROR -> " + err);
	}
	try {
  		if (fs.existsSync(path_key)) {
    		console.log("SSL_KEY_FILE exists in " + path_key);
  		}
	} catch(err) {
  		console.error("SSL_KEY_FILE ERROR -> " + err);
	}
	try {
  		if (fs.existsSync(path_ca)) {
    		console.log("NODE_EXTRA_CA_CERTS exists in " + path_ca);
  		}
	} catch(err) {
  		console.error("NODE_EXTRA_CA_CERTS ERROR -> " + err);
	}
}
/////// validate api token
const validateToken = (req, res, next) => {
	const token = req.headers['x-api-key'];
	if (!token || token !== process.env.API_TOKEN) {
	  return res.sendStatus(403);
	}
	next();
  };
  

//////// Start Express App and Routes
if (process.env.VERBOSEDEBUG) console.log("Starting Express App: ");

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const app = express()
app.use(cors(corsOptions))
// app.use(cors())
app.use(express.json())
app.use(cookieParser())
app.use("/api/images",express.static("uploads"))
app.use(express.static(path.resolve(__dirname, 'build')));
// app.get('*', (req, res) => {
//     res.sendFile(path.resolve(__dirname, 'build', 'index.html'));
//   });
if (process.env.VERBOSEDEBUG) console.log("Initializing Routes");
app.get('/api/hello', (req, res) => {		// Debug Hello World
	res.send({"message":'Hello World!',"data":{"first":"First","second":"Second"}});
  })
//api token validation
app.use(validateToken)
app.use("/api/login", loginRoute)
app.use("/api/foryou", foryouRoute)
app.use("/api/products",productRoute)
app.use("/api/users", userRoute)
app.use("/api/orders", orderRoute)

//verifyJWT
app.use(verifyJWT)

app.use("/api/automats", automatRoute)
app.use("/api/userautomats", userAutomatRoute)
app.use("/api/brands", brandRoute)
app.use("/api/models", modelRoute)
app.use("/api/filters", filterRoute)
app.use("/api/periods", periodRoute)
app.use("/api/categories", categoryRoute)
app.use("/api/subcategories", subcategoryRoute)
app.use("/api/payments", paymentRoute)
app.use("/verify-token", tokenRoute)


if (process.env.VERBOSEDEBUG) console.log("Routes initialized");
var server;
//////// Start listening Server
if (process.env.HTTPS == "true"){
	https
		.createServer(
			{
      			key: fs.readFileSync(process.env.SSL_KEY_FILE),
      			cert: fs.readFileSync(process.env.SSL_CRT_FILE),
    		},app)
		.listen(process.env.PORT || 3001, ()=>{
    console.log("API running and listening with HTTPS");
  });
} else {
	server = app.listen(process.env.PORT || 3001,()=>{
	if (process.env.VERBOSEDEBUG) console.log("API running and listening without HTTPS");
	});
}
// Gracefully handle server shutdown
process.on('SIGINT', () => {
	server.close(() => {
	  // Call the logout-all endpoint to log out all users
	  console.log("All users have been logged out.")
	});
  });
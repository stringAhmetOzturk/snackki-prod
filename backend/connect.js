import mysql from "mysql"

export const db = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"root",
    database:"snackki"
    // user:"snackki",
    // password:"t!36mtC47",
    // database:"snackki_"
})
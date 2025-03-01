import mysql from 'mysql2/promise';
import dotenv from "dotenv";
dotenv.config();

const pool = mysql.createPool({
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT) || 3306,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    typeCast: function (field, next) {
        if (field.type === "TINY" && field.length === 1) {
            return field.string() === "1"; // Chuyển TINYINT(1) thành boolean
        }
        if (field.type === "BLOB") {
            return field.string(); // Chuyển BLOB thành string
        }
        return next();
    }
});


export default pool;

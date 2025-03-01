import { NextFunction, Request, Response } from "express";
import jwt from 'jsonwebtoken';


export const verityToken = (req: Request, res: Response, next: NextFunction): void => {
    const token = req.headers.authorization?.split(" ")[1];
    // console.log(token)

    if (!token) {
        res.status(403).json({ error: "No token provider" });
        return;
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_TOKEN || 'soulsecretkey');
        req.user = decoded as { id: string };
        // console.log(req.user)
        next();
        // res.status(200).json({ error: "Login ok" });

    }
    catch (error) {
        console.error(error);
        res.status(401).json({ error: "Invalid token" });
    }
}

import express from 'express';

declare global {
    namespace Express {
        interface Request {
            // user?: Record<String, any>
            user?: { id: string }
        }
    }
}
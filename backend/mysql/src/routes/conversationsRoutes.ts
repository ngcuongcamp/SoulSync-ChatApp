import { Router, Request, Response } from 'express';
import pool from '../models/db'
import { verityToken } from '../middlewares/auth_middleware';


const router = Router();
router.get('/', verityToken, async (req: Request, res: Response) => {
    let userId = null;

    if (req.user) {
        userId = req.user.id;
    }
    console.log("userId: " + userId)

    try {
        const result = await pool.query(
            `
        SELECT
            c.id AS conversation_id,
            CASE
                WHEN c.participant_one = ? THEN u2.username
                ELSE u1.username
            END AS participant_name,
            m.content AS last_message,
            m.created_at AS last_message_time
        FROM conversations c
        JOIN users u1 ON u1.id = c.participant_two
        JOIN users u2 ON u2.id = c.participant_one
        LEFT JOIN messages m
            ON m.conversation_id = c.id
            AND m.created_at = (
                SELECT MAX(created_at)
                FROM messages m2
                WHERE m2.conversation_id = c.id
            )
        WHERE c.participant_one = ?
            OR c.participant_two = ?
        ORDER BY m.created_at DESC
            `, [userId, userId, userId]
        );

        console.log(result[0])
        res.status(200).json(result[0]);

    }
    catch (error) {
        console.log(error)
        res.status(500).json({ error: 'Failed to fetch conversation' })
    }

})

export default router
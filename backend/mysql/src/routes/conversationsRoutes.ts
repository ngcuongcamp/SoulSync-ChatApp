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
            SELECT conversations.id as conversation_id,
                users.username as participant_name,
                messages.content as last_message,
                messages.created_at as last_message_time
            FROM conversations
            JOIN users ON (users.id = conversations.participant_two AND conversations.id != $1)
            LEFT JOIN LATERAL (
                SELECT content, created_at FROM messages
                WHERE conversation_id = conversations.id
                ORDER BY created_at DESC
                LIMIT 1
            ) messages ON true
            WHERE conversations.participant_one = $1 OR conversations.participant_two = $1
            ORDER BY messages.created_at DESC;
            `, [userId]
        );

        console.log(result)

    }
    catch (error) {
        console.log(error)
        res.status(500).json({ error: 'Failed to fetch conversation' })
    }

})

export default router
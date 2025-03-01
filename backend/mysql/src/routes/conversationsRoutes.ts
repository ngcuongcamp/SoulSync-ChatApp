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
            u.username as participant_name,
            m.content as last_message,
            m.created_at as last_message_time
            FROM conversations 
            JOIN users u ON (u.id = conversations.participant_two AND conversations.id !=$1)

            LEFT JOIN LATERAL (
                SELECT content, created_at FROM messages
                WHERE conversation_id = conversations.id
                ORDER BY created_at DESC
                LIMIT 1 
            ) m ON true

            WHERE conversations.participant_one = $1 OR conversations.participant_two = $1
            ORDER BY m.created_at DESC;

            `, [userId]
        );

        // const result = await pool.query(
        //     `SELECT
        // c.id AS conversation_id,
        //     u.username AS participant_name,
        //     m.content AS last_message,
        //     m.created_at AS last_message_time
        // FROM conversations c
        // JOIN users u ON(u.id = c.participant_two AND u.id != ?)
        // LEFT JOIN(
        //     SELECT content, created_at, conversation_id 
        //     FROM messages 
        //     WHERE conversation_id IN(SELECT id FROM conversations WHERE participant_one = ? OR participant_two = ?)
        //     ORDER BY created_at DESC
        //     ) m ON m.conversation_id = c.id
        // WHERE c.participant_one = ? OR c.participant_two = ?
        //     GROUP BY c.id
        // ORDER BY last_message_time DESC;`)


        console.log(result)

    }
    catch (error) {
        console.log(error)
        res.status(500).json({ error: 'Failed to fetch conversation' })
    }

})

export default router
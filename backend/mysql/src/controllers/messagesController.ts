import { Request, Response } from "express";
import pool from "../models/db";

export const fetchAllMessageByConversationID = async (req: Request, res: Response) => {
    const { conversationId } = req.params;
    try {
        const result = await pool.query(
            `
            SELECT m.id, m.content, m.sender_id, m.conversation_id, m.created_at
            FROM messages m
            WHERE m.conversation_id = ?
            ORDER BY m.created_at ASC;
            `, [conversationId]
        );
        res.json(result[0]);
    }
    catch (error) {
        res.status(500).json({ error: 'Failed to fetch messages' })
    }
}


export const saveMessage = async (conversationId: string, sender_id: string, content: string) => {
    try {
        const [result] = await pool.execute(
            `
            INSERT INTO messages (conversation_id, sender_id, content)
            VALUES (?, ?, ?)
            `,
            [conversationId, sender_id, content]
        );

        // Lấy ID của bản ghi vừa thêm
        const [rows] = await pool.execute(
            `
            SELECT * FROM messages WHERE id = LAST_INSERT_ID()
            `
        );

        return rows;

    }
    catch (error) {
        console.error("Error saving message: ", error)
        throw new Error("Failed to save message");
    }
}
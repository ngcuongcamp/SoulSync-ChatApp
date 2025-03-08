import { Router } from 'express';
import { verityToken } from '../middlewares/auth_middleware';
import { fetchAllMessageByConversationID } from '../controllers/messagesController';

const router = Router();
router.get('/:conversationId', verityToken, fetchAllMessageByConversationID)

export default router
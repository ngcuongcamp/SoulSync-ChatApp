import { Router } from 'express';
import { verityToken } from '../middlewares/auth_middleware';
import { fetchAllConversationsByUserId } from '../controllers/conversationsController';


const router = Router();
router.get('/:userId', verityToken, fetchAllConversationsByUserId)

export default router
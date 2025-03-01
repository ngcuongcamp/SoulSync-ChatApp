import express, { Request, Response } from 'express';
import { json } from 'body-parser';
import authRoutes from './routes/authRoutes';
import usersRoutes from './routes/usersRoutes';
import conversationRoutes from './routes/conversationsRoutes';

const app = express();
app.use(json());

app.use('/auth', authRoutes);
app.use('/users', usersRoutes)
app.use('/conversations', conversationRoutes)

app.get('/', (req: Request, res: Response) => {
    res.send("It work!");
})


const PORT = process.env.PORT || 8686;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
})


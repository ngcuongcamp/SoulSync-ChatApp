import express, { Request, Response } from 'express';
import { json } from 'body-parser';
import authRoutes from './routes/authRoutes';
import usersRoutes from './routes/usersRoutes';
import conversationRoutes from './routes/conversationsRoutes';
import messagesRoutes from './routes/messagesRoutes';
import http from 'http';
import { Server } from 'socket.io';
import { saveMessage } from './controllers/messagesController';


const app = express();

const server = http.createServer(app);
app.use(json());

const io = new Server(server, {
    cors: {
        origin: "*"
    }
})

app.use('/users', usersRoutes)
app.use('/auth', authRoutes);
app.use('/conversations', conversationRoutes)
app.use('/messages', messagesRoutes)

io.on('connection', (socket) => {
    console.log('A user connected: ', socket.id)

    socket.on('joinConversation', (conversationId) => {
        socket.join(conversationId)
        console.log('User joined conversation: ', conversationId)
    })

    socket.on('sendMessage', async (message) => {
        const { conversationId, senderId, content } = message;
        try {
            const savedMessage = await saveMessage(conversationId, senderId, content);

            console.log("sendMessage: ");
            console.log(savedMessage);
            io.to(conversationId).emit('newMessage', saveMessage);

        }
        catch (error) {
            console.error('Failed to save message: ', error);
        }
    });

    socket.on('disconnect', () => {
        console.log('User disconnected: ', socket.id);

    })
})

app.get('/', (req: Request, res: Response) => {
    res.send("It work!");
})


const PORT = process.env.PORT || 8686;

server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
})


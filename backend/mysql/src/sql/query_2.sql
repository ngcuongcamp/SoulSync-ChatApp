
-- Lấy ID của cuộc hội thoại từ bảng `conversations`
SELECT conversations.id as conversation_id,  
-- Lấy tên người dùng từ bảng `users`
       users.username as participant_name,
-- Lấy nội dung của tin nhắn cuối cùng từ subquery `messages`
       messages.content as last_message,
-- Lấy thời gian tạo của tin nhắn cuối cùng từ subquery messages
       messages.created_at as last_message_time

FROM conversations -- bảng chính: `conversations` chứa thông tin về các cuộc hội thoại
JOIN users -- kết hợp với bảng `users`
ON (users.id = conversations.participant_two AND conversations.id != $1)
-- điều kiện: 
LEFT JOIN LATERAL (
    SELECT content, created_at FROM messages
    WHERE conversation_id = conversations.id
    ORDER BY created_at DESC
    LIMIT 1 
) messages ON true
WHERE conversations.participant_one = $1 OR conversations.participant_two = $1
ORDER BY messages.created_at DESC;
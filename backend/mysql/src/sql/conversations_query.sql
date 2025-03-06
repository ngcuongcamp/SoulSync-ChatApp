SELECT
            c.id AS conversation_id,         -- Lấy ID của cuộc hội thoại từ bảng conversations
            u.username AS participant_name,  -- Lấy username của người tham gia từ bảng users
            m.content AS last_message,       -- Lấy nội dung tin nhắn cuối cùng từ subquery
            m.created_at AS last_message_time -- Lấy thời gian tạo tin nhắn cuối cùng từ subquery
        FROM conversations c                 -- Bảng chính: conversations (biệt danh là c)
        JOIN users u                        -- Kết nối với bảng users (biệt danh là u)
            ON (u.id = c.participant_two     -- Điều kiện: ID của user phải khớp với participant_two
                AND u.id != ?)              -- Và không được trùng với ID người dùng hiện tại (dùng ? thay $1)
        LEFT JOIN (                         -- Kết nối trái với subquery để lấy tin nhắn cuối cùng
            SELECT
                content,                   -- Nội dung tin nhắn
                created_at,                -- Thời gian tạo tin nhắn
                conversation_id            -- ID của cuộc hội thoại
            FROM messages                  -- Từ bảng messages
            WHERE conversation_id = c.id   -- Chỉ lấy tin nhắn thuộc về cuộc hội thoại hiện tại
            ORDER BY created_at DESC       -- Sắp xếp theo thời gian giảm dần (mới nhất trước)
            LIMIT 1                        -- Chỉ lấy 1 tin nhắn mới nhất
        ) m ON TRUE                        -- Gán kết quả subquery vào alias 'm', dùng ON TRUE vì LEFT JOIN
        WHERE c.participant_one = ?        -- Lọc các cuộc hội thoại có participant_one là user hiện tại
            OR c.participant_two = ?       -- Hoặc participant_two là user hiện tại
        ORDER BY m.created_at DESC;        -- Sắp xếp tất cả kết quả theo thời gian tin nhắn cuối giảm dần
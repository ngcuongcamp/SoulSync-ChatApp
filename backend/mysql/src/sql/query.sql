CREATE TABLE conversations (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    participant_one INT(11),
    participant_two INT(11),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_one) REFERENCES users(id),
    FOREIGN KEY (participant_two) REFERENCES users(id)
);

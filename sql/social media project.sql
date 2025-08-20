create database project;
use project;
-- CREATING USERS TABLE --
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ADDING A NEW COLUMN TO USERS TABLE FOR PROFILE BIO --
ALTER TABLE users ADD bio VARCHAR(255);


-- CREATING POSTS TABLE --
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- CREATING LIKES TABLE --
CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    post_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

-- CREATING COMMENTS TABLE --
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- CREATING FOLLOWERS TABLE --
CREATE TABLE followers (
    follower_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,       -- The one who is being followed
    follower_user_id INT,  -- The one who follows
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (follower_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- INSERTING VALUES INTO USERS TABLE --
INSERT INTO users (username, email, password)
VALUES 
('harshi_1070', 'harshi@gmail.com', 'pass123'),
('kishore_1510', 'kishore@gmail.com', 'pass456'),
('sumanth07', 'sumanth@gmail.com', 'pass789');
select * from users;

-- INSERTING VALUES INTO POSTS TABLE --
INSERT INTO posts (user_id, content)
VALUES 
(1, 'Hello world! This is my first post.'),
(2, 'Good morning everyone!'),
(3, 'Enjoying a great day!');
select * from posts;

-- UPDATING POST CONTENT --
UPDATE posts SET content = ' Hello Everyone!!' WHERE post_id = 1;

-- INSERTING VALUES INTO LIKES TABLE --
INSERT INTO likes (user_id, post_id)
VALUES 
(2, 1), 
(3, 1), 
(1, 2);
SELECT * FROM LIKES;

-- INSERTING VALUES INTO COMMENTS TABLE --
INSERT INTO comments (post_id, user_id, comment_text)
VALUES 
(1, 2, 'Nice post!'),
(1, 3, 'Welcome Alice!'),
(2, 1, 'Good morning Bob!');
SELECT * FROM COMMENTS;

-- DELETING A COMMENT --
DELETE FROM comments WHERE comment_id = 3;


-- INSERTING VALUES INTO FOLLOWERS TABLE --
INSERT INTO followers (user_id, follower_user_id)
VALUES 
(1, 2),  
(1, 3),  
(2, 1);
SELECT * FROM FOLLOWERS;

-- GET POSTS BY USER_ID=1 USING WHERE CLAUSE --
SELECT * FROM posts WHERE user_id = 1;

-- QUERIES USING AGGREGATE FUNCTIONS --
SELECT COUNT(*) AS total_posts FROM posts;

-- NUMBER OF LIKES ON EACH POST USING GROUP BY --
SELECT post_id, COUNT(*) AS total_likes
FROM likes
GROUP BY post_id;

-- FIND USERS WITH MORE THAN 1 FOLLOWER USING HAVING CLAUSE --
SELECT user_id, COUNT(*) AS total_followers
FROM followers
GROUP BY user_id
HAVING COUNT(*) > 1;

-- FIND USERS WHOSE USERNAME STARTS WITH 'har' --
SELECT * FROM users WHERE username LIKE 'har%';

-- GET USERNAMES OF PEOPLE WHO LIKED POST_ID=1 --
SELECT username 
FROM users 
WHERE user_id IN (SELECT user_id FROM likes WHERE post_id = 1);

-- STORED PROCEDURES --
DELIMITER //
CREATE PROCEDURE GetUserPosts(IN uid INT)
BEGIN
    SELECT * FROM posts WHERE user_id = uid;
END //
DELIMITER ;
CALL GetUserPosts(1);

-- TRIGGERS --
CREATE TABLE post_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    action VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //
CREATE TRIGGER after_post_insert
AFTER INSERT ON posts
FOR EACH ROW
BEGIN
    INSERT INTO post_logs (post_id, action) VALUES (NEW.post_id, 'New Post Created');
END //
DELIMITER ;
INSERT INTO posts (user_id,content) VALUES (1, 'Trigger test post!');
SELECT * FROM post_logs;
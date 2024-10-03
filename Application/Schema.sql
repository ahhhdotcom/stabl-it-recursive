CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    parent_id UUID DEFAULT NULL,
    author TEXT NOT NULL,
    body TEXT NOT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE user_reactions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    post_id UUID NOT NULL,
    user_id UUID NOT NULL,
    reaction INT NOT NULL
);
CREATE INDEX user_reactions_post_id_index ON user_reactions (post_id);
CREATE INDEX user_reactions_user_id_index ON user_reactions (user_id);
ALTER TABLE user_reactions ADD CONSTRAINT user_reactions_ref_post_id FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION;
ALTER TABLE user_reactions ADD CONSTRAINT user_reactions_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;

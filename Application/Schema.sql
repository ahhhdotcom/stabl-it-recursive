CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    parent_id UUID DEFAULT NULL,
    likes INT DEFAULT 0 NOT NULL,
    author TEXT NOT NULL,
    body TEXT NOT NULL
);

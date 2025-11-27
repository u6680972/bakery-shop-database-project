CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

ALTER TABLE "user" ADD COLUMN first_name VARCHAR(100);
ALTER TABLE "user" ADD COLUMN last_name VARCHAR(100);
ALTER TABLE "user" ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE "user" ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE "user" ADD COLUMN user_type VARCHAR(20) DEFAULT 'manager';
ALTER TABLE "user" ALTER COLUMN user_type SET NOT NULL;
ALTER TABLE "user" ADD CONSTRAINT check_valid_user_type CHECK (user_type IN ('manager', 'customer'));

ALTER TABLE "user" DROP COLUMN user_type;
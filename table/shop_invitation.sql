CREATE TABLE shop_invitation (
      invitation_code VARCHAR(32) PRIMARY KEY,
      shop_id INT NOT NULL REFERENCES client(shop_id) ON DELETE CASCADE,
      issued_by_user_id INT NOT NULL REFERENCES "user"(user_id) ON DELETE RESTRICT,
      expires_at TIMESTAMP NOT NULL,
      used_by_user_id INT UNIQUE REFERENCES "user"(user_id) ON DELETE RESTRICT,
      created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
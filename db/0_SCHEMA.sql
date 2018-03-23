DROP TABLE IF EXISTS api.website;
CREATE TABLE api.website (
	page_name varchar(30) PRIMARY KEY,
	data jsonb,
	last_updated timestamp DEFAULT CURRENT_TIMESTAMP
);

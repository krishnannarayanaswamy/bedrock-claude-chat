CREATE TABLE IF NOT EXISTS items
(id text,
 botid text,
 content text,
 source text,
 embedding vector<float, 1024>,
 PRIMARY KEY (id));

CREATE CUSTOM INDEX IF NOT EXISTS embedding_index ON items(embedding)
USING 'org.apache.cassandra.index.sai.StorageAttachedIndex' WITH OPTIONS = { 'similarity_function': 'dot_product' };

CREATE CUSTOM INDEX IF NOT EXISTS botid_index ON items(botid)
USING 'org.apache.cassandra.index.sai.StorageAttachedIndex';

SELECT id, botid, content, source, embedding
FROM items
WHERE botid = ''
ORDER BY text_embedding ANN OF ''
LIMIT 5 """ 
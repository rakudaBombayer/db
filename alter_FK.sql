-- program テーブルの外部キー設定
ALTER TABLE program
ADD CONSTRAINT fk_program_genre
FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
ADD CONSTRAINT fk_program_viewing_history
FOREIGN KEY (viewing_history_id) REFERENCES viewing_history(viewing_history_id),
ADD CONSTRAINT fk_program_season
FOREIGN KEY (season_id) REFERENCES seasons(season_id),
ADD CONSTRAINT fk_program_channel
FOREIGN KEY (channel_id) REFERENCES channel(channel_id);

-- seasons テーブルの外部キー設定 (既に存在しないため不要)
-- (seasons テーブルは他のテーブルへの外部キーを持っていません)

-- episodes テーブルの外部キー設定
ALTER TABLE episodes
ADD CONSTRAINT fk_episodes_season
FOREIGN KEY (season_id) REFERENCES seasons(season_id);

-- user テーブルの外部キー設定
ALTER TABLE user
ADD CONSTRAINT fk_user_viewing_history
FOREIGN KEY (viewing_history_id) REFERENCES viewing_history(viewing_history_id);

-- viewing_history テーブルの外部キー設定
ALTER TABLE viewing_history
ADD CONSTRAINT fk_viewing_history_episode
FOREIGN KEY (episode_id) REFERENCES episodes(episode_id);

-- channel テーブルの外部キー設定 (既に存在しないため不要)
-- (channel テーブルは他のテーブルへの外部キーを持っていません)

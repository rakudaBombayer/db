1. channel テーブル
INSERT INTO channel (channel_id, channel_name) VALUES 
(1, 'ドラマ'), 
(2, 'アニメ'), 
(3, 'ニュース');
2. genre テーブル
INSERT INTO genre (genre_id, genre_name) VALUES 
(1, 'ドラマ'), 
(2, 'アニメ'), 
(3, 'ニュース');
3. seasons テーブル
INSERT INTO seasons (season_id, season_title, seasons, season_details) VALUES 
(1, 'シーズン1', 1, '最初のシーズン'), 
(2, 'シーズン2', 2, '第二のシーズン'), 
(3, 'シーズン3', 3, '第三のシーズン');
4. episodes テーブル
INSERT INTO episodes (episode_id, episode_title, season_id, episodes, episode_details) VALUES 
(1, 'エピソード1', 1, 1, '最初のエピソード'), 
(2, 'エピソード2', 1, 2, '第二のエピソード'), 
(3, 'エピソード3', 2, 1, 'シーズン2の最初のエピソード'), 
(4, 'エピソード4', 2, 2, 'シーズン2の第二のエピソード'), 
(5, 'エピソード5', 3, 1, 'シーズン3の最初のエピソード');

5. viewing_history テーブル
INSERT INTO viewing_history (viewing_history_id, views, episode_id) VALUES 
(1, 150, 1), 
(2, 200, 2), 
(3, 120, 3), 
(4, 180, 4), 
(5, 220, 5);
6. program テーブル
INSERT INTO program (program_id, genre_id, title, duration, release_date, viewing_history_id, season_id, starttime, endtime, channel_id) VALUES 
(1, 1, 'ドラマ番組1', '01:00:00', '2024-11-01', 1, 1, '2024-11-04 10:00:00', '2024-11-04 11:00:00', 1),
(2, 2, 'アニメ番組1', '00:30:00', '2024-11-02', 2, 1, '2024-11-04 12:00:00', '2024-11-04 12:30:00', 2),
(3, 3, 'ニュース番組1', '00:45:00', '2024-11-03', 3, 2, '2024-11-04 14:00:00', '2024-11-04 14:45:00', 3);
7. user テーブル
INSERT INTO user (user_id, mailaddress, password, name, viewing_history_id) VALUES 
(1, 'testuser1@example.com', 'password123', 'テストユーザー1', 1), 
(2, 'testuser2@example.com', 'password456', 'テストユーザー2', 2);
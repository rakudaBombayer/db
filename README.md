# データベース設計
仕様

ドラマ1、ドラマ2、アニメ1、アニメ2、スポーツ、ペットなど、複数のチャンネルがある
各チャンネルの下では時間帯ごとに番組枠が1つ設定されており、番組が放映される
番組はシリーズになっているものと単発ものがある。シリーズになっているものはシーズンが1つものと、シーズン1、シーズン2のように複数シーズンのものがある。各シーズンの下では各エピソードが設定されている
再放送もあるため、ある番組が複数チャンネルの異なる番組枠で放映されることはある
番組の情報として、タイトル、番組詳細、ジャンルが画面上に表示される
各エピソードの情報として、シーズン数、エピソード数、タイトル、エピソード詳細、動画時間、公開日、視聴数が画面上に表示される。単発のエピソードの場合はシーズン数、エピソード数は表示されない
ジャンルとしてアニメ、映画、ドラマ、ニュースなどがある。各番組は1つ以上のジャンルに属する
KPIとして、チャンネルの番組枠のエピソードごとに視聴数を記録する。なお、一つのエピソードは複数の異なるチャンネル及び番組枠で放送されることがあるので、属するチャンネルの番組枠ごとに視聴数がどうだったかも追えるようにする

#テーブル
program
| 列名               | データ型      | 制約                                                      |
|-------------------|--------------|---------------------------------------------------------|
| program_id        | BIGINT(20)   | PRIMARY KEY                                             |
| genre_id          | BIGINT(20)   | FOREIGN KEY REFERENCES genre(genre_id)                 |
| title             | VARCHAR(255) | NOT NULL                                               |
| duration          | TIME         | NOT NULL                                               |
| release_date      | DATE         | NOT NULL                                               |
| viewing_history_id | BIGINT(20)   | FOREIGN KEY REFERENCES viewing_history(viewing_history_id) |
| season_id         | BIGINT(20)   | FOREIGN KEY REFERENCES seasons(season_id)              |
| starttime         | DATETIME     | NOT NULL                                               |
| endtime           | DATETIME     | NOT NULL                                               |
| channel_id        | BIGINT(20)   | FOREIGN KEY REFERENCES channel(channel_id)              |


genre
| 列名       | データ型      | 制約                             |
|-----------|--------------|--------------------------------|
| genre_id  | BIGINT(20)   | PRIMARY KEY                    |
| genre_name| VARCHAR(100) | NOT NULL                       |


seasons
| 列名          | データ型      | 制約                             |
|--------------|--------------|--------------------------------|
| season_id    | BIGINT(20)   | PRIMARY KEY                    |
| season_title | VARCHAR(255) | NOT NULL                       |
| seasons      | INT        | NOT NULL                       |
| season_details| TEXT        |                                |

episodes
| 列名            | データ型      | 制約                             |
|----------------|--------------|--------------------------------|
| episode_id     | BIGINT(20)   | PRIMARY KEY                    |
| episode_title  | VARCHAR(255) | NOT NULL                       |
| season_id      | BIGINT(20)   | FOREIGN KEY REFERENCES seasons(season_id) |
| episodes       | INT          | NOT NULL                       |
| episode_details| TEXT         |                                |

user
| 列名                | データ型      | 制約                             |
|--------------------|--------------|--------------------------------|
| user_id            | BIGINT(20)   | PRIMARY KEY                    |
| mailaddress        | VARCHAR(100) | NOT NULL                       |
| password           | VARCHAR(255) | NOT NULL                       |
| name               | VARCHAR(100) | NOT NULL                       |
| viewing_history_id | BIGINT(20)   | FOREIGN KEY REFERENCES viewing_history(viewing_history_id) |

viewing_history
| 列名                    | データ型      | 制約                             |
|------------------------|--------------|--------------------------------|
| viewing_history_id     | BIGINT(20)   | PRIMARY KEY                    |
| views                  | INT          | NOT NULL                       |
| episode_id             | BIGINT(20)   | FOREIGN KEY REFERENCES episodes(episode_id) |

channel 
| 列名          | データ型      | 制約                             |
|--------------|--------------|--------------------------------|
| channel_id   | BIGINT(20)   | PRIMARY KEY                    |
| channel_name | VARCHAR(100) | NOT NULL                       |

# ER図
![ER_QUEST](https://github.com/user-attachments/assets/a96fe261-7ce7-4364-a626-2620c869d6c3)


draw.ioのリンク↓  
https://drive.google.com/file/d/1LEU9MSpNpDYNFvuVYlRqTAbGTkaKZYU6/view?usp=sharing


# テーブルを構築する

#データベースにログイン#  
```
mysql -u root -p
```

#データベースを作る#
```
CREATE DATABASE データベース名;
```

#作ったデータベースを使う#
```
CREATE DATABASE データベース名;
```

#データベースにテーブルをつくる#
```
source /ファイルのパス/db_quest.sql
```
*外部キーを設定して連結させる*
```
source /ファイルのパス/alter_FK.sql
```

*サンプルデータを入れる*
```
source /ファイルのパス/add_data.sql
```


# 下記のsql文を試していく

*よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください*

1  
```
SELECT 
    episodes.episode_title,
    viewing_history.views
FROM 
    viewing_history
JOIN 
    episodes ON viewing_history.episode_id = episodes.episode_id
ORDER BY 
    viewing_history.views DESC
LIMIT 3;
```

*よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください*

2  
```
SELECT 
    program.title AS program_title,           -- 番組タイトル
    seasons.seasons AS season_number,         -- シーズン数
    episodes.episodes AS episode_number,      -- エピソード数
    episodes.episode_title,                   -- エピソードタイトル
    viewing_history.views                     -- 視聴数
FROM 
    viewing_history
JOIN 
    episodes ON viewing_history.episode_id = episodes.episode_id
JOIN 
    seasons ON episodes.season_id = seasons.season_id
JOIN 
    program ON seasons.season_id = program.season_id
ORDER BY 
    viewing_history.views DESC
LIMIT 3;
```

*本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします*

3  
```
SELECT 
    channel.channel_name AS channel_name,                                      -- チャンネル名
    program.starttime AS broadcast_start_time,                                 -- 放送開始時刻（日付+時間）
    program.endtime AS broadcast_end_time,                                     -- 放送終了時刻
    seasons.seasons AS season_number,                                          -- シーズン数
    episodes.episodes AS episode_number,                                       -- エピソード数
    episodes.episode_title,                                                    -- エピソードタイトル
    episodes.episode_details                                                   -- エピソード詳細
FROM 
    program
JOIN 
    seasons ON program.season_id = seasons.season_id
JOIN 
    episodes ON episodes.season_id = seasons.season_id
JOIN 
    channel ON program.channel_id = channel.channel_id                         -- チャンネル情報を結合
WHERE 
    DATE(program.starttime) = CURDATE()                                        -- 本日放送される条件
ORDER BY 
    broadcast_start_time;                                                      -- 放送開始時刻で並べ替え
```

*ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください*

4  
```
SELECT 
    program.starttime AS broadcast_start_time,                                 -- 放送開始時刻（日付+時間）
    program.endtime AS broadcast_end_time,                                     -- 放送終了時刻
    seasons.seasons AS season_number,                                          -- シーズン数
    episodes.episodes AS episode_number,                                       -- エピソード数
    episodes.episode_title,                                                    -- エピソードタイトル
    episodes.episode_details                                                   -- エピソード詳細
FROM 
    program
JOIN 
    seasons ON program.season_id = seasons.season_id
JOIN 
    episodes ON episodes.season_id = seasons.season_id
JOIN 
    channel ON program.channel_id = channel.channel_id                         -- チャンネル情報を結合
WHERE 
    channel.channel_name = 'ドラマチャンネル'                                           -- ドラマチャンネルを指定
    AND DATE(program.starttime) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)  -- 本日から一週間分
ORDER BY 
    broadcast_start_time;                                                      -- 放送開始時刻で並べ替え
```

*直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください*

5  
```
SELECT 
    program.title AS program_title,                               -- 番組タイトル
    SUM(viewing_history.views) AS total_views                     -- エピソード視聴数の合計
FROM 
    program
JOIN 
    viewing_history ON program.viewing_history_id = viewing_history.viewing_history_id
JOIN 
    episodes ON viewing_history.episode_id = episodes.episode_id
WHERE 
    DATE(program.starttime) BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()  -- 直近一週間の放送分
GROUP BY 
    program.title                                                 -- 番組ごとにグループ化
ORDER BY 
    total_views DESC                                              -- 視聴数合計で降順に並べ替え
LIMIT 2;                                                          -- トップ2の番組を取得
```

*ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。*

6  
```
SELECT 
    genre.genre_name AS genre_name,                                  -- ジャンル名
    program.title AS program_title,                                  -- 番組タイトル
    AVG(viewing_history.views) AS average_views                      -- エピソードの平均視聴数
FROM 
    program
JOIN 
    genre ON program.genre_id = genre.genre_id                       -- ジャンル情報を結合
JOIN 
    viewing_history ON program.viewing_history_id = viewing_history.viewing_history_id
JOIN 
    episodes ON viewing_history.episode_id = episodes.episode_id
GROUP BY 
    genre.genre_id, program.program_id                               -- ジャンルと番組ごとにグループ化
HAVING 
    AVG(viewing_history.views) = (
        SELECT 
            MAX(avg_views)                                           -- 各ジャンルで平均視聴数が最も高い番組を取得
        FROM (
            SELECT 
                genre.genre_id,
                program.program_id,
                AVG(viewing_history.views) AS avg_views
            FROM 
                program
            JOIN 
                viewing_history ON program.viewing_history_id = viewing_history.viewing_history_id
            GROUP BY 
                genre.genre_id, program.program_id
        ) AS genre_avg
        WHERE 
            genre_avg.genre_id = genre.genre_id
    )
ORDER BY 
    genre_name;                                                      -- ジャンル名で並べ替え
```



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

#ER図
![ER_QUEST](https://github.com/user-attachments/assets/a96fe261-7ce7-4364-a626-2620c869d6c3)

draw.ioのリンク↓
https://drive.google.com/file/d/1LEU9MSpNpDYNFvuVYlRqTAbGTkaKZYU6/view?usp=sharing




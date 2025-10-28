# NBA Statistics Repository

Welcome to the NBA Statistics Repository for teams and players. This repository contains a rich and diverse dataset spanning from 1996 to 2023, drawn from NBA game statistics. It's ideal for data analysts, basketball fans, researchers, and anyone interested in the detailed numbers behind the sport.

## Repo Structure

This repository contains a series of CSV files detailing the performances of teams and players from 1996 to 2023. A list of these files is provided below:

1. `player_index.csv`: An index of all players with general information.
2. `player_stats_advanced_po.csv` and `player_stats_advanced_rs.csv`: Advanced statistics for players during playoffs (po) and regular season (rs).
3. `player_stats_defense_po.csv` and `player_stats_defense_rs.csv`: Defensive statistics for players during the playoffs and regular season.
4. `player_stats_misc_po.csv` and `player_stats_misc_rs.csv`: Miscellaneous player statistics for the playoffs and regular season.
5. `player_stats_scoring_po.csv` and `player_stats_scoring_rs.csv`: Scoring statistics for players during the playoffs and regular season.
6. `player_stats_traditional_po.csv` and `player_stats_traditionnal_rs.csv`: Traditional player statistics during the playoffs and regular season.
7. `player_stats_usage_po.csv` and `player_stats_usage_rs.csv`: Player usage statistics during the playoffs and regular season.
8. `team_stats_advanced_po.csv` and `team_stats_advanced_rs.csv`: Advanced team statistics during the playoffs and regular season.
9. `team_stats_defense_po.csv` and `team_stats_defense_rs.csv`: Defensive team statistics during the playoffs and regular season.
10. `team_stats_four_factors_po.csv` and `team_stats_four_factors_rs.csv`: Four factors team statistics during the playoffs and regular season.
11. `team_stats_misc_po.csv` and `team_stats_misc_rs.csv`: Miscellaneous team statistics during the playoffs and regular season.
12. `team_stats_opponent_po.csv` and `team_stats_opponent_rs.csv`: Team opponent statistics during the playoffs and regular season.
13. `team_stats_scoring_po.csv` and `team_stats_scoring_rs.csv`: Scoring team statistics during the playoffs and regular season.
14. `team_stats_traditional_po.csv` and `team_stats_traditional_rs.csv`: Traditional team statistics during the playoffs and regular season.

## Used Dataset Descriptions
### player_stats_defense_rs.csv
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Common name or nickname used for the player.
* TEAM_ID: Unique identifier for the team.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* AGE: Player's age during the season.
* GP: Games played.
* W: Number of games won.
* L: Number of games lost.
* W_PCT: Win percentage.
* MIN: Total minutes played.
* DEF_RATING: Defensive rating — points allowed per 100 possessions.
* DREB: Total defensive rebounds.
* DREB_PCT: Defensive rebound percentage — estimate of available defensive rebounds grabbed.
* PCT_DREB: Percentile rank for defensive rebounds.
* STL: Total steals.
* PCT_STL: Percentile rank for steals.
* BLK: Total blocks.
* PCT_BLK: Percentile rank for blocks.
* OPP_PTS_OFF_TOV: Opponent points scored off turnovers while player was on court.
* OPP_PTS_2ND_CHANCE: Opponent second-chance points allowed.
* OPP_PTS_FB: Opponent fast break points allowed.
* OPP_PTS_PAINT: Opponent points in the paint allowed.
* DEF_WS: Defensive Win Shares — estimate of wins contributed due to defense.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* DEF_RATING_RANK: Rank by defensive rating.
* DREB_RANK: Rank by defensive rebounds.
* DREB_PCT_RANK: Rank by defensive rebound percentage.
* PCT_DREB_RANK: Rank by percentile of defensive rebounds.
* STL_RANK: Rank by steals.
* PCT_STL_RANK: Rank by percentile of steals.
* BLK_RANK: Rank by blocks.
* PCT_BLK_RANK: Rank by percentile of blocks.
* OPP_PTS_OFF_TOV_RANK: Rank by opponent points off turnovers.
* OPP_PTS_2ND_CHANCE_RANK: Rank by opponent second-chance points.
* OPP_PTS_FB_RANK: Rank by opponent fast break points.
* OPP_PTS_PAINT_RANK: Rank by opponent points in the paint.
* DEF_WS_RANK: Rank by defensive win shares.
* SEASON: NBA season in "YYYY-YY" format (e.g., 1996-97).

### player_stats_defense_rs.csv
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's common name or nickname.
* TEAM_ID: Unique identifier for the team.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* AGE: Player's age during the season.
* GP: Games played.
* W: Number of games won.
* L: Number of games lost.
* W_PCT: Win percentage.
* MIN: Total minutes played.
* USG_PCT: Usage percentage — estimated percentage of team plays used by the player.
* PCT_FGM: Share of team field goals made.
* PCT_FGA: Share of team field goal attempts.
* PCT_FG3M: Share of team 3-point field goals made.
* PCT_FG3A: Share of team 3-point field goal attempts.
* PCT_FTM: Share of team free throws made.
* PCT_FTA: Share of team free throw attempts.
* PCT_OREB: Share of team offensive rebounds.
* PCT_DREB: Share of team defensive rebounds.
* PCT_REB: Share of team total rebounds.
* PCT_AST: Share of team assists.
* PCT_TOV: Share of team turnovers.
* PCT_STL: Share of team steals.
* PCT_BLK: Share of team blocks.
* PCT_BLKA: Share of team blocks against (shots blocked by opponent).
* PCT_PF: Share of team personal fouls committed.
* PCT_PFD: Share of team personal fouls drawn.
* PCT_PTS: Share of team points scored.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by total minutes played.
* USG_PCT_RANK: Rank by usage percentage.
* PCT_FGM_RANK: Rank by share of field goals made.
* PCT_FGA_RANK: Rank by share of field goal attempts.
* PCT_FG3M_RANK: Rank by share of 3-point field goals made.
* PCT_FG3A_RANK: Rank by share of 3-point field goal attempts.
* PCT_FTM_RANK: Rank by share of free throws made.
* PCT_FTA_RANK: Rank by share of free throw attempts.
* PCT_OREB_RANK: Rank by share of offensive rebounds.
* PCT_DREB_RANK: Rank by share of defensive rebounds.
* PCT_REB_RANK: Rank by share of total rebounds.
* PCT_AST_RANK: Rank by share of assists.
* PCT_TOV_RANK: Rank by share of turnovers.
* PCT_STL_RANK: Rank by share of steals.
* PCT_BLK_RANK: Rank by share of blocks.
* PCT_BLKA_RANK: Rank by share of shots blocked by opponents.
* PCT_PF_RANK: Rank by share of personal fouls committed.
* PCT_PFD_RANK: Rank by share of personal fouls drawn.
* PCT_PTS_RANK: Rank by share of team points.
* SEASON: NBA season in "YYYY-YY" format (e.g., 1996-97).

### player_stats_traditionnal_rs:
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's common name or nickname.
* TEAM_ID: Unique identifier for the team.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* AGE: Player's age during the season.
* GP: Games played.
* W: Number of games won.
* L: Number of games lost.
* W_PCT: Win percentage.
* MIN: Total minutes played.
* FGM: Field goals made.
* FGA: Field goal attempts.
* FG_PCT: Field goal percentage.
* FG3M: Three-point field goals made.
* FG3A: Three-point field goal attempts.
* FG3_PCT: Three-point field goal percentage.
* FTM: Free throws made.
* FTA: Free throw attempts.
* FT_PCT: Free throw percentage.
* OREB: Offensive rebounds.
* DREB: Defensive rebounds.
* REB: Total rebounds.
* AST: Assists.
* TOV: Turnovers.
* STL: Steals.
* BLK: Blocks.
* BLKA: Shots blocked by opponents.
* PF: Personal fouls committed.
* PFD: Personal fouls drawn.
* PTS: Points scored.
* PLUS_MINUS: Plus/minus while on court.
* NBA_FANTASY_PTS: Fantasy points scored (NBA format).
* DD2: Number of double-doubles.
* TD3: Number of triple-doubles.
* WNBA_FANTASY_PTS: Fantasy points scored (WNBA format).
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* FGM_RANK: Rank by field goals made.
* FGA_RANK: Rank by field goal attempts.
* FG_PCT_RANK: Rank by field goal percentage.
* FG3M_RANK: Rank by three-point field goals made.
* FG3A_RANK: Rank by three-point field goal attempts.
* FG3_PCT_RANK: Rank by three-point field goal percentage.
* FTM_RANK: Rank by free throws made.
* FTA_RANK: Rank by free throw attempts.
* FT_PCT_RANK: Rank by free throw percentage.
* OREB_RANK: Rank by offensive rebounds.
* DREB_RANK: Rank by defensive rebounds.
* REB_RANK: Rank by total rebounds.
* AST_RANK: Rank by assists.
* TOV_RANK: Rank by turnovers.
* STL_RANK: Rank by steals.
* BLK_RANK: Rank by blocks.
* BLKA_RANK: Rank by shots blocked by opponents.
* PF_RANK: Rank by personal fouls.
* PFD_RANK: Rank by personal fouls drawn.
* PTS_RANK: Rank by points scored.
* PLUS_MINUS_RANK: Rank by plus/minus.
* NBA_FANTASY_PTS_RANK: Rank by NBA fantasy points.
* DD2_RANK: Rank by double-doubles.
* TD3_RANK: Rank by triple-doubles.
* WNBA_FANTASY_PTS_RANK: Rank by WNBA fantasy points.
* SEASON: NBA season in "YYYY-YY" format (e.g., 1996-97).

### player_stats_advanced_rs:
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's common name or nickname.
* TEAM_ID: Unique identifier for the team.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* AGE: Player's age during the season.
* GP: Games played.
* W: Number of games won.
* L: Number of games lost.
* W_PCT: Win percentage.
* MIN: Total minutes played.
* E_OFF_RATING: Estimated offensive rating.
* OFF_RATING: Actual offensive rating (points per 100 possessions).
* sp_work_OFF_RATING: Special work-adjusted offensive rating.
* E_DEF_RATING: Estimated defensive rating.
* DEF_RATING: Actual defensive rating (points allowed per 100 possessions).
* sp_work_DEF_RATING: Special work-adjusted defensive rating.
* E_NET_RATING: Estimated net rating.
* NET_RATING: Net rating (offensive - defensive rating).
* sp_work_NET_RATING: Special work-adjusted net rating.
* AST_PCT: Assist percentage — percent of teammate field goals assisted.
* AST_TO: Assist-to-turnover ratio.
* AST_RATIO: Assists per 100 possessions.
* OREB_PCT: Offensive rebound percentage.
* DREB_PCT: Defensive rebound percentage.
* REB_PCT: Total rebound percentage.
* TM_TOV_PCT: Team turnover percentage while player is on court.
* E_TOV_PCT: Estimated turnover percentage.
* EFG_PCT: Effective field goal percentage.
* TS_PCT: True shooting percentage.
* USG_PCT: Usage percentage.
* E_USG_PCT: Estimated usage percentage.
* E_PACE: Estimated team pace with player.
* PACE: Actual pace (possessions per 48 minutes).
* PACE_PER40: Possessions per 40 minutes.
* sp_work_PACE: Special work-adjusted pace metric.
* PIE: Player Impact Estimate — contribution to game outcome.
* POSS: Total possessions played.
* FGM: Field goals made.
* FGA: Field goal attempts.
* FGM_PG: Field goals made per game.
* FGA_PG: Field goal attempts per game.
* FG_PCT: Field goal percentage.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* E_OFF_RATING_RANK: Rank by estimated offensive rating.
* OFF_RATING_RANK: Rank by offensive rating.
* sp_work_OFF_RATING_RANK: Rank by special work-adjusted offensive rating.
* E_DEF_RATING_RANK: Rank by estimated defensive rating.
* DEF_RATING_RANK: Rank by defensive rating.
* sp_work_DEF_RATING_RANK: Rank by special work-adjusted defensive rating.
* E_NET_RATING_RANK: Rank by estimated net rating.
* NET_RATING_RANK: Rank by net rating.
* sp_work_NET_RATING_RANK: Rank by special work-adjusted net rating.
* AST_PCT_RANK: Rank by assist percentage.
* AST_TO_RANK: Rank by assist-to-turnover ratio.
* AST_RATIO_RANK: Rank by assist ratio.
* OREB_PCT_RANK: Rank by offensive rebound percentage.
* DREB_PCT_RANK: Rank by defensive rebound percentage.
* REB_PCT_RANK: Rank by total rebound percentage.
* TM_TOV_PCT_RANK: Rank by team turnover percentage.
* E_TOV_PCT_RANK: Rank by estimated turnover percentage.
* EFG_PCT_RANK: Rank by effective field goal percentage.
* TS_PCT_RANK: Rank by true shooting percentage.
* USG_PCT_RANK: Rank by usage percentage.
* E_USG_PCT_RANK: Rank by estimated usage percentage.
* E_PACE_RANK: Rank by estimated pace.
* PACE_RANK: Rank by pace.
* sp_work_PACE_RANK: Rank by special work-adjusted pace.
* PIE_RANK: Rank by Player Impact Estimate.
* FGM_RANK: Rank by field goals made.
* FGA_RANK: Rank by field goal attempts.
* FGM_PG_RANK: Rank by field goals made per game.
* FGA_PG_RANK: Rank by field goal attempts per game.
* FG_PCT_RANK: Rank by field goal percentage.
* SEASON: NBA season in "YYYY-YY" format (e.g., 1996-97).

### player_salary:
* team_url: Link to the team’s salary page.
* season: NBA season (e.g., 1996-97).
* rank: Player's salary rank on the team.
* url: Link to the player's salary detail page.
* name: Player’s full name.
* salary: Player’s total salary in dollars.

### player_index:
* Unnamed: 0: Internal row index (from original CSV).
* PERSON_ID: Unique identifier for the player.
* PLAYER_LAST_NAME: Player’s last name.
* PLAYER_FIRST_NAME: Player’s first name.
* PLAYER_SLUG: URL-friendly identifier for the player.
* TEAM_ID: Team identifier.
* TEAM_SLUG: URL-friendly team identifier.
* IS_DEFUNCT: Whether the player’s team is defunct (TRUE/FALSE).
* TEAM_CITY: City of the team.
* TEAM_NAME: Name of the team.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* JERSEY_NUMBER: Player’s jersey number.
* POSITION: Player’s position.
* HEIGHT: Height (e.g., "6-7").
* WEIGHT: Weight in pounds.
* COLLEGE: College attended.
* COUNTRY: Country of origin.
* DRAFT_YEAR: Year drafted.
* DRAFT_ROUND: Draft round.
* DRAFT_NUMBER: Overall pick number.
* ROSTER_STATUS: Player roster status.
* PTS: Points per game.
* REB: Rebounds per game.
* AST: Assists per game.
* STATS_TIMEFRAME: Time frame for stats (e.g., career, season).
* FROM_YEAR: First active season.
* TO_YEAR: Most recent season played.

### player_stats_usage_po:
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's nickname.
* TEAM_ID: Unique identifier for the team.
* TEAM_ABBREVIATION: Abbreviation of the team.
* AGE: Player’s age during the playoffs.
* GP: Games played.
* W: Wins.
* L: Losses.
* W_PCT: Win percentage.
* MIN: Minutes played.
* USG_PCT: Usage percentage.
* PCT_FGM: Percentage of team field goals made.
* PCT_FGA: Percentage of team field goal attempts.
* PCT_FG3M: Percentage of team 3-point field goals made.
* PCT_FG3A: Percentage of team 3-point attempts.
* PCT_FTM: Percentage of team free throws made.
* PCT_FTA: Percentage of team free throw attempts.
* PCT_OREB: Percentage of team offensive rebounds.
* PCT_DREB: Percentage of team defensive rebounds.
* PCT_REB: Percentage of team total rebounds.
* PCT_AST: Percentage of team assists.
* PCT_TOV: Percentage of team turnovers.
* PCT_STL: Percentage of team steals.
* PCT_BLK: Percentage of team blocks.
* PCT_BLKA: Percentage of opponent blocks.
* PCT_PF: Percentage of team fouls.
* PCT_PFD: Percentage of fouls drawn.
* PCT_PTS: Percentage of team points.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* USG_PCT_RANK: Rank by usage percentage.
* PCT_FGM_RANK: Rank by FGM share.
* PCT_FGA_RANK: Rank by FGA share.
* PCT_FG3M_RANK: Rank by 3PM share.
* PCT_FG3A_RANK: Rank by 3PA share.
* PCT_FTM_RANK: Rank by FTM share.
* PCT_FTA_RANK: Rank by FTA share.
* PCT_OREB_RANK: Rank by offensive rebound share.
* PCT_DREB_RANK: Rank by defensive rebound share.
* PCT_REB_RANK: Rank by rebound share.
* PCT_AST_RANK: Rank by assist share.
* PCT_TOV_RANK: Rank by turnover share.
* PCT_STL_RANK: Rank by steal share.
* PCT_BLK_RANK: Rank by block share.
* PCT_BLKA_RANK: Rank by block against share.
* PCT_PF_RANK: Rank by foul share.
* PCT_PFD_RANK: Rank by fouls drawn share.
* PCT_PTS_RANK: Rank by points share.
* SEASON: NBA season (e.g., "2004-05").

### player_stats_scoring_po:
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's nickname.
* TEAM_ID: Team identifier.
* TEAM_ABBREVIATION: Abbreviated team name.
* AGE: Age during playoffs.
* GP: Games played.
* W: Wins.
* L: Losses.
* W_PCT: Win percentage.
* MIN: Minutes played.
* PTS_OFF_TOV: Points off turnovers.
* PTS_2ND_CHANCE: Second chance points.
* PTS_FB: Fast break points.
* PTS_PAINT: Points in the paint.
* OPP_PTS_OFF_TOV: Opponent points off turnovers.
* OPP_PTS_2ND_CHANCE: Opponent second chance points.
* OPP_PTS_FB: Opponent fast break points.
* OPP_PTS_PAINT: Opponent paint points.
* BLK: Blocks.
* BLKA: Blocks against.
* PF: Personal fouls.
* PFD: Personal fouls drawn.
* NBA_FANTASY_PTS: NBA fantasy points.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* PTS_OFF_TOV_RANK: Rank by points off turnovers.
* PTS_2ND_CHANCE_RANK: Rank by second chance points.
* PTS_FB_RANK: Rank by fast break points.
* PTS_PAINT_RANK: Rank by points in the paint.
* OPP_PTS_OFF_TOV_RANK: Rank by opponent points off turnovers.
* OPP_PTS_2ND_CHANCE_RANK: Rank by opponent second chance points.
* OPP_PTS_FB_RANK: Rank by opponent fast break points.
* OPP_PTS_PAINT_RANK: Rank by opponent paint points.
* BLK_RANK: Rank by blocks.
* BLKA_RANK: Rank by blocks against.
* PF_RANK: Rank by fouls.
* PFD_RANK: Rank by fouls drawn.
* NBA_FANTASY_PTS_RANK: Rank by NBA fantasy points.
* SEASON: NBA season (e.g., "2003-04").

### player_stats_advanced_po:
* PLAYER_ID: Unique identifier for the player.
* PLAYER_NAME: Full name of the player.
* NICKNAME: Player's nickname.
* TEAM_ID: Unique team identifier.
* TEAM_ABBREVIATION: Abbreviation of the team name.
* AGE: Player's age during the playoffs.
* GP: Games played.
* W: Wins.
* L: Losses.
* W_PCT: Win percentage.
* MIN: Minutes played.
* E_OFF_RATING: Estimated offensive rating.
* OFF_RATING: Actual offensive rating.
* sp_work_OFF_RATING: Special work-adjusted offensive rating.
* E_DEF_RATING: Estimated defensive rating.
* DEF_RATING: Actual defensive rating.
* sp_work_DEF_RATING: Special work-adjusted defensive rating.
* E_NET_RATING: Estimated net rating.
* NET_RATING: Net rating.
* sp_work_NET_RATING: Special work-adjusted net rating.
* AST_PCT: Assist percentage.
* AST_TO: Assist-to-turnover ratio.
* AST_RATIO: Assists per 100 possessions.
* OREB_PCT: Offensive rebound percentage.
* DREB_PCT: Defensive rebound percentage.
* REB_PCT: Total rebound percentage.
* TM_TOV_PCT: Team turnover percentage with player on court.
* E_TOV_PCT: Estimated turnover percentage.
* EFG_PCT: Effective field goal percentage.
* TS_PCT: True shooting percentage.
* USG_PCT: Usage percentage.
* E_USG_PCT: Estimated usage percentage.
* E_PACE: Estimated pace.
* PACE: Actual pace.
* PACE_PER40: Possessions per 40 minutes.
* sp_work_PACE: Special work-adjusted pace.
* PIE: Player Impact Estimate.
* POSS: Total possessions.
* FGM: Field goals made.
* FGA: Field goals attempted.
* FGM_PG: Field goals made per game.
* FGA_PG: Field goals attempted per game.
* FG_PCT: Field goal percentage.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* E_OFF_RATING_RANK: Rank by estimated offensive rating.
* OFF_RATING_RANK: Rank by offensive rating.
* sp_work_OFF_RATING_RANK: Rank by adjusted offensive rating.
* E_DEF_RATING_RANK: Rank by estimated defensive rating.
* DEF_RATING_RANK: Rank by defensive rating.
* sp_work_DEF_RATING_RANK: Rank by adjusted defensive rating.
* E_NET_RATING_RANK: Rank by estimated net rating.
* NET_RATING_RANK: Rank by net rating.
* sp_work_NET_RATING_RANK: Rank by adjusted net rating.
* AST_PCT_RANK: Rank by assist percentage.
* AST_TO_RANK: Rank by assist-to-turnover ratio.
* AST_RATIO_RANK: Rank by assist ratio.
* OREB_PCT_RANK: Rank by offensive rebound percentage.
* DREB_PCT_RANK: Rank by defensive rebound percentage.
* REB_PCT_RANK: Rank by rebound percentage.
* TM_TOV_PCT_RANK: Rank by team turnover percentage.
* E_TOV_PCT_RANK: Rank by estimated turnover percentage.
* EFG_PCT_RANK: Rank by effective field goal percentage.
* TS_PCT_RANK: Rank by true shooting percentage.
* USG_PCT_RANK: Rank by usage percentage.
* E_USG_PCT_RANK: Rank by estimated usage percentage.
* E_PACE_RANK: Rank by estimated pace.
* PACE_RANK: Rank by actual pace.
* sp_work_PACE_RANK: Rank by adjusted pace.
* PIE_RANK: Rank by Player Impact Estimate.
* FGM_RANK: Rank by field goals made.
* FGA_RANK: Rank by field goals attempted.
* FGM_PG_RANK: Rank by FGM per game.
* FGA_PG_RANK: Rank by FGA per game.
* FG_PCT_RANK: Rank by field goal percentage.
* SEASON: NBA season (e.g., "2020-21").

### team_stats_traditional_po:
* TEAM_ID: Unique team identifier.
* TEAM_NAME: Name of the team.
* GP: Games played.
* W: Wins.
* L: Losses.
* W_PCT: Win percentage.
* MIN: Minutes played.
* FGM: Field goals made.
* FGA: Field goal attempts.
* FG_PCT: Field goal percentage.
* FG3M: 3-point field goals made.
* FG3A: 3-point field goals attempted.
* FG3_PCT: 3-point field goal percentage.
* FTM: Free throws made.
* FTA: Free throw attempts.
* FT_PCT: Free throw percentage.
* OREB: Offensive rebounds.
* DREB: Defensive rebounds.
* REB: Total rebounds.
* AST: Assists.
* TOV: Turnovers.
* STL: Steals.
* BLK: Blocks.
* BLKA: Blocks against.
* PF: Personal fouls.
* PFD: Personal fouls drawn.
* PTS: Points scored.
* PLUS_MINUS: Plus/minus.
* GP_RANK: Rank by games played.
* W_RANK: Rank by wins.
* L_RANK: Rank by losses.
* W_PCT_RANK: Rank by win percentage.
* MIN_RANK: Rank by minutes played.
* FGM_RANK: Rank by field goals made.
* FGA_RANK: Rank by field goal attempts.
* FG_PCT_RANK: Rank by field goal percentage.
* FG3M_RANK: Rank by 3-point field goals made.
* FG3A_RANK: Rank by 3-point field goals attempted.
* FG3_PCT_RANK: Rank by 3-point field goal percentage.
* FTM_RANK: Rank by free throws made.
* FTA_RANK: Rank by free throw attempts.
* FT_PCT_RANK: Rank by free throw percentage.
* OREB_RANK: Rank by offensive rebounds.
* DREB_RANK: Rank by defensive rebounds.
* REB_RANK: Rank by total rebounds.
* AST_RANK: Rank by assists.
* TOV_RANK: Rank by turnovers.
* STL_RANK: Rank by steals.
* BLK_RANK: Rank by blocks.
* BLKA_RANK: Rank by blocks against.
* PF_RANK: Rank by personal fouls.
* PFD_RANK: Rank by fouls drawn.
* PTS_RANK: Rank by points scored.
* PLUS_MINUS_RANK: Rank by plus/minus.
* SEASON: NBA season (e.g., "2022-23").

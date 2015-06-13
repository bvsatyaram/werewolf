# werewolf
A simulation of the were wolf game

## Usage
Show one game play
```
Game.new(<num_of_wolfs>, <num_of_villagers>).play
```
Simulate the game several time and show the probability of villagers winning
```
GameSimulator.new(<num_of_wolfs>, <num_of_villagers>).simulate(<num_of_simulations>)
```
Suggest the best villagers and wolves for a given number of total players
```
RoleSuggestor.new(<total_num_of_players>).suggest(<num_of_simulations_for_each_combination>)
```

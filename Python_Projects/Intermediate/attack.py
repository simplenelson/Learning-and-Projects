import random
from classes.enemy import Enemy

'''
class Enemy:
    hp = 200
    def __init__(self, atkl, atkh):
        self.atkl = atkl
        self.atkh = atkh

    def getAtk(self):
        print(self.atkl)

    def getHP(self):
        print('Enemy HP is', self.hp)\


enemy1 = Enemy(20, 30)
enemy1.getAtk()
enemy1.getHP()

enemy2 = Enemy(50, 60)
enemy2.getAtk()
enemy2.getHP()

'''
enemy = Enemy(200, 50)
print('HP is', enemy.get_hp())



'''
playerhp = 100
enemyatkl = 25
enemyatkh = 50

while playerhp > 0:
    dmg = random.randrange(enemyatkl, enemyatkh)
    playerhp = playerhp - dmg

    if playerhp <= 30:
        playerhp = 30
    print('Emeny strikes for', dmg, 'points of damage. Current hp is', playerhp)

    if playerhp > 30:
        continue


    print("You have low health, Would you like to heal?")
    break
'''
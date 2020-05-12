from classes.game import Person, bcolors
from classes.magic import Spell

Fire = Spell("Fire", 10, 30, "black")
Electric = Spell("Thunder", 9, 20, "black")
Ice = Spell("Blizzard", 8, 25, "black")

cure = Spell("Cure", 15, 25, "White")
cura = Spell("Cure", 25, 50, "White")



player = Person(100, 30, 25, 34, [Fire, Electric, Ice, cure, cura])
enemy = Person(60, 10, 15, 20, [])

running = True

print(bcolors.FAIL + bcolors.BOLD + 'The Enemy Attacks!' + bcolors.ENDC)

while running:
    print('==============================')
    player.choose_action()
    choice = input('Choose your action!: ')
    index = int(choice) - 1
    print('You chose:', choice)

    if index == 0:
        dmg = player.generate_dmg()
        enemy.take_damage(dmg)
        print("You dealt", dmg, "damage.")
    elif index == 1:
        player.choose_magic()
        magic_choice = int(input("Choose magic:")) - 1

        spell = player.magic[magic_choice]
        magic_dmg = spell.generate_damage()

        current_mp = player.get_mp()
        if spell.cost > current_mp:
            print(bcolors.FAIL + "Not Enough MP" + bcolors.ENDC)
            continue

        player.reduce_mp(spell.cost)
        
        if spell.type == "White":
            player.heal(magic_dmg)
            print(spell.name, "Heals for", str(magic_dmg))
        elif spell.type == "black":
            enemy.take_damage(magic_dmg)
            print("You dealt magic", magic_dmg, "damage.")




    enemy_choice = 1

    enemy_damage = enemy.generate_dmg()
    player.take_damage(enemy_damage)
    print("Enemy attacked you for", enemy_damage)
    print("Player HP:", player.get_hp(), "\nEnemy HP is:", enemy.get_hp())


    if enemy.get_hp() == 0:
        running = False
        print(bcolors.OKGREEN + "You win!" + bcolors.ENDC)
    elif player.get_hp() == 0:
        running = False
        print(bcolors.FAIL + "You lost" + bcolors.ENDC)
from classes.game import Person, bcolors


magic = [{'name': 'Fire', 'cost': 10, 'dmg': 30},
         {'name': 'Electric', 'cost': 10, 'dmg': 20},
         {'name': 'Ice', 'cost': 10, 'dmg': 25}]
player = Person(100, 30, 25, 34, magic)
enemy = Person(60, 10, 15, 20, magic)

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
        print("You dealt", dmg, "damage. Enemy HP is:", enemy.get_hp())

    enemy_choice = 1
    enemy_damage = enemy.generate_dmg()
    player.take_damage(enemy_damage)
    print("Enemy attacked you for", enemy_damage, "Your HP is now:", player.get_hp(), "HP")

    running = False
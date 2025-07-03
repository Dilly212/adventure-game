print('Welcome to the Adventure Game!')
name = input('What is your name, adventurer? ')
print(f'Hello, {name}! Your quest begins now...')
choice = input('You see a fork in the road. Go left or right? (left/right): ')
if choice.lower() == 'left':
    print('You encounter a friendly dragon who gives you treasure!')
else:
    print('You fall into a trap! Game over.')

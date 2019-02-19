def get_suit (card):
    return card[1]

def get_value (card):
    try:
        return int(card[0])
    except:
        if card[0] == 'T':
            return 10
        elif card[0] == 'J':
            return 11
        elif card[0] == 'Q':
            return 12
        elif card[0] == 'K':
            return 13
        elif card[0] == 'A':
            return 14

def royal_flush (hand):
    for idx in range(0, 4):
        if get_suit(hand[idx]) != get_suit(hand[idx + 1]):
            return None
    for idx in range(0, 5):
        if get_value(hand[idx]) != idx + 10:
            return None
    return 14

def straight_flush (hand):
    for idx in range(0, 4):
        if get_suit(hand[idx]) != get_suit(hand[idx + 1]):
            return None
    for idx in range(0, 4):
        if get_value(hand[idx]) != get_value(hand[idx + 1]) - 1:
            return None
    return get_value(hand[4])

def four_of_a_kind (hand):
    match = None
    for offset in range(0, 2):
        finished = True
        for pos in range(0, 3):
            if get_value(hand[offset + pos]) != get_value(hand[offset + pos + 1]):
                finished = False
                break
        if finished:
            match = get_value(hand[offset])
    return match

def full_house (hand):
    if get_value(hand[0]) == get_value(hand[1]) \
        and get_value(hand[2]) == get_value(hand[3]) \
        and get_value(hand[3]) == get_value(hand[4]):
        return get_value(hand[4])

    if get_value(hand[0]) == get_value(hand[1]) \
        and get_value(hand[1]) == get_value(hand[2]) \
        and get_value(hand[3]) == get_value(hand[4]):
        return get_value(hand[4])

    return None

def flush (hand):
    for idx in range(0, 4):
        if get_suit(hand[idx]) != get_suit(hand[idx + 1]):
            return None
    return get_value(hand[4])

def straight (hand):
    for idx in range(0, 4):
        if get_value(hand[idx]) != get_value(hand[idx + 1]) - 1:
            return None
    return get_value(hand[4])

def three_of_a_kind (hand):
    match = None
    for offset in range(0, 3):
        finished = True
        for pos in range(0, 2):
            if get_value(hand[offset + pos]) != get_value(hand[offset + pos + 1]):
                finished = False
                break
        if finished:
            match = get_value(hand[offset])
    return match

def two_pairs (hand):
    found = []
    idx = 3
    while idx >= 0:
        if get_value(hand[idx]) == get_value(hand[idx + 1]):
            found.append(get_value(hand[idx + 1]))
            idx -= 1
        idx -= 1
    if len(found) == 2:
        return found[0]
    return None

def one_pair (hand):
    for offset in range(3, -1, -1):
        if get_value(hand[offset]) == get_value(hand[offset + 1]):
            return get_value(hand[offset + 1])
    return None

def high_card (hand):
    return get_value(hand[4])

def get_rank (hand):
    hand = sorted(hand, key = lambda card: get_value(card))
    values = sorted(list(map(lambda card: get_value(card), hand)), reverse = True)
    match = None
    priority = 10
    while match is None and priority > 0:
        if priority == 10:
            match = royal_flush(hand)
        elif priority == 9:
            match = straight_flush(hand)
        elif priority == 8:
            match = four_of_a_kind(hand)
        elif priority == 7:
            match = full_house(hand)
        elif priority == 6:
            match = flush(hand)
        elif priority == 5:
            match = straight(hand)
        elif priority == 4:
            match = three_of_a_kind(hand)
        elif priority == 3:
            match = two_pairs(hand)
        elif priority == 2:
            match = one_pair(hand)
        elif priority == 1:
            match = high_card(hand)
        priority -= 1
    rank = [priority, match] + values
    return rank

def compare (line):
    game = line.strip().split(' ')
    p1 = get_rank(game[:5])
    p2 = get_rank(game[-5:])
    for i in range(0, 7):
        if p1[i] > p2[i]:
            return True
        if p1[i] < p2[i]:
            return False
    return False


result = 0
file = open('poker.txt', 'r')
output = open('results.csv', 'w')
for line in file.readlines():
    decs = compare(line)
    if decs:
        result += 1
        output.write('1\n')
    else:
        output.write('0\n')
file.close()
output.close()
print(result)

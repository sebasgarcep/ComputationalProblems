ones = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
]

teens = [
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
]

tens = [
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
]

result = 0
for i in range(1, 1000 + 1):
    word = ''

    if i == 1000:
        word += 'one'
        word += 'thousand'
        result += len(word)
        continue

    digits = [i // 100, (i // 10) % 10, i % 10]

    if digits[0] > 0:
        word += ones[digits[0] - 1]
        word += 'hundred'
        if digits[1] > 0 or digits[2] > 0:
            word += 'and'

    if digits[1] == 0:
        if digits[2] > 0:
            word += ones[digits[2] - 1]
    elif digits[1] == 1:
        word += teens[digits[2]]
    else:
        word += tens[digits[1] - 2]
        if digits[2] > 0:
            word += ones[digits[2] - 1]

    result += len(word)

print(result)
